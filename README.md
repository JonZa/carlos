# Carlos Ultra - Multi-Agent Coordination

**ULTRASIMPLE system for coordinating AI agents across HTML, CSS, and JavaScript tasks.**

## 🚀 Quick Start

```bash
# Setup test environment
./carlos-ultra-setup

# Create tasks for child agents
# See PARENT-INSTRUCTIONS.md for how to create tasks

# Child agents work on tasks
cd html-service && .carlos/work
cd css-service && .carlos/work  
cd js-service && .carlos/work
```

## 🎯 How It Works

**Parent Agent** creates tasks → **Child Agents** implement code → **Communication** coordinates next steps

### Task File (carlos.md):
```markdown
[ ] html-service: Create button element
[ ] css-service: Style red (after: html-service)  
[ ] js-service: Add alert (after: css-service)
```

### Child Agent Commands:
```bash
.carlos/work                                           # See your task
.carlos/work --done --implemented "what you built"    # Mark complete with communication
```

## 📋 Parent Agent Usage

**Read PARENT-INSTRUCTIONS.md for explicit task creation instructions.**

Parent agents create tasks directly in carlos.md using the exact format specified in PARENT-INSTRUCTIONS.md.

## ✅ Key Features

- **Done Pile:** Completed tasks move to bottom with implementation details
- **Dependencies:** CSS waits for HTML, JS waits for CSS  
- **Communication:** Agents tell each other what they implemented
- **No Polling:** Child agents check for work on demand

## 🔧 Files You Need

- `PARENT-INSTRUCTIONS.md` - Parent agent instructions
- `carlos-ultra-setup` - Setup test environment
- `carlos-ultra-init.sh` - Install child agents

**That's it. Ultra-simple.**