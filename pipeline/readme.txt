# Create the file with the instructions
cat <<EOF > configs/tekton/README.md
# Tekton Pipeline Recovery Guide

This folder contains the backup files for the map-app pipeline.

## Restoration Steps

1. **Log in to OpenShift** and select your project:
   \`\`\`bash
   oc project idankatz-dev
   \`\`\`

2. **Apply the Tasks**:
   \`\`\`bash
   oc apply -f all-tasks.yaml
   \`\`\`

3. **Apply the Pipeline**:
   \`\`\`bash
   oc apply -f pipeline.yaml
   \`\`\`

4. **Verify**:
   \`\`\`bash
   oc get pipelines.tekton.dev
   \`\`\`
EOF

# Add and push to Git
git add configs/tekton/README.md
git commit -m "Add English recovery guide"
git push
