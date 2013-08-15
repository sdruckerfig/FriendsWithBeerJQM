<cfcomponent extends="CFIDE.websocket.ChannelListener">
    <cffunction name="beforePublish" access="public">
    	<cfargument name="message" type="any">
        <cfargument name="publisherInfo" type="struct">
        
 		<cfset local.time = DateFormat(now(),"long")>
        <cfset local.message  = local.time & ": <b>" & message & "</b>">
           
        <cfreturn local.message>
     </cffunction>
</cfcomponent>