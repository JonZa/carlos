#!/bin/bash
# Carlos Ultra - ULTRASIMPLE Multi-Agent Coordination
# The foolproof version

set -e

echo "🚀 Carlos Ultra Installer"
echo "========================"

# Get agent name from directory name
AGENT_NAME=$(basename "$(pwd)")
echo "📦 Agent name: $AGENT_NAME"

# Find carlos.md by searching upward (max 5 levels)
CARLOS_PATH=""
CURRENT_DIR=$(pwd)

for i in {1..5}; do
    if [ -f "$CURRENT_DIR/carlos.md" ]; then
        CARLOS_PATH="$CURRENT_DIR/carlos.md"
        echo "✅ Found carlos.md at: $CARLOS_PATH"
        break
    fi
    CURRENT_DIR=$(dirname "$CURRENT_DIR")
done

if [ -z "$CARLOS_PATH" ]; then
    echo "❌ Error: carlos.md not found in parent directories (searched 5 levels up)"
    echo "   Please ensure carlos.md exists in a parent directory of this repository"
    exit 1
fi

# Calculate relative path to carlos.md
RELATIVE_PATH=$(realpath --relative-to="$(pwd)" "$CARLOS_PATH")

# Create .carlos directory
mkdir -p .carlos

# Create the ONE command that does everything
cat > .carlos/work << EOF
#!/bin/bash
# Carlos Ultra - One command for everything

AGENT="$AGENT_NAME"
CARLOS="$RELATIVE_PATH"

# Check for non-interactive mode and extract implementation description
INTERACTIVE=true
IMPLEMENTATION=""
if [ "\$1" = "--done" ] || [ "\$1" = "-d" ]; then
    INTERACTIVE=false
    # Check for --implemented flag
    if [ "\$2" = "--implemented" ] && [ -n "\$3" ]; then
        IMPLEMENTATION="\$3"
    fi
fi

echo "🤖 \$AGENT checking for work..."
echo ""

# Find next task for this agent
while IFS= read -r line; do
    if [[ \$line == *"[ ] \$AGENT:"* ]]; then
        # Check dependencies
        if [[ \$line == *"(after:"* ]]; then
            DEP=\$(echo "\$line" | sed 's/.*(after: \\([^)]*\\)).*/\\1/')
            if ! grep -q "\\[x\\] \$DEP:" "\$CARLOS"; then
                echo "⏳ Waiting for \$DEP to finish first"
                echo ""
                echo "Current status:"
                grep "\$DEP:" "\$CARLOS" || echo "   \$DEP: not found"
                exit 0
            fi
        fi
        
        # Show the task
        TASK=\$(echo "\$line" | sed "s/\\[ \\] \$AGENT: //" | sed 's/ (after:[^)]*)//') 
        echo "📋 YOUR TASK:"
        echo "   \$TASK"
        echo ""
        
        if [ "\$INTERACTIVE" = "false" ]; then
            # Non-interactive mode with optional communication
            ORIGINAL_TASK=\$(grep "\\[ \\] \$AGENT:" "\$CARLOS" | head -n1)
            if [ -n "\$IMPLEMENTATION" ]; then
                COMPLETED_TASK=\$(echo "\$ORIGINAL_TASK" | sed "s/\\[ \\]/\\[x\\]/" | sed "s/\$/ (DONE: \$IMPLEMENTATION)/")
                echo "✅ TASK MARKED DONE with communication: \$IMPLEMENTATION"
            else
                COMPLETED_TASK=\$(echo "\$ORIGINAL_TASK" | sed "s/\\[ \\]/\\[x\\]/")
                echo "✅ TASK MARKED DONE! (non-interactive mode)"
            fi
            grep -v "\\[ \\] \$AGENT:" "\$CARLOS" > "\$CARLOS.tmp"
            mv "\$CARLOS.tmp" "\$CARLOS"
            echo "\$COMPLETED_TASK" >> "\$CARLOS"
            echo ""
            echo "🎉 Next agent can now proceed..."
        else
            # Interactive mode
            echo "🚨 HAVE YOU IMPLEMENTED THIS? (created the actual files?)"
            echo ""
            echo "Choose an option:"
            echo "   1) YES - I implemented it, mark as DONE"
            echo "   2) NO - I'll check back later"
            echo ""
            echo -n "Enter 1 or 2: "
            
            read -r choice
            case "\$choice" in
                1)
                    # Mark as completed with communication and move to bottom
                    echo ""
                    echo "🎉 What did you implement? (brief description for other agents)"
                    echo "   Example: 'Created button with id=submit-btn' or 'Added red styling to .banner'"
                    echo -n "📝 Implementation: "
                    read -r IMPLEMENTATION
                    
                    ORIGINAL_TASK=\$(grep "\\[ \\] \$AGENT:" "\$CARLOS" | head -n1)
                    COMPLETED_TASK=\$(echo "\$ORIGINAL_TASK" | sed "s/\\[ \\]/\\[x\\]/" | sed "s/\$/ (DONE: \$IMPLEMENTATION)/")
                    grep -v "\\[ \\] \$AGENT:" "\$CARLOS" > "\$CARLOS.tmp"
                    mv "\$CARLOS.tmp" "\$CARLOS"
                    echo "\$COMPLETED_TASK" >> "\$CARLOS"
                    echo ""
                    echo "✅ TASK MARKED DONE! Great work!"
                    echo ""
                    echo "🎉 Next agent can now proceed..."
                    ;;
                2)
                    echo ""
                    echo "👍 No problem! Run .carlos/work again when ready"
                    ;;
                *)
                    echo ""
                    echo "❌ Please enter 1 or 2"
                    echo "   1 = Mark done"
                    echo "   2 = Check later" 
                    ;;
            esac
        fi
        exit 0
    fi
