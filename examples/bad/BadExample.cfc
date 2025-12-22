<cfcomponent name="userservice">
    
    <!--- Bad: Global variables without proper scope --->
    <cfset ds = "myDB">
    <cfset max = 5>
    
    <!--- Bad: Poor function naming and no documentation --->
    <cffunction name="getuser" returntype="any">
        <cfargument name="id" type="any" required="false">
        
        <!--- Bad: No variable scoping --->
        <cfset result = "">
        
        <!--- Bad: SQL injection vulnerability --->
        <cfquery name="q" datasource="#ds#">
            SELECT * FROM users WHERE id = #arguments.id#
        </cfquery>
        
        <!--- Bad: No error handling --->
        <cfset result = q>
        
        <!--- Bad: Unused variable --->
        <cfset unusedVar = "test">
        
        <cfreturn result>
    </cffunction>
    
    <!--- Bad: Hardcoded credentials --->
    <cffunction name="connectDB">
        <cfset username = "admin">
        <cfset password = "password123">
        
        <!--- Bad: Using cfdump in production code --->
        <cfdump var="#username#">
        
        <!--- Bad: Using cfexecute (security risk) --->
        <cfexecute name="ls" arguments="-la" variable="output">
        
        <cfreturn true>
    </cffunction>
    
    <!--- Bad: Complex function with high cyclomatic complexity --->
    <cffunction name="processUser">
        <cfargument name="u" type="struct">
        
        <cfif isDefined("arguments.u.type")>
            <cfif arguments.u.type eq "admin">
                <cfif arguments.u.level gt 5>
                    <cfif arguments.u.active>
                        <cfif arguments.u.verified>
                            <cfset perm = "full">
                        <cfelse>
                            <cfset perm = "limited">
                        </cfif>
                    <cfelse>
                        <cfset perm = "none">
                    </cfif>
                <cfelse>
                    <cfset perm = "basic">
                </cfif>
            <cfelse>
                <cfset perm = "guest">
            </cfif>
        </cfif>
        
        <cfreturn perm>
    </cffunction>
    
</cfcomponent>
