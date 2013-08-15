
<cfcomponent restpath="applicant" rest="true" extends="base">
	
    <cffunction name="getApplicants" 
    			access="remote" 
                returntype="array"
                httpMethod="get"
               >
                
		<cfquery name="local.q">
          select *
          from applicant
        </cfquery>
     
		<cfreturn query2array(local.q)>
	</cffunction>
    
    <cffunction name="getApplicant" 
    			access="remote" 
                returntype="struct"
                httpMethod="get"
                restpath="{applicantId}"
               >
               
        <cfargument 
        	name="applicantId"
            required="true"
            restargsource="Path"
            type="numeric" />
                
		<cfquery name="local.q">
          select *
          from applicant
          where applicantid = <cfqueryparam cfsqltype="cf_sql_numeric" value="#arguments.applicantid#">
        </cfquery>
     
     	<cfset local.result = query2array(local.q)>
    
		<cfreturn local.result[1]>
	</cffunction>
    
    
    <cffunction name="deleteApplicant" 
    			access="remote" 
                returntype="struct"
                httpMethod="delete"
                restpath="{applicantId}"
               >
               
        <cfargument 
        	name="applicantId"
            required="true"
            restargsource="Path"
            type="numeric" />
                
		<cfquery name="local.q">
          delete
          from applicant
          where applicantid = <cfqueryparam cfsqltype="cf_sql_numeric" value="#arguments.applicantid#">
        </cfquery>
    
		<cfreturn {applicantId = arguments.applicantId}>
	</cffunction>
    
     
    <cffunction name="createApplicant" 
    			access="remote" 
                returntype="numeric"
                httpMethod="post">
               
        <cfargument 
        	name="firstname"
            required="true"
            type="string" 
			restargsource="Form"/>
         
         <cfargument 
        	name="lastname"
            required="true"
            type="string"
            restargsource="Form"/>
        
         <cfargument 
        	name="email"
            required="true"
            type="string" 
            restargsource="Form"/>
         
          <cfargument 
        	name="hsgrad"
            required="false"
            type="boolean" 
            default="0"
            restargsource="Form"/>
          
          <cfargument 
        	name="hsgpa"
            required="true"
            type="numeric" 
            restargsource="Form"/>
           
          <cfargument 
        	name="major"
            required="true"
            type="string"
            restargsource="Form"/> 
        
        <cftransaction>        
		<cfquery>
         insert into applicant (firstname,lastname,email,hsgrad,hsgpa,major)
         values (
         	<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.firstname#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.lastname#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.email#">,
            <cfqueryparam cfsqltype="cf_sql_numeric" value="#arguments.hsgrad#">,
            <cfqueryparam cfsqltype="cf_sql_numeric" value="#arguments.hsgpa#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.major#">
         )
         </cfquery>
    
    	 <cfquery name="local.getlast">
         	select LAST_INSERT_ID() as lastid
            from applicant
    	 </cfquery>
         </cftransaction>
         
		<cfreturn local.getlast.lastid>
	</cffunction>
    
    <cffunction name="updateApplicant" 
    			access="remote" 
                returntype="struct"
                httpMethod="post"
                restpath="{applicantId}">
        
        <cfargument 
           name="applicantId" 
           required="yes"
           restargsource="Path" />  
           
        <cfargument 
        	name="firstname"
            required="true"
            type="string" 
			restargsource="Form"/>
         
         <cfargument 
        	name="lastname"
            required="true"
            type="string"
            restargsource="Form"/>
        
         <cfargument 
        	name="email"
            required="true"
            type="string" 
            restargsource="Form"/>
         
          <cfargument 
        	name="hsgrad"
            required="true"
            type="numeric" 
            restargsource="Form"/>
          
          <cfargument 
        	name="hsgpa"
            required="true"
            type="numeric" 
            restargsource="Form"/>
           
          <cfargument 
        	name="major"
            required="true"
            type="string"
            restargsource="Form"/> 
        
     
		 <cfquery>
           update applicant 
           set firstname = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.firstname#">,
               lastname = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.lastname#">,
               email =  <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.email#">,
               hsgrad = <cfqueryparam cfsqltype="cf_sql_bit" value="#arguments.hsgrad#">,
               hsgpa = <cfqueryparam cfsqltype="cf_sql_numeric" value="#arguments.hsgpa#">,
               major = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.major#">
           where applicantId = <cfqueryparam cfsqltype="cf_sql_numeric" value="#arguments.applicantId#">
         </cfquery>
    
 		<cfreturn {applicantid = arguments.applicantid}>
	</cffunction>
    
</cfcomponent>