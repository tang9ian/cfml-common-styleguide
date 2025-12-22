/**
 * Good example: User service component following coding standards
 * This component demonstrates proper CFML coding practices
 */
component name="UserService" {
    
    // Private variables with proper scope
    variables.datasource = "myDatabase";
    variables.maxRetries = 3;
    
    /**
     * Get user by ID with proper error handling
     * @param userId The user ID to retrieve
     * @return User data structure
     */
    public struct function getUserById(required numeric userId) {
        var userData = {};
        
        try {
            var userQuery = getUser(arguments.userId);
            
            if (userQuery.recordCount > 0) {
                userData = queryGetRow(userQuery, 1);
            }
        }
        catch (any exception) {
            logError("Failed to get user: " & exception.message);
            userData = getDefaultUserData();
        }
        
        return userData;
    }
    
    /**
     * Create new user with validation
     * @param userInfo User information structure
     * @return Success boolean
     */
    public boolean function createUser(required struct userInfo) {
        var isSuccess = false;
        
        // Validate required fields
        if (validateUserInfo(arguments.userInfo)) {
            try {
                var insertQuery = insertUser(arguments.userInfo);
                isSuccess = (insertQuery.recordCount > 0);
            }
            catch (any exception) {
                logError("Failed to create user: " & exception.message);
            }
        }
        
        return isSuccess;
    }
    
    // Private helper methods
    private query function getUser(required numeric userId) {
        var qUser = new Query();
        qUser.setDatasource(variables.datasource);
        qUser.setSQL("
            SELECT id, firstName, lastName, email, createdDate
            FROM users 
            WHERE id = :userId
        ");
        qUser.addParam(name="userId", value=arguments.userId, cfsqltype="cf_sql_integer");
        
        return qUser.execute().getResult();
    }
    
    private query function insertUser(required struct userInfo) {
        var qInsert = new Query();
        qInsert.setDatasource(variables.datasource);
        qInsert.setSQL("
            INSERT INTO users (firstName, lastName, email)
            VALUES (:firstName, :lastName, :email)
        ");
        qInsert.addParam(name="firstName", value=arguments.userInfo.firstName, cfsqltype="cf_sql_varchar");
        qInsert.addParam(name="lastName", value=arguments.userInfo.lastName, cfsqltype="cf_sql_varchar");
        qInsert.addParam(name="email", value=arguments.userInfo.email, cfsqltype="cf_sql_varchar");
        
        return qInsert.execute().getResult();
    }
    
    private boolean function validateUserInfo(required struct userInfo) {
        return (
            structKeyExists(arguments.userInfo, "firstName") &&
            structKeyExists(arguments.userInfo, "lastName") &&
            structKeyExists(arguments.userInfo, "email") &&
            len(trim(arguments.userInfo.email)) > 0
        );
    }
    
    private struct function getDefaultUserData() {
        return {
            "id" = 0,
            "firstName" = "",
            "lastName" = "",
            "email" = ""
        };
    }
    
    private void function logError(required string message) {
        writeLog(file="application", text=arguments.message, type="error");
    }
}
