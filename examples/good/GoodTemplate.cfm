<!--- Good example: Proper CFML template practices --->

<!--- Proper variable scoping and validation --->
<cfparam name="form.userName" default="">
<cfparam name="form.userAge" default="0">

<cfset variables.userName = trim(form.userName)>
<cfset variables.userAge = val(form.userAge)>

<!--- Input validation --->
<cfset variables.errors = []>

<cfif len(variables.userName) eq 0>
    <cfset arrayAppend(variables.errors, "User name is required")>
</cfif>

<cfif variables.userAge lt 1 or variables.userAge gt 120>
    <cfset arrayAppend(variables.errors, "Please enter a valid age")>
</cfif>

<!--- Process only if no errors --->
<cfif arrayLen(variables.errors) eq 0>
    
    <!--- Proper error handling and parameterized queries --->
    <cftry>
        <cfquery name="variables.getUserData" datasource="myDatabase">
            SELECT id, firstName, lastName, email, createdDate
            FROM users 
            WHERE firstName = <cfqueryparam value="#variables.userName#" cfsqltype="cf_sql_varchar">
            AND age > <cfqueryparam value="#variables.userAge#" cfsqltype="cf_sql_integer">
            ORDER BY lastName, firstName
        </cfquery>
        
        <cfcatch type="database">
            <cflog file="application" text="Database error: #cfcatch.message#" type="error">
            <cfset variables.getUserData = queryNew("id,firstName,lastName,email")>
        </cfcatch>
    </cftry>
    
    <!--- Display results with proper formatting --->
    <cfif variables.getUserData.recordCount gt 0>
        <div class="user-results">
            <h3>Found <cfoutput>#variables.getUserData.recordCount#</cfoutput> users</h3>
            
            <cfloop query="variables.getUserData">
                <div class="user-item">
                    <cfoutput>
                        <strong>#encodeForHTML(firstName)# #encodeForHTML(lastName)#</strong><br>
                        Email: #encodeForHTML(email)#<br>
                        Member since: #dateFormat(createdDate, "mm/dd/yyyy")#
                    </cfoutput>
                </div>
            </cfloop>
        </div>
    <cfelse>
        <p class="no-results">No users found matching your criteria.</p>
    </cfif>
    
<cfelse>
    <!--- Display validation errors --->
    <div class="error-messages">
        <h4>Please correct the following errors:</h4>
        <ul>
            <cfloop array="#variables.errors#" index="variables.error">
                <li><cfoutput>#encodeForHTML(variables.error)#</cfoutput></li>
            </cfloop>
        </ul>
    </div>
</cfif>
