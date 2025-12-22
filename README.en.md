* [English](README.en.md)
* [中文](README.md)  

# CFML/ColdFusion Coding Standards

A coding standards guide to keep code clean, tidy, and with clear, understandable naming.

## Table of Contents

- [Naming Conventions](#naming-conventions)
- [Code Formatting](#code-formatting)
- [Comment Standards](#comment-standards)
- [Best Practices](#best-practices)

## Naming Conventions

### Variable Naming
- Use camelCase
- Variable names should be descriptive, avoid abbreviations
```cfml
// Recommended
<cfset userName = "john_doe">
<cfset totalAmount = 1500>

// Not recommended
<cfset un = "john_doe">
<cfset amt = 1500>
```

### Function Naming
- Use camelCase
- Function names should clearly express their purpose
```cfml
// Recommended
<cffunction name="getUserById" returntype="struct">
<cffunction name="calculateTotalPrice" returntype="numeric">

// Not recommended
<cffunction name="getUser" returntype="struct">
<cffunction name="calc" returntype="numeric">
```

### Component Naming
- Use PascalCase
- File name should match component name
```cfml
// UserService.cfc
component name="UserService" {
    // Component content
}
```

## Code Formatting

### Indentation
- Use 4 spaces for indentation
- Do not use tabs

### Tag Formatting
```cfml
// Recommended - Simple tags on single line
<cfset userName = "john">

// Recommended - Complex tags on multiple lines
<cfquery name="getUsers" datasource="myDB">
    SELECT id, name, email
    FROM users
    WHERE active = 1
</cfquery>

// Recommended - Nested tags with proper indentation
<cfif isDefined("form.submit")>
    <cfloop query="users">
        <cfoutput>#users.name#</cfoutput>
    </cfloop>
</cfif>
```

### Script Formatting
```cfml
// Recommended
if (isDefined("form.submit")) {
    for (user in users) {
        writeOutput(user.name);
    }
}

// Brace on new line
function getUserData(userId) {
    var userData = {};
    
    if (isNumeric(userId)) {
        userData = queryGetRow(getUserQuery(userId), 1);
    }
    
    return userData;
}
```

## Comment Standards

### Function Comments
```cfml
/**
 * Get user information by user ID
 * @param userId User ID
 * @return User information struct
 */
<cffunction name="getUserById" returntype="struct">
    <cfargument name="userId" type="numeric" required="true">
    // Function implementation
</cffunction>
```

### Inline Comments
```cfml
// Validate user input
<cfif len(trim(form.email)) eq 0>
    <cfset errors.email = "Email cannot be empty">
</cfif>

/* 
 * Complex business logic explanation
 * Handle user permission validation here
 */
<cfset userPermissions = checkUserPermissions(session.userId)>
```

## Best Practices

### Variable Scope
```cfml
// Recommended - Explicitly specify scope
<cfset variables.userName = form.userName>
<cfset session.isLoggedIn = true>
<cfset request.pageTitle = "User Management">

// Not recommended - Unspecified scope
<cfset userName = form.userName>
```

### Query Optimization
```cfml
// Recommended - Use cfqueryparam to prevent SQL injection
<cfquery name="getUser" datasource="myDB">
    SELECT id, name, email
    FROM users
    WHERE id = <cfqueryparam value="#arguments.userId#" cfsqltype="cf_sql_integer">
</cfquery>

// Recommended - Limit query results
<cfquery name="getRecentUsers" datasource="myDB" maxrows="100">
    SELECT TOP 100 id, name, created_date
    FROM users
    ORDER BY created_date DESC
</cfquery>
```

### Error Handling
```cfml
// Recommended - Use try/catch for exception handling
<cftry>
    <cfset result = someComplexOperation()>
    <cfcatch type="any">
        <cflog file="application" text="Operation failed: #cfcatch.message#">
        <cfset result = getDefaultResult()>
    </cfcatch>
</cftry>
```

### Component Structure
```cfml
// UserService.cfc
component {
    
    // Private variables
    variables.datasource = "myDB";
    
    // Public methods
    public struct function getUserById(required numeric userId) {
        return queryGetRow(getUser(arguments.userId), 1);
    }
    
    // Private methods
    private query function getUser(required numeric userId) {
        var qUser = new Query();
        qUser.setDatasource(variables.datasource);
        qUser.setSQL("SELECT * FROM users WHERE id = :userId");
        qUser.addParam(name="userId", value=arguments.userId, cfsqltype="cf_sql_integer");
        return qUser.execute().getResult();
    }
}
```

### File Organization
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

## Code Review Checklist

- [ ] Are variable names clear and understandable
- [ ] Is scope properly used
- [ ] Are queries using cfqueryparam
- [ ] Is there appropriate error handling
- [ ] Are comments sufficient and accurate
- [ ] Is code formatting consistent
- [ ] Does it follow DRY principle (Don't Repeat Yourself)
