---
description: "Validate Prisma database schema and detect/fix migration issues (phantom migrations, schema drift)"
argument-hint: "[--fix] [--production] [DATABASE_URL]"
allowed-tools: Bash(npm *), Bash(npx *), Bash(node *), Read, Glob, Write
---

## Parse Arguments

> Expected usage:
> `/prisma:validate` - Validate local database
> `/prisma:validate --production` - Validate production database (prompts for URL)
> `/prisma:validate --fix` - Auto-fix detected issues
> `/prisma:validate --production --fix <DATABASE_URL>` - Fix production issues

Extract flags:
- FIX_MODE = true if `--fix` flag present
- PRODUCTION_MODE = true if `--production` flag present
- DATABASE_URL = provided URL or prompt user if needed

## Your Role

You are a Prisma migration doctor that detects and repairs migration issues including:
1. **Phantom Migrations** - Marked as applied but never executed (0 steps)
2. **Schema Drift** - Schema changes without migrations
3. **Missing Tables/Columns** - Database doesn't match Prisma schema
4. **Failed Migration Runner** - Migrations not running on deployment

## Detection Steps

### Step 1: Find Prisma Setup

1. Locate Prisma schema file:
   - Check `prisma/schema.prisma`
   - Check `apps/*/prisma/schema.prisma` (monorepo)

2. Find migrations directory:
   - Check `prisma/migrations/`
   - Check `apps/*/prisma/migrations/`

3. Detect environment:
   - If `--production` flag: use provided DATABASE_URL
   - Otherwise: use local DATABASE_URL from .env

### Step 2: Run Validation Script

Execute the validation script (create if doesn't exist):

```javascript
// scripts/validate-production-schema.js
const { PrismaClient } = require('@prisma/client');

const prisma = new PrismaClient({
  datasources: { db: { url: process.argv[2] || process.env.DATABASE_URL } }
});

async function validate() {
  const errors = [];

  // Check 1: Phantom Migrations (applied with 0 steps)
  const phantoms = await prisma.$queryRaw`
    SELECT migration_name, finished_at, applied_steps_count
    FROM _prisma_migrations
    WHERE applied_steps_count = 0
    ORDER BY finished_at;
  `;

  if (phantoms.length > 0) {
    errors.push({ type: 'PHANTOM_MIGRATIONS', data: phantoms });
  }

  // Check 2: Schema Drift - Compare expected vs actual
  const expectedTables = ['users', 'collection_items', 'price_checks']; // Extract from schema
  const actualTables = await prisma.$queryRaw`
    SELECT tablename FROM pg_tables WHERE schemaname='public'
  `;

  const missing = expectedTables.filter(t =>
    !actualTables.some(a => a.tablename === t)
  );

  if (missing.length > 0) {
    errors.push({ type: 'MISSING_TABLES', data: missing });
  }

  return errors;
}
```

### Step 3: Analyze Results

Report findings in this format:

```
🔍 Prisma Schema Validation
Database: [production/local] at [host:port/db]

📋 Validation Results:

[If no issues]
✅ All checks passed
✅ No phantom migrations
✅ No schema drift
✅ All tables exist

[If issues found]
❌ ISSUES DETECTED:

1. Phantom Migrations (marked applied but not executed):
   - 20251012100119_add_mobile_collection_support (0 steps)
   - 20251012141832_add_price_checks (0 steps)

2. Missing Tables:
   - collection_items
   - price_checks

3. Schema Drift (columns in schema but not in DB):
   - collection_items.price
```

## Fix Mode (if --fix enabled)

### Auto-Fix Phantom Migrations

For each phantom migration:

1. Read the migration SQL file
2. Parse and execute statements individually
3. Handle "already exists" errors gracefully
4. Verify tables/columns were created

Example:
```javascript
// Read migration file
const sql = fs.readFileSync(`prisma/migrations/${migrationName}/migration.sql`, 'utf8');

// Split into statements
const statements = sql.split(';').filter(s => s.trim().length > 0);

// Execute each
for (const stmt of statements) {
  try {
    await prisma.$executeRawUnsafe(stmt);
  } catch (e) {
    if (!e.message.includes('already exists')) throw e;
  }
}
```

### Auto-Fix Schema Drift

For columns in schema but not in database:

1. Generate ALTER TABLE statements
2. Execute with IF NOT EXISTS guards
3. Create migration file for tracking
4. Mark as applied

Example:
```sql
ALTER TABLE "collection_items" ADD COLUMN IF NOT EXISTS "price" TEXT;
```

### Create Tracking Migration

If fixing drift, create migration file:

```
prisma/migrations/[timestamp]_fix_schema_drift/migration.sql
```

Then mark as applied:
```bash
npx prisma migrate resolve --applied [migration_name]
```

## Safety Checks

Before applying fixes:

1. **Backup Check**:
   - Warn user if production
   - Recommend backup: `pg_dump $DATABASE_URL > backup.sql`

2. **Dry Run First**:
   - Show what will be executed
   - Ask for confirmation if production

3. **Transaction Safety**:
   - Wrap fixes in transactions where possible
   - Test on staging first if available

## Output Format

```
🔍 Prisma Migration Doctor

Environment: Production (crownvinyl.co)
Schema: apps/web/prisma/schema.prisma

📊 Validation Report:
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

✅ Migration Status Check
   - 9 migrations applied
   - 3 phantom migrations detected (⚠️)

❌ Phantom Migrations Found:
   1. add_mobile_collection_support (0 steps)
   2. add_price_checks (0 steps)
   3. add_barcode_and_confidence (0 steps)

❌ Schema Drift Detected:
   - collection_items.price (in schema, not in DB)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[If --fix mode]
🔧 Applying Fixes...

[1/4] Applying add_mobile_collection_support migration...
  ✅ Created collection_items table
  ✅ Created collection_photos table

[2/4] Applying add_price_checks migration...
  ✅ Created price_checks table

[3/4] Applying add_barcode_and_confidence migration...
  ✅ Added barcode column
  ✅ Added confidence column

[4/4] Fixing schema drift...
  ✅ Added price column to collection_items
  ✅ Created tracking migration

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

✅ All issues resolved!

Next steps:
1. Restart application to regenerate Prisma client
2. Verify application works correctly
3. Review apps/web/PRISMA_MIGRATION_GUIDE.md for prevention
```

## Prevention Guidance

After validation, show prevention tips:

```
💡 Prevention Tips:

1. Never edit schema.prisma without running:
   npx prisma migrate dev --name your_change

2. Never use this command unless SQL actually ran:
   npx prisma migrate resolve --applied

3. Before deployments, validate:
   npm run db:validate-prod $DATABASE_URL

4. Read the guide:
   apps/web/PRISMA_MIGRATION_GUIDE.md
```

## Integration with Existing Scripts

If validation scripts already exist (check `apps/web/scripts/`):
- Use `validate-production-schema.js` if present
- Use `apply-missing-migrations.js` for fixes if present
- Create scripts if they don't exist

## Error Recovery

If fixes fail:
- Show exact error with context
- Suggest manual intervention steps
- Provide SQL to run manually
- Link to Prisma troubleshooting docs

This command enforces proper Prisma migration hygiene and prevents production database schema issues.
