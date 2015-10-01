<#if executionData.job.group??>
    <#assign jobName="${executionData.project}/${executionData.job.group}/${executionData.job.name}">
<#else>
    <#assign jobName="${executionData.project}/${executionData.job.name}">
</#if>
<#if trigger == "start">
    <#assign state="Started">
<#elseif trigger == "failure">
    <#assign state="Failed">
<#else>
    <#assign state="Succeeded">
</#if>
<#assign message="<${executionData.href}|execution #${executionData.id}> of job <${executionData.job.href}|${jobName}> by ${executionData.user}">

{
   "attachments":[
      {
         "fallback":"${state}: ${message}",
         "pretext":"${state}<#if executionData.dateEndedUnixtime?has_content> in ${(executionData.dateEndedUnixtime - executionData.dateStartedUnixtime) / 1000}s</#if> ${message}",
         "color":"${color}",
         "fields":[
<#if trigger == "failure">
            {
               "title":"Failed Nodes",
               "value":"${executionData.failedNodeListString!"- (Job itself failed)"}",
               "short":false
            }
</#if>
<#if (executionData.argstring)?has_content && trigger == "failure">
            ,
</#if>
<#if (executionData.argstring)?has_content>
           {
               "title": "Options",
               "value": "${executionData.argstring}",
               "short": false
           }
</#if>
         ]
      }
   ]
}

