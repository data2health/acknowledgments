<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ack" uri="http://icts.uiowa.edu/AcknowledgementsTagLib"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Person List</title>
<style type="text/css" media="all">    @import "<util:applicationRoot/>/resources/style.css";</style></head>
<body>
<div id="content"><jsp:include page="/header.jsp" flush="true" /> <jsp:include page="/menu.jsp" flush="true"><jsp:param name="caller" value="research" /></jsp:include><div id="centerCol">
   <ack:person ID="${param.id}">
   <table>
    <tr><th>First Name</th><td><ack:personFirstName/></td></tr>
    <tr><th>Middle Name</th><td><ack:personMiddleName/></td></tr>
    <tr><th>Last Name</th><td><ack:personLastName/></td></tr>
    <tr><th>Title</th><td><ack:personTitle/></td></tr>
    <tr><th>Appendix</th><td><ack:personAppendix/></td></tr>
   </table>
   
   <c:if test="${ack:personHasInvestigator(param.id)}">
   <h4>Investigator For</h4>
   <ul>
   <ack:foreachInvestigator var="prov" useOrganization="true" sortCriteria="organization">
    <ack:investigator>
        <ack:organization ID="${ack:investigatorOrganizationIdValue()}">
            <li><a href="<util:applicationRoot/>/organization/organization.jsp?id=<ack:organizationID/>"><ack:organizationOrganization/></a> (PMCID: <ack:awardeePmcid/>)
        </ack:organization>
    </ack:investigator>
   </ack:foreachInvestigator>
   </ul>
    </c:if>
   
   <c:if test="${ack:personHasAffiliation(param.id)}">
   <h4>Affiliations</h4>
   <ul>
   <ack:foreachAffiliation var="prov" useOrganization="true" sortCriteria="organization">
    <ack:affiliation>
        <ack:organization ID="${ack:affiliationOrganizationIdValue()}">
            <li><a href="<util:applicationRoot/>/organization/organization.jsp?id=<ack:organizationID/>"><ack:organizationOrganization/></a> (PMCID: <ack:affiliationPmcid/>)
        </ack:organization>
    </ack:affiliation>
   </ack:foreachAffiliation>
   </ul>
    </c:if>
   
   <c:if test="${ack:personHasProvider(param.id)}">
   <h4>Resources Provided</h4>
   <ul>
   <ack:foreachProvider var="prov" useResource="true" sortCriteria="resource">
    <ack:provider>
        <ack:resource ID="${ack:providerResourceIdValue()}">
            <li><a href="<util:applicationRoot/>/resource/resource.jsp?id=<ack:resourceID/>"><ack:resourceResource/></a> (PMCID: <ack:providerPmcid/>)
        </ack:resource>
    </ack:provider>
   </ack:foreachProvider>
   </ul>
    </c:if>
   
   <c:if test="${ack:personHasSkill(param.id)}">
   <h4>Technique Provided</h4>
   <ul>
   <ack:foreachSkill var="prov" useTechnique="true" sortCriteria="technique">
    <ack:skill>
        <ack:technique ID="${ack:skillTechniqueIdValue()}">
            <li><a href="<util:applicationRoot/>/technique/technique.jsp?id=<ack:techniqueID/>"><ack:techniqueTechnique/></a> (PMCID: <ack:skillPmcid/>)
        </ack:technique>
    </ack:skill>
   </ack:foreachSkill>
   </ul>
   </c:if>

   <h4>Mentions</h4>
   <ul>
   <ack:foreachPersonMention var="prov" sortCriteria="pmcid">
    <ack:personMention>
        <li>PMCID: <a href="https://www.ncbi.nlm.nih.gov/pmc/articles/<ack:personMentionPmcid/>/"><ack:personMentionPmcid/></a>
    </ack:personMention>
   </ack:foreachPersonMention>
   </ul>

   </ack:person>

<jsp:include page="/footer.jsp" flush="true" /></div></div></body>
</html>

