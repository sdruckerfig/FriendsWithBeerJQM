<cfcomponent>

 <cffunction name="query2array" access="private" returntype="array" output="false">
		<cfargument name="qdata" type="query" required="yes">
		
		<cfset local.i = "0">
		<cfset local.stdata = structnew()>
		<cfset local.thiscolumn = "">
		<cfset local.aresult = arraynew(1)>
		
		<cfloop from="1" to="#qdata.recordcount#" index="i">
			<cfset local.stdata = structnew()>
			<cfloop list="#qdata.columnlist#" index="local.thiscolumn">
				<cfset stdata[lcase(local.thiscolumn)] = qdata[local.thiscolumn][i]>
			</cfloop>
			<cfset arrayAppend(local.aresult,local.stdata)>
		</cfloop>
		
		<cfreturn aResult>
 </cffunction>




<cffunction
	name="CleanHighAscii"
	access="public"
	returntype="string"
	output="false"
	hint="Cleans extended ascii values to make the as web safe as possible.">
 
	<!--- Define arguments. --->
	<cfargument
		name="Text"
		type="string"
		required="true"
		hint="The string that we are going to be cleaning."
		/>
 
	<!--- Set up local scope. --->
	<cfset var LOCAL = {} />
 
	<!---
		When cleaning the string, there are going to be ascii
		values that we want to target, but there are also going
		to be high ascii values that we don't expect. Therefore,
		we have to create a pattern that simply matches all non
		low-ASCII characters. This will find all characters that
		are NOT in the first 127 ascii values. To do this, we
		are using the 2-digit hex encoding of values.
	--->
	<cfset LOCAL.Pattern = CreateObject(
		"java",
		"java.util.regex.Pattern"
		).Compile(
			JavaCast( "string", "[^\x00-\x7F]" )
			)
		/>
 
	<!---
		Create the pattern matcher for our target text. The
		matcher will be able to loop through all the high
		ascii values found in the target string.
	--->
	<cfset LOCAL.Matcher = LOCAL.Pattern.Matcher(
		JavaCast( "string", ARGUMENTS.Text )
		) />
 
 
	<!---
		As we clean the string, we are going to need to build
		a results string buffer into which the Matcher will
		be able to store the clean values.
	--->
	<cfset LOCAL.Buffer = CreateObject(
		"java",
		"java.lang.StringBuffer"
		).Init() />
 
 
	<!--- Keep looping over high ascii values. --->
	<cfloop condition="LOCAL.Matcher.Find()">
 
		<!--- Get the matched high ascii value. --->
		<cfset LOCAL.Value = LOCAL.Matcher.Group() />
 
		<!--- Get the ascii value of our character. --->
		<cfset LOCAL.AsciiValue = Asc( LOCAL.Value ) />
 
		<!---
			Now that we have the high ascii value, we need to
			figure out what to do with it. There are explicit
			tests we can perform for our replacements. However,
			if we don't have a match, we need a default
			strategy and that will be to just store it as an
			escaped value.
		--->
 
		<!--- Check for Microsoft double smart quotes. --->
		<cfif (
			(LOCAL.AsciiValue EQ 8220) OR
			(LOCAL.AsciiValue EQ 8221)
			)>
 
			<!--- Use standard quote. --->
			<cfset LOCAL.Value = """" />
 
		<!--- Check for Microsoft single smart quotes. --->
		<cfelseif (
			(LOCAL.AsciiValue EQ 8216) OR
			(LOCAL.AsciiValue EQ 8217)
			)>
 
			<!--- Use standard quote. --->
			<cfset LOCAL.Value = "'" />
 
		<!--- Check for Microsoft elipse. --->
		<cfelseif (LOCAL.AsciiValue EQ 8230)>
 
			<!--- Use several periods. --->
			<cfset LOCAL.Value = "..." />
 
		<cfelse>
 
			<!---
				We didn't get any explicit matches on our
				character, so just store the escaped value.
			--->
			<cfset LOCAL.Value = "&###LOCAL.AsciiValue#;" />
 
		</cfif>
 
 
		<!---
			Add the cleaned high ascii character into the
			results buffer. Since we know we will only be
			working with extended values, we know that we don't
			have to worry about escaping any special characters
			in our target string.
		--->
		<cfset LOCAL.Matcher.AppendReplacement(
			LOCAL.Buffer,
			JavaCast( "string", LOCAL.Value )
			) />
 
	</cfloop>
 
	<!---
		At this point there are no further high ascii values
		in the string. Add the rest of the target text to the
		results buffer.
	--->
	<cfset LOCAL.Matcher.AppendTail(
		LOCAL.Buffer
		) />
 
 
	<!--- Return the resultant string. --->
	<cfreturn LOCAL.Buffer.ToString() />
</cffunction>


</cfcomponent>