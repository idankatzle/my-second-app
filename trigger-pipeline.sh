#!/bin/bash
# Helper script to manually trigger Konflux pipeline runs in local CRC environment
# Since GitHub webhooks cannot reach local CRC, this script creates a PipelineRun manually

set -e

# Get current git info
REVISION=$(git rev-parse HEAD)
BRANCH=$(git rev-parse --abbrev-ref HEAD)
SOURCE_URL=$(git config --get remote.origin.url)

# Generate unique pipeline run name
TIMESTAMP=$(date +%Y%m%d-%H%M%S)
RUN_NAME="my-second-app-a7690-on-push-${TIMESTAMP}"

echo "Creating pipeline run..."
echo "  Revision: $REVISION"
echo "  Branch: $BRANCH"
echo "  Source: $SOURCE_URL"
echo "  Run name: $RUN_NAME"
echo ""

# Create PipelineRun
kubectl create -f - <<EOF
apiVersion: tekton.dev/v1
kind: PipelineRun
metadata:
  name: ${RUN_NAME}
  namespace: user-ns1
  annotations:
    build.appstudio.openshift.io/repo: ${SOURCE_URL}?rev=${REVISION}
    build.appstudio.redhat.com/commit_sha: '${REVISION}'
    build.appstudio.redhat.com/target_branch: '${BRANCH}'
    pipelinesascode.tekton.dev/max-keep-runs: "3"
  labels:
    appstudio.openshift.io/application: idan-1
    appstudio.openshift.io/component: my-second-app-a7690
    pipelines.appstudio.openshift.io/type: build
spec:
  params:
  - name: git-url
    value: ${SOURCE_URL}
  - name: revision
    value: ${REVISION}
  - name: output-image
    value: quay.io/idankatzle/my-second-app:${REVISION}
  - name: dockerfile
    value: Dockerfile
  - name: path-context
    value: .
  - name: build-args
    value: []
  - name: hermetic
    value: "false"
  - name: prefetch-input
    value: ""
  - name: image-expires-after
    value: 5d
  - name: build-source-image
    value: "false"
  - name: enable-sbom-preview
    value: "true"
  - name: enable-cache-proxy
    value: "false"
  pipelineRef:
    name: docker-build-oci-ta
    bundle: quay.io/konflux-ci/tekton-catalog/pipeline-docker-build-oci-ta:latest
  taskRunTemplate:
    serviceAccountName: build-pipeline-my-second-app-a7690
  workspaces:
  - name: git-auth
    secret:
      secretName: pipelines-as-code-secret
EOF

echo ""
echo "✅ Pipeline run created: ${RUN_NAME}"
echo ""
echo "Monitor the pipeline with:"
echo "  kubectl get pipelinerun ${RUN_NAME} -n user-ns1 -w"
echo ""
echo "View logs with:"
echo "  tkn pipelinerun logs ${RUN_NAME} -n user-ns1 -f"
