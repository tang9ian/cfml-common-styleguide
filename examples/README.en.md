* [English](README.en.md) | [中文](README.md)  

# Code Quality Detection Examples

This directory contains CFML code quality detection examples using the CFLint tool for static code analysis.

## Directory Structure

```
examples/
├── good/           # Examples following coding standards
├── bad/            # Examples violating coding standards  
├── tests/          # Test cases
├── .cflintrc       # CFLint configuration file
└── README.md       # Documentation
```

## Usage

### 1. Install CFLint
```bash
# Download CFLint
wget https://github.com/cflint/CFLint/releases/download/CFLint-1.5.0/CFLint-1.5.0-all.jar

# Or use CommandBox
box install cflint
```

### 2. Run Detection
```bash
# Check single file
java -jar CFLint-1.5.0-all.jar -file examples/bad/BadExample.cfc

# Check entire directory
java -jar CFLint-1.5.0-all.jar -folder examples/

# Generate HTML report
java -jar CFLint-1.5.0-all.jar -folder examples/ -html cflint-report.html
```

### 3. View Results
- Console output: Direct problem display
- HTML report: Detailed visual report
- XML output: For CI/CD integration

## Covered Standards

- ✅ Variable naming conventions
- ✅ Function naming conventions  
- ✅ Component naming conventions
- ✅ Scope usage
- ✅ SQL injection protection
- ✅ Error handling
- ✅ Code complexity
- ✅ Unused variables
- ✅ Hard-coded value detection
