# CFLint Configuration Examples

Here are different `.cflintrc` configuration examples for various code quality detection requirements.

## Basic Configuration (.cflintrc.basic)
```json
{
    "rule": [],
    "excludes": ["tests/**"],
    "includes": ["**/*.cfm", "**/*.cfc"],
    "inheritParent": false
}
```

## Strict Configuration (.cflintrc.strict)
```json
{
    "rule": [
        {"name": "VariableNamingChecker", "severity": "ERROR"},
        {"name": "FunctionNamingChecker", "severity": "ERROR"},
        {"name": "ComponentNamingChecker", "severity": "ERROR"},
        {"name": "QueryParamChecker", "severity": "ERROR"},
        {"name": "GlobalVarChecker", "severity": "ERROR"},
        {"name": "VarScoper", "severity": "ERROR"},
        {"name": "CFDumpChecker", "severity": "ERROR"},
        {"name": "CFExecuteChecker", "severity": "ERROR"},
        {"name": "UnusedLocalVariableChecker", "severity": "WARNING"},
        {"name": "SQLSelectStarChecker", "severity": "WARNING"}
    ],
    "excludes": ["tests/**"],
    "includes": ["**/*.cfm", "**/*.cfc"]
}
```

## Lenient Configuration (.cflintrc.lenient)
```json
{
    "rule": [
        {"name": "QueryParamChecker", "severity": "ERROR"},
        {"name": "CFExecuteChecker", "severity": "ERROR"},
        {"name": "GlobalVarChecker", "severity": "WARNING"},
        {"name": "UnusedLocalVariableChecker", "severity": "INFO"}
    ],
    "excludes": ["tests/**", "temp/**"],
    "includes": ["**/*.cfm", "**/*.cfc"]
}
```

## Usage

1. Choose the appropriate configuration file
2. Rename it to `.cflintrc`
3. Run the detection script

```bash
# Use strict configuration
cp .cflintrc.strict .cflintrc
./run-quality-check.sh

# Use lenient configuration  
cp .cflintrc.lenient .cflintrc
./run-quality-check.sh
```

The script will automatically detect and use the `.cflintrc` configuration file.
