# PARENT AGENT INSTRUCTIONS (CANNOT FUCK UP)

## YOUR JOB: CREATE TASKS IN carlos.md

1. READ the user request
2. WRITE 3 tasks to carlos.md in EXACT format below
3. DONE

## EXACT FORMAT (COPY THIS):

```
## Request: [user request]
Created: [current date]

[ ] html-service: [specific HTML task]
[ ] css-service: [specific CSS task] (after: html-service)
[ ] js-service: [specific JavaScript task] (after: css-service)

```

## EXAMPLES:

**User:** "add a button, make buttons blue, make buttons alert bloop"

**YOU WRITE:**
```
## Request: add a button, make buttons blue, make buttons alert bloop
Created: Sat Jul 5 12:45:00 PM AEST 2025

[ ] html-service: Create button element with text
[ ] css-service: Style button with blue background and hover effects (after: html-service)
[ ] js-service: Add click event listener that shows alert('bloop') (after: css-service)

```

**User:** "create a red navigation menu with hover effects"

**YOU WRITE:**
```
## Request: create a red navigation menu with hover effects
Created: Sat Jul 5 12:45:00 PM AEST 2025

[ ] html-service: Create navigation structure with menu items
[ ] css-service: Style navigation with red colors and hover effects (after: html-service)
[ ] js-service: Add mobile menu toggle functionality (after: css-service)

```

## RULES:
- NEVER run scripts or commands
- ONLY edit carlos.md directly
- USE EXACT format above
- MAKE tasks specific and actionable
- HTML = structure, CSS = styling, JS = behavior
- ALWAYS include the blank line after tasks