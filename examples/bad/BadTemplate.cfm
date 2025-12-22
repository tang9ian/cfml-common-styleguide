<!--- Bad example: Poor CFML template practices --->

<!--- Bad: No proper variable scoping --->
<cfset userName = form.name>
<cfset userAge = form.age>

<!--- Bad: SQL injection vulnerability --->
<cfquery name="getUserData" datasource="myDB">
    SELECT * FROM users 
    WHERE name = '#userName#' 
    AND age > #userAge#
</cfquery>

<!--- Bad: No error handling --->
<cfloop query="getUserData">
    <!--- Bad: Inline styles and poor formatting --->
    <div style="color:red;font-size:12px;">
        <cfoutput>#name# - #email#</cfoutput>
    </div>
</cfloop>

<!--- Bad: Hardcoded values --->
<cfset maxUsers = 100>
<cfset adminEmail = "admin@company.com">

<!--- Bad: Using deprecated tags --->
<cfinclude template="header.cfm">

<!--- Bad: No validation --->
<cfif isDefined("form.submit")>
    <cfquery datasource="myDB">
        INSERT INTO logs (message, date)
        VALUES ('#form.message#', '#now()#')
    </cfquery>
</cfif>
