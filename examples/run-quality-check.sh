#!/bin/bash

# CFLint Code Quality Check Script
# This script runs CFLint on the examples directory and generates reports

echo "=== CFML Code Quality Check ==="
echo "Running CFLint analysis..."

# Check if CFLint jar exists
CFLINT_JAR="CFLint-all-1.5.0.jar"

if [ ! -f "$CFLINT_JAR" ]; then
    echo "Downloading CFLint..."
    wget -q https://github.com/cflint/CFLint/releases/latest/download/CFLint-all-1.5.0.jar
fi

# Create reports directory
mkdir -p reports

# Check if .cflintrc exists and validate it
CONFIG_FILE=".cflintrc"
USE_CONFIG=""

if [ -f "$CONFIG_FILE" ]; then
    echo "Found .cflintrc configuration file"
    
    # Test if config file is valid JSON
    if python3 -m json.tool "$CONFIG_FILE" > /dev/null 2>&1; then
        echo "✓ Configuration file is valid JSON"
        USE_CONFIG="-configfile $CONFIG_FILE"
    else
        echo "⚠ Configuration file has invalid JSON format, using default settings"
        USE_CONFIG=""
    fi
else
    echo "No .cflintrc found, using default CFLint rules"
fi

# Java options to handle XML parsing issues
JAVA_OPTS="-Djdk.xml.totalEntitySizeLimit=0"

echo ""
echo "=== Analyzing BAD Examples (Expected Violations) ==="
java $JAVA_OPTS -jar $CFLINT_JAR $USE_CONFIG -folder bad/ -textfile reports/bad-examples.txt -htmlfile reports/bad-examples.html

echo ""
echo "=== Analyzing GOOD Examples (Should be Clean) ==="
java $JAVA_OPTS -jar $CFLINT_JAR $USE_CONFIG -folder good/ -textfile reports/good-examples.txt -htmlfile reports/good-examples.html

echo ""
echo "=== Full Project Analysis ==="
java $JAVA_OPTS -jar $CFLINT_JAR $USE_CONFIG -folder . -textfile reports/full-analysis.txt -htmlfile reports/full-analysis.html

echo ""
echo "=== Analysis Complete ==="
echo "Reports generated in ./reports/ directory:"
echo "- bad-examples.html  : Issues found in bad examples"
echo "- good-examples.html : Issues found in good examples (should be minimal)"
echo "- full-analysis.html : Complete project analysis"

if [ -f "$CONFIG_FILE" ]; then
    echo ""
    echo "Configuration used: $CONFIG_FILE"
    echo "To modify rules, edit .cflintrc and run this script again"
fi

echo ""
echo "Open the HTML files in your browser to view detailed reports."
