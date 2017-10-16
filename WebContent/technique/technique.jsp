<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ack" uri="http://icts.uiowa.edu/AcknowledgementsTagLib"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Technique</title>
<style type="text/css" media="all">    @import "<util:applicationRoot/>/resources/style.css";</style></head>
<body>
<div id="content"><jsp:include page="/header.jsp" flush="true" /> <jsp:include page="/menu.jsp" flush="true"><jsp:param name="caller" value="research" /></jsp:include><div id="centerCol">
   <ack:technique ID="${param.id}">
   <table>
    <tr><th>Technique</th><td><ack:techniqueTechnique/></td></tr>
    <tr><th>UMLS ID</th><td><ack:techniqueUmlsId/></td></tr>
    <tr><th>UMLS match string</th><td><ack:techniqueUmlsMatchString/></td></tr>
   </table>
   
   <c:if test="${ack:techniqueHasSkill(param.id)}">
   <h4>Technique Providers</h4>
   <ol class="bulletedList">
   <ack:foreachSkill var="prov" usePerson="true" sortCriteria="last_name,first_name">
    <ack:skill>
        <ack:person ID="${ack:skillPersonIdValue()}">
            <li><a href="<util:applicationRoot/>/person/person.jsp?id=<ack:personID/>"><ack:personLastName/>, <ack:personFirstName/></a> (PMCID: <ack:skillPmcid/>)
        </ack:person>
    </ack:skill>
   </ack:foreachSkill>
   </ol>
   </c:if>

   <h4>Mentions</h4>
   <ol class="bulletedList">
   <ack:foreachTechniqueMention var="prov" sortCriteria="pmcid">
    <ack:techniqueMention>
        <li>PMCID: <a href="https://www.ncbi.nlm.nih.gov/pmc/articles/<ack:techniqueMentionPmcid/>/"><ack:techniqueMentionPmcid/></a>
                    [<a href="<util:applicationRoot/>/acknowledgement/acknowledgement.jsp?pmcid=<ack:techniqueMentionPmcid/>">ack</a>]
    </ack:techniqueMention>
   </ack:foreachTechniqueMention>
   </ol>

   </ack:technique>

<jsp:include page="/footer.jsp" flush="true" /></div></div></body>
</html>

