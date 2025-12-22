# CFLint 配置示例

这里提供几种不同的 `.cflintrc` 配置示例，用于不同的代码质量检测需求。

## 基础配置 (.cflintrc.basic)
```json
{
    "rule": [],
    "excludes": ["tests/**"],
    "includes": ["**/*.cfm", "**/*.cfc"],
    "inheritParent": false
}
```

## 严格配置 (.cflintrc.strict)
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

## 宽松配置 (.cflintrc.lenient)
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

## 使用方法

1. 选择合适的配置文件
2. 重命名为 `.cflintrc`
3. 运行检测脚本

```bash
# 使用严格配置
cp .cflintrc.strict .cflintrc
./run-quality-check.sh

# 使用宽松配置  
cp .cflintrc.lenient .cflintrc
./run-quality-check.sh
```

脚本会自动检测并使用 `.cflintrc` 配置文件。
