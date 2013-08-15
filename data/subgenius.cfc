<cfcomponent extends="base">


 <cffunction name="getFaculty" access="remote" returntype="array" output="false"  returnformat="json">
	
	<cfset var q = "">
	<cfquery name="q">
		select professor.*, specialty.specialty
		from professor inner join specialty 
		  on professor.specialtyid = specialty.idspecialty
		order by lname
	</cfquery>

	<cfreturn query2array(q)>
 </cffunction>

 <cffunction name="getFaculty2" access="remote" returntype="string" output="false"  returnformat="plain">
	
	<cfset var q = "">
	<cfquery name="q">
		select professor.*, specialty.specialty
		from professor inner join specialty 
		  on professor.specialtyid = specialty.idspecialty
		order by lname
	</cfquery>

	<cfreturn serializejson(q,true)>
 </cffunction>



<cffunction name="getClasses" access="remote" returntype="struct" output="false"  returnformat="json">

  <cfset var q = "">
  <cfquery name="q">
     select curriculum.curriculum, course.*
     from curriculum inner join course
     on curriculum.idcurriculum = course.idcurriculum
     order by curriculum, coursename
  </cfquery>

  <cfset var stData = structnew()>
  <cfset var stData["items"] = arraynew(1)>
  <cfset var cd = structnew()>
  <cfset var ld = structnew()>
  <cfoutput query="q" group="curriculum">
 	<cfset cd = structnew()>
	<cfset cd["text"] = q.curriculum>
        <cfset cd["items"] = arraynew(1)>
        <cfoutput>
           <cfset ld = structnew()>
	   <cfset ld["text"] = q.coursename>
	   <cfset ld["leaf"] = true>
	   <cfset ld["courseid"] = q.idCourse>
	   <!--- 	   
	   <cfset ld["items"] = arrayNew(1)>
	   <cfset ld.items[1] = structnew()>
	   <cfset ld.items[1]["text"] = q.courseteaser>
	   <cfset ld.items[1]["courseid"] = q.idCourse>
	   <cfset ld.items[1]["leaf"] = true>
	   --->
	   <cfset arrayAppend(cd.items,ld)>
        </cfoutput>
	<cfset arrayAppend(stdata.items, cd)>
  </cfoutput>
  
 <cfreturn stdata>


</cffunction>


<cffunction name="getclassinfo" access="remote" returntype="array" output="false"  returnformat="json">
  <cfargument name="courseid" type="numeric" required="yes">

  <cfset var q = "">
  <cfquery name="q">
     select curriculum.curriculum, course.*
     from curriculum inner join course
     on curriculum.idcurriculum = course.idcurriculum
     and idcourse = <cfqueryparam cfsqltype="cf_sql_numeric" value="#arguments.courseid#">
  </cfquery>

  <cfreturn query2array(q)>
</cffunction>


<cffunction name="getclassinfojsonp" access="remote" returntype="string" output="false"  returnformat="plain">
  <cfargument name="courseid" type="numeric" required="yes">
  <cfargument name="callback" type="string" required="yes" >

  <cfset adata = getclassinfo(arguments.courseid)>
  <cfset adata = arguments.callback & "(" &  serializeJSON(aData) & ")">
    <cfcontent type="text/javascript">
    <cfreturn aData>

</cffunction>


<cffunction name="getschedule" access="remote" returntype="array" output="false" returnformat="json">
  <cfset var q = "">
  
  <cfquery name="q">
     select schedule.location, schedule.startdate, professor.fname, professor.lname, course.coursename
     from schedule inner join professor
     on schedule.idprofessor = professor.idprofessor
     inner join course on
     schedule.idcourse = course.idcourse
     order by startdate asc
  </cfquery>
  
  <cfreturn query2array(q)>
</cffunction>


<cffunction name="getschedulejsonp" access="remote" returntype="string" output="false"  returnformat="plain">
  
  <cfargument name="callback" type="string" required="yes" >

  <cfset adata = getschedule()>
  <cfset adata = arguments.callback & "(" &  serializeJSON(aData) & ")">
    <cfcontent type="text/javascript">
    <cfreturn aData>

</cffunction>



<cffunction name="getlocations" access="remote" returntype="string" output="false"  returnformat="plain">
	<cfset local.q = "">
    <cfquery name="local.q">
      select * from location
    </cfquery>
    <cfreturn serializeJson(local.q,true)>
</cffunction>

</cfcomponent>
