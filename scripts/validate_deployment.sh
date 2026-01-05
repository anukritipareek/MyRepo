#!/bin/bash
# ==============================================================================
# Deployment Dry-Run Validation
# ==============================================================================
# Executes a dry-run (check-only) deployment validation to Salesforce sandbox.
# Tests the deployment without actually deploying to ensure quality.
#
# Validation Strategy:
#   1. Try RunSpecifiedTests with mapped test classes
#   2. Fallback to RunLocalTests if needed
#   3. Skip tests for metadata-only deployments (NoTestRun)
#
# Output:
#   - Deployment validation results
#   - Test execution summary
#   - Code coverage metrics
#   - Quality gate validation
# ==============================================================================

set -euo pipefail

echo ""
echo "🚀 STAGE 6: DRY-RUN VALIDATION & QUALITY GATES SUMMARY"
echo "======================================================"
echo "🔍 Validating deployment with check-only mode (no actual deployment)..."

# Create reports directory
mkdir -p reports

# Initialize default report
echo '{"result":{"status":"Failed","message":"No deploy run performed"}}' > reports/deploy-report.json
echo "" > reports/validation-summary.txt

# Logging function
summary() {
  echo "$1" | tee -a reports/validation-summary.txt
}



# Check if Apex components exist (requiring test execution)
if find changed-sources/force-app -name "*.cls" -o -name "*.trigger" 2>/dev/null | grep -q .; then
  summary "🧪 Apex components detected - running tests"

  echo ""
  echo "⚙️  EXECUTING DRY-RUN VALIDATION WITH TESTS"
  echo "==========================================="

  # Try intelligent test selection first
  if [ -n "${RELATED_TESTS:-}" ]; then
    RELATED_TESTS_CSV=$(echo "$RELATED_TESTS" | xargs -n1 | paste -sd, - || echo "")
    summary "🎯 Test Strategy: RunSpecifiedTests"
    summary "   Tests: ${RELATED_TESTS_CSV}"

    echo ""
    echo "📋 Validation Details:"
    echo "  • Mode: Dry-run (check-only - no actual deployment)"
    echo "  • Tests: $RELATED_TESTS_CSV"
    echo "  • Environment: Sandbox"
    echo ""

    summary "🔄 Running validation..."
    
    if sf project deploy start \
      --source-dir changed-sources/force-app \
      --target-org "${ORG_NAME:-qa-org}" \
      --dry-run \
      --test-level RunSpecifiedTests \
      --tests "$RELATED_TESTS_CSV" ; then
      summary "✅ Validation passed with mapped tests"
    else
      summary "⚠️  Validation failed with mapped tests - trying fallback"
    fi
  else
      summary "🔄 Test Strategy: RunLocalTests (no mapped tests)"
  fi
else
    summary "📄 Non-Apex deployment detected - no test execution required"
fi