<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ack" uri="http://icts.uiowa.edu/AcknowledgementsTagLib"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Collaboration</title>
<style type="text/css" media="all">    @import "<util:applicationRoot/>/resources/style.css";</style></head>
<body>
<div id="content"><jsp:include page="/header.jsp" flush="true" /> <jsp:include page="/menu.jsp" flush="true"><jsp:param name="caller" value="research" /></jsp:include><div id="centerCol">
   <ack:collaboration ID="${param.id}">
   <table>
    <tr><th>Collaboration</th><td><ack:collaborationCollaboration/></td></tr>
   </table>
   
   <c:if test="${ack:collaborationHasCollaborator(param.id)}">
   <h4>Collaborators</h4>
   <ol class="bulletedList">
   <ack:foreachCollaborator var="prov" usePerson="true" sortCriteria="last_name,first_name">
    <ack:collaborator>
        <ack:person ID="${ack:collaboratorPersonIdValue()}">
            <li><a href="<util:applicationRoot/>/person/person.jsp?id=<ack:personID/>"><ack:personLastName/>, <ack:personFirstName/></a> (PMCID: <ack:collaboratorPmcid/>)
        </ack:person>
    </ack:collaborator>
   </ack:foreachCollaborator>
   </ol>
   </c:if>

   <c:if test="${ack:collaborationHasCollaborant(param.id)}">
   <h4>Collaborants</h4>
   <ol class="bulletedList">
   <ack:foreachCollaborant var="prov" useCollaboration="true" sortCriteria="collaboration">
    <ack:collaborant>
        <ack:organization ID="${ack:collaborantOrganizationIdValue()}">
            <li><a href="<util:applicationRoot/>/organization/organization.jsp?id=<ack:organizationID/>"><ack:organizationOrganization/></a> (PMCID: <ack:collaborantPmcid/>)
        </ack:organization>
    </ack:collaborant>
   </ack:foreachCollaborant>
   </ol>
   </c:if>
   
   <h4>Mentions</h4>
   <ol class="bulletedList">
   <ack:foreachCollaborationMention var="prov" sortCriteria="pmcid">
    <ack:collaborationMention>
        <li>PMCID: <a href="https://www.ncbi.nlm.nih.gov/pmc/articles/<ack:collaborationMentionPmcid/>/"><ack:collaborationMentionPmcid/></a>
    </ack:collaborationMention>
   </ack:foreachCollaborationMention>
   </ol>

   </ack:collaboration>

<jsp:include page="/footer.jsp" flush="true" /></div></div></body>
</html>