done < "\$CARLOS"

echo "✅ No pending tasks for \$AGENT"
echo ""
echo "All done or waiting for other agents!"
EOF

chmod +x .carlos/work

# Create a simple status check command
cat > .carlos/status << EOF
#!/bin/bash
# Show all tasks and their status

CARLOS="$RELATIVE_PATH"

echo "📋 Carlos Ultra Status"
echo "====================="
echo ""

while IFS= read -r line; do
    if [[ \$line == *"[ ]"* ]]; then
        echo "⏳ TODO: \$line"
    elif [[ \$line == *"[x]"* ]]; then
        echo "✅ DONE: \$line"
    fi
done < "\$CARLOS"
EOF

chmod +x .carlos/status

# Create CLAUDE.md for AI agents
cat > CLAUDE.md << EOF
# 🤖 CARLOS ULTRA - ULTRASIMPLE Multi-Agent System

**YOU ARE AGENT: \`$AGENT_NAME\`**

## 🚨 ONLY ONE COMMAND:

\`\`\`bash
.carlos/work
\`\`\`

## 📋 EXACT WORKFLOW FOR AI AGENTS:

\`\`\`bash
# 1. See your task
.carlos/work

# 2. Read your task (e.g., "Create index.html with 'bloop bloop'")

# 3. ACTUALLY CREATE THE FILES! 
#    - Write the actual code files
#    - Save them to disk

# 4. Mark as done (AI agents use non-interactive mode)
.carlos/work --done

# 5. Done! Next agent can proceed
\`\`\`

## 🤖 AI AGENT COMMANDS:

- \`.carlos/work\` - See your task
- \`.carlos/work --done\` - Mark task complete (after implementing)

## ⚠️ CRITICAL: 

**"Mark as DONE" means you ACTUALLY WROTE THE CODE!**

- ✅ Created index.html with "bloop bloop" → Run \`.carlos/work --done\`
- ✅ Created styles.css with monospace font → Run \`.carlos/work --done\`
- ✅ Created main.js with console.log → Run \`.carlos/work --done\`
- ❌ Just read the task but didn't code → Don't mark done yet

## 🔍 Check Status:
\`\`\`bash
.carlos/status    # See all tasks
\`\`\`

**REMEMBER: Only use --done if you actually implemented the code!**
EOF

echo ""
echo "✅ Carlos Ultra installed!"
echo ""
echo "🤖 FOR AI AGENTS:"
echo "   1. See your task: .carlos/work"
echo "   2. Implement the code (create files)"  
echo "   3. Mark done: .carlos/work --done"
echo ""
echo "📊 To see all tasks: .carlos/status"
echo "📁 Agent: $AGENT_NAME"
echo "📍 Carlos file: $RELATIVE_PATH"
echo ""
echo "💡 Start with: .carlos/work"