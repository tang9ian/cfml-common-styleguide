* [English](README.en.md) | [中文](README.md)

# CFML/ColdFusion 编码规范

保持代码干净整洁，命名清晰易懂的编码标准指南。

## 目录

- [命名规范](#命名规范)
- [代码格式](#代码格式)
- [注释规范](#注释规范)
- [最佳实践](#最佳实践)

## 命名规范

### 变量命名
- 使用驼峰命名法（camelCase）
- 变量名应具有描述性，避免缩写
```cfml
<!--- // 推荐. --->
<cfset userName = "john_doe">
<cfset totalAmount = 1500>

<!--- // 不推荐  --->
<cfset un = "john_doe">
<cfset amt = 1500>
```

### 函数命名
- 使用驼峰命名法
- 函数名应清楚表达其功能
```cfml
<!--- // 推荐  --->
<cffunction name="getUserById" returntype="struct">
<cffunction name="calculateTotalPrice" returntype="numeric">

<!--- // 不推荐  --->
<cffunction name="getUser" returntype="struct">
<cffunction name="calc" returntype="numeric">
```

### 组件命名
- 使用帕斯卡命名法（PascalCase）
- 文件名与组件名保持一致
```cfml
// UserService.cfc
component name="UserService" {
    // 组件内容
}
```

## 代码格式

### 缩进
- 使用4个空格进行缩进
- 不使用制表符

### 标签格式
```cfml
<!--- // 推荐 - 简单标签单行   --->
<cfset userName = "john">

<!--- // 推荐 - 复杂标签多行  --->
<cfquery name="getUsers" datasource="myDB">
    SELECT id, name, email
    FROM users
    WHERE active = 1
</cfquery>

<!--- // 推荐 - 嵌套标签适当缩进  --->
<cfif isDefined("form.submit")>
    <cfloop query="users">
        <cfoutput>#users.name#</cfoutput>
    </cfloop>
</cfif>
```

### 脚本格式
```cfml
// 推荐
if (isDefined("form.submit")) {
    for (user in users) {
        writeOutput(user.name);
    }
}

// 大括号换行
function getUserData(userId) {
    var userData = {};
    
    if (isNumeric(userId)) {
        userData = queryGetRow(getUserQuery(userId), 1);
    }
    
    return userData;
}
```

## 注释规范

### 函数注释
```cfml
/**
 * 根据用户ID获取用户信息
 * @param userId 用户ID
 * @return 用户信息结构体
 */
<cffunction name="getUserById" returntype="struct">
    <cfargument name="userId" type="numeric" required="true">
    <!--- // 函数实现 --->
</cffunction>
```

### 行内注释
```cfml
<!--- // 验证用户输入. --->
<cfif len(trim(form.email)) eq 0>
    <cfset errors.email = "邮箱不能为空">
</cfif>

/* 
 * 复杂业务逻辑说明
 * 这里处理用户权限验证
 */
<cfset userPermissions = checkUserPermissions(session.userId)>
```

## 最佳实践

### 变量作用域
```cfml
<!--- // 推荐 - 明确指定作用域 --->
<cfset variables.userName = form.userName>
<cfset session.isLoggedIn = true>
<cfset request.pageTitle = "用户管理">

<!--- // 不推荐 - 未指定作用域 --->
<cfset userName = form.userName>
```

### 查询优化
```cfml
<!--- // 推荐 - 使用cfqueryparam防止SQL注入 --->
<cfquery name="getUser" datasource="myDB">
    SELECT id, name, email
    FROM users
    WHERE id = <cfqueryparam value="#arguments.userId#" cfsqltype="cf_sql_integer">
</cfquery>

<!--- // 推荐 - 限制查询结果 --->
<cfquery name="getRecentUsers" datasource="myDB" maxrows="100">
    SELECT TOP 100 id, name, created_date
    FROM users
    ORDER BY created_date DESC
</cfquery>
```

### 错误处理
```cfml
<!--- // 推荐 - 使用try/catch处理异常 --->
<cftry>
    <cfset result = someComplexOperation()>
    <cfcatch type="any">
        <cflog file="application" text="操作失败: #cfcatch.message#">
        <cfset result = getDefaultResult()>
    </cfcatch>
</cftry>
```

### 组件结构
```cfml
// UserService.cfc
component {
    
    // 私有变量
    variables.datasource = "myDB";
    
    // 公共方法
    public struct function getUserById(required numeric userId) {
        return queryGetRow(getUser(arguments.userId), 1);
    }
    
    // 私有方法
    private query function getUser(required numeric userId) {
        var qUser = new Query();
        qUser.setDatasource(variables.datasource);
        qUser.setSQL("SELECT * FROM users WHERE id = :userId");
        qUser.addParam(name="userId", value=arguments.userId, cfsqltype="cf_sql_integer");
        return qUser.execute().getResult();
    }
}
```

### 文件组织
```
/components/
    /services/
        UserService.cfc
        EmailService.cfc
    /models/
        User.cfc
        Order.cfc
/views/
    /users/
        list.cfm
        detail.cfm
/includes/
    header.cfm
    footer.cfm
```

## 代码审查清单

- [ ] 变量命名是否清晰易懂
- [ ] 是否正确使用作用域
- [ ] 查询是否使用cfqueryparam
- [ ] 是否有适当的错误处理
- [ ] 注释是否充分且准确
- [ ] 代码格式是否一致
- [ ] 是否遵循DRY原则（Don't Repeat Yourself）
