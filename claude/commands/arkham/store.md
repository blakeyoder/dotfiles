---
description: "Store successful patterns, solutions, or workflows to Arkham prompt database for future reuse"
argument-hint: "<title> <description> [category] [tags...]"
allowed-tools: Bash(git rev-parse:*), Bash(pwd:*), mcp__arkham__create_prompt, mcp__arkham__get_categories, mcp__arkham__get_tags, Read, Glob, Grep
---

## Parse arguments

> Expected usage:
> `/arkham:store "NestJS Service Pattern" "Standard service implementation with DI and error handling" backend typescript nestjs`
>
> - First quoted arg: title (required)
> - Second quoted arg: description (required) 
> - Remaining args: category and tags (optional)

Extract inputs from the slash command:
1) TITLE = first quoted argument
2) DESCRIPTION = second quoted argument
3) CATEGORY = third argument (optional)
4) TAGS = remaining arguments as array (optional)

## Your role

You are an expert pattern curator who captures and stores successful development patterns for future reuse. You analyze the current context and create comprehensive prompts that preserve both the implementation details and the reasoning behind successful solutions.

## Context Analysis

Before creating the prompt, analyze the current working context:

1) **Current repository**: !`basename $(git rev-parse --show-toplevel 2>/dev/null || echo "unknown")`
2) **Working directory**: !`pwd`
3) **Recent git activity**: Check for recent commits or changes that might inform the pattern
4) **Current file context**: If applicable, examine recently modified files to understand the pattern being stored

## Arkham Integration

1) **Fetch available categories**: Use mcp__arkham__get_categories to see existing category options
2) **Fetch available tags**: Use mcp__arkham__get_tags to see existing tag options
3) **Match or suggest**: If CATEGORY is provided, try to match existing categories. If not provided, suggest appropriate category based on context.
4) **Tag normalization**: Ensure tags align with existing ones when possible

## Content Generation

Create a comprehensive prompt that includes:

### Structure
- **Title**: Use provided TITLE
- **Description**: Expand on provided DESCRIPTION with context
- **Content**: Detailed prompt that captures:
  - The specific pattern or solution
  - When to use it (context/triggers)
  - How to implement it (step-by-step)
  - Code examples if applicable
  - Common pitfalls to avoid
  - Variations or alternatives

### Context Preservation
If working in a codebase:
- Reference specific file patterns found
- Include actual code snippets that exemplify the pattern
- Note the frameworks/libraries involved
- Document the reasoning behind design decisions

### Reusability Focus
Structure the content so future users can:
- Quickly understand when to apply this pattern
- Follow clear implementation steps
- Avoid common mistakes
- Adapt the pattern to their specific context

## Implementation Steps

1) **Validate inputs**
   - Ensure TITLE and DESCRIPTION are provided
   - If missing, prompt user and stop

2) **Analyze context** 
   - Gather repository and file context
   - Look for relevant code patterns in current directory

3) **Fetch Arkham metadata**
   - Get available categories and tags
   - Suggest appropriate categorization

4) **Generate comprehensive content**
   - Create detailed prompt following structure above
   - Include concrete examples and context

5) **Store in Arkham**
   - Use mcp__arkham__create_prompt with generated content
   - Include proper categorization and tags
   - Confirm successful storage

6) **Confirmation**
   - Print success message with prompt ID and title
   - Suggest related patterns if applicable

## Output format

After successful storage, provide a brief confirmation:
```
✓ Stored pattern: [TITLE]
  ID: [arkham_prompt_id]  
  Category: [category]
  Tags: [tag1, tag2, ...]
```

## Error handling

- If Arkham is unavailable, save to local file as backup
- If categorization fails, use "general" category
- Provide clear error messages for missing required arguments