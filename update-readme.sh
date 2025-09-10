#!/bin/bash
# Script to manually update README with latest repository activity

echo "🔄 Updating README with latest repository activity..."

# Get the current date
CURRENT_DATE=$(date '+%B %d, %Y at %H:%M UTC')

# Get recent commits (last 5)
echo "📊 Fetching recent commits..."
COMMITS=$(git log --oneline -5 --pretty=format:"- \`%h\` %s (%cr)" --date=relative)

# Create backup
cp README.md README.backup

echo "📝 Updating README content..."

# Use Python to safely update the README
python3 << EOF
import re
from datetime import datetime

# Read the current README
with open('README.md', 'r') as f:
    content = f.read()

# Update the commits section
commits = """$COMMITS"""
pattern = r'(<!-- AUTO-GENERATED-COMMITS-START -->).*?(<!-- AUTO-GENERATED-COMMITS-END -->)'
replacement = r'\1\n' + commits + '\n\2'
content = re.sub(pattern, replacement, content, flags=re.DOTALL)

# Update the date - look for the pattern after "Last Updated": 
date_pattern = r'(\*\*Last Updated\*\*: )([^\\n]*)'
content = re.sub(date_pattern, r'\1$CURRENT_DATE', content)

# Write back the updated content
with open('README.md', 'w') as f:
    f.write(content)
EOF

echo "✅ README updated successfully!"
echo "Recent commits added:"
echo "$COMMITS"
echo ""
echo "Updated on: $CURRENT_DATE"