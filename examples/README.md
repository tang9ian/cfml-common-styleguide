* [English](README.en.md) | [中文](README.md)  

# 代码质量检测示例

本目录包含CFML代码质量检测的示例，使用CFLint工具进行静态代码分析。

## 目录结构

```
examples/
├── good/           # 符合编码规范的示例
├── bad/            # 违反编码规范的示例  
├── tests/          # 测试用例
├── .cflintrc       # CFLint配置文件
└── README.md       # 说明文档
```

## 使用方法

### 1. 安装CFLint
```bash
# 下载CFLint
wget https://github.com/cflint/CFLint/releases/download/CFLint-1.5.0/CFLint-1.5.0-all.jar

# 或使用CommandBox
box install cflint
```

### 2. 运行检测
```bash
# 检测单个文件
java -jar CFLint-1.5.0-all.jar -file examples/bad/BadExample.cfc

# 检测整个目录
java -jar CFLint-1.5.0-all.jar -folder examples/

# 生成HTML报告
java -jar CFLint-1.5.0-all.jar -folder examples/ -html cflint-report.html
```

### 3. 查看结果
- 控制台输出：直接显示问题
- HTML报告：详细的可视化报告
- XML输出：用于CI/CD集成

## 测试覆盖的规范

- ✅ 变量命名规范
- ✅ 函数命名规范  
- ✅ 组件命名规范
- ✅ 作用域使用
- ✅ SQL注入防护
- ✅ 错误处理
- ✅ 代码复杂度
- ✅ 未使用变量
- ✅ 硬编码值检测
