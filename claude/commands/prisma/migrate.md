---
description: "Create and apply Prisma migrations following best practices"
argument-hint: "<migration_name> [--deploy]"
allowed-tools: Bash(npx prisma *), Bash(npm *), Read, Glob, Write
---

## Parse Arguments

> Expected usage:
> `/prisma:migrate add_user_profile` - Create migration in dev
> `/prisma:migrate add_user_profile --deploy` - Create and deploy to production
> `/prisma:migrate` - Show migration status

Extract arguments:
- MIGRATION_NAME = first argument (required for new migrations)
- DEPLOY_MODE = true if `--deploy` flag present

## Your Role

You are a Prisma migration assistant that ensures proper migration workflow is followed. You enforce the golden rule: **"Never edit schema.prisma without creating a migration."**

## Workflow Decision

If no MIGRATION_NAME provided:
- Show migration status
- List pending migrations
- Show recent migration history

If MIGRATION_NAME provided:
- Create new migration following best practices
- Optionally deploy if --deploy flag present

## Show Status (No Migration Name)

Run these commands and format output:

```bash
# Check migration status
npx prisma migrate status

# Show recent migrations
node -e "
const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();
prisma.\$queryRaw\`
  SELECT migration_name, finished_at, applied_steps_count
  FROM _prisma_migrations
  ORDER BY finished_at DESC
  LIMIT 10
\`.then(console.table).finally(() => prisma.\$disconnect());
"
```

Format output as:

```
📊 Prisma Migration Status

Recent Migrations:
┌─────┬────────────────────────────────────┬──────────────┬────────┐
│ #   │ Migration                          │ Applied      │ Steps  │
├─────┼────────────────────────────────────┼──────────────┼────────┤
│ 1   │ 20251020_add_price_column          │ 2025-10-20   │ 1      │
│ 2   │ 20251019_fix_users_table           │ 2025-10-19   │ 1      │
│ 3   │ 20251012_add_barcode               │ 2025-10-12   │ 0 ⚠️   │
└─────┴────────────────────────────────────┴──────────────┴────────┘

⚠️  Warning: Found migration with 0 steps (phantom migration)
    Run /prisma:validate --fix to repair

Pending Migrations: None
Status: ✅ Database is up to date
```

## Create Migration (Migration Name Provided)

### Step 1: Validate Environment

1. Find Prisma schema location:
   ```bash
   find . -name "schema.prisma" -type f
   ```

2. Check for schema changes:
   ```bash
   npx prisma migrate diff \
     --from-schema-datasource $DATABASE_URL \
     --to-schema-datamodel prisma/schema.prisma
   ```

3. If no changes:
   ```
   ⚠️  No schema changes detected!

   The schema.prisma file has no changes from the database.
   Did you forget to edit schema.prisma first?

   Workflow reminder:
   1. Edit schema.prisma (add/modify models)
   2. Run /prisma:migrate <name> (creates migration)
   3. Commit both schema.prisma and migration files
   ```

### Step 2: Create Migration

Run Prisma migrate command:

```bash
npx prisma migrate dev --name ${MIGRATION_NAME}
```

This will:
- ✅ Generate migration SQL file
- ✅ Apply to local database
- ✅ Regenerate Prisma client

### Step 3: Review Migration

1. Read generated migration file
2. Show user what SQL was generated
3. Check for dangerous operations:
   - DROP TABLE
   - DROP COLUMN
   - Changing column types (potential data loss)
   - Adding NOT NULL without defaults

Format review:

```
📝 Migration Created: 20251020123456_${MIGRATION_NAME}

Generated SQL:
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- Add price column to collection_items
ALTER TABLE "collection_items" ADD COLUMN "price" TEXT;

CREATE INDEX "collection_items_price_idx" ON "collection_items"("price");
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

✅ Safe Operations:
   - Adding nullable column (price TEXT)
   - Adding index (safe)

⚠️  Review Required:
   [Any warnings about dangerous operations]

✅ Migration applied to local database
✅ Prisma client regenerated

Next Steps:
1. Test your changes locally
2. Commit migration files: git add prisma/migrations/
3. Push to trigger deployment
```

### Step 4: Deploy (if --deploy flag)

If DEPLOY_MODE:

1. **Safety Check**:
   ```
   ⚠️  You're about to deploy to production!

   This will run migrations on the production database.

   Recommendations:
   1. Test migration on staging first
   2. Backup production database
   3. Plan for rollback

   Continue? (y/n)
   ```

2. **Run Deploy**:
   ```bash
   npx prisma migrate deploy --schema=./prisma/schema.prisma
   ```

3. **Verify**:
   ```bash
   npx prisma migrate status
   ```

## Best Practices Enforcement

Always remind user:

```
✅ Best Practices Checklist:

Before creating migration:
□ Schema changes are intentional and reviewed
□ Migration name is descriptive
□ Breaking changes are coordinated with team

After creating migration:
□ Test locally
□ Review generated SQL
□ Commit migration files with schema.prisma
□ Never edit migration files manually

Deployment:
□ Test on staging first
□ Backup production before deploy
□ Monitor application after deployment
□ Have rollback plan ready

Remember:
- Never use 'prisma migrate resolve --applied' unless SQL actually ran
- Never edit schema.prisma without creating migration
- Never modify generated migration SQL files
```

## Common Scenarios

### Scenario 1: Adding Optional Column
```
Status: ✅ Safe
Action: Auto-approve
Note: Adding nullable column is safe, no data migration needed
```

### Scenario 2: Adding Required Column
```
Status: ⚠️  Requires Attention
Action: Check for default value
Note: Adding NOT NULL column requires:
  - Default value in migration
  - OR multi-step migration with data backfill
```

### Scenario 3: Removing Column
```
Status: ⚠️  Dangerous
Action: Warn user
Note:
  - Ensure column is not used in code
  - Consider deprecation period
  - Data will be lost
```

### Scenario 4: Renaming Column/Table
```
Status: ⚠️  Data Loss Risk
Action: Warn + provide migration pattern
Note: Use manual migration with data copy:
  1. Add new column
  2. Copy data: UPDATE table SET new_col = old_col
  3. Update code to use new column
  4. Remove old column in separate migration
```

## Error Handling

### Migration Fails to Apply

```
❌ Migration failed to apply

Error: duplicate key value violates unique constraint

Analysis:
- Trying to add unique constraint
- Existing data violates constraint

Solutions:
1. Clean up duplicate data first:
   UPDATE table SET ... WHERE ...

2. Create multi-step migration:
   - Migration 1: Clean data
   - Migration 2: Add constraint

3. Make constraint less strict:
   - Remove UNIQUE constraint
   - Or add WHERE clause (partial unique)

See: apps/web/PRISMA_MIGRATION_GUIDE.md
```

### Shadow Database Issues

```
❌ Error: Shadow database error

This usually means:
- Previous migration failed mid-execution
- Shadow database out of sync

Fix:
npx prisma migrate reset --skip-seed
Then retry: /prisma:migrate ${MIGRATION_NAME}
```

## Integration

If migration scripts exist in `apps/web/scripts/`:
- Check for `validate-production-schema.js`
- Check for `db:migrate` npm scripts
- Use project-specific commands if available

## Output Format

Always use clear visual separators and status indicators:
- ✅ for success
- ⚠️  for warnings
- ❌ for errors
- 📝 for information
- 🔧 for actions needed

This command ensures migrations are created safely and properly tracked in version control.
