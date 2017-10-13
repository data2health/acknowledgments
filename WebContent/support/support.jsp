<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ack" uri="http://icts.uiowa.edu/AcknowledgementsTagLib"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Support</title>
<style type="text/css" media="all">    @import "<util:applicationRoot/>/resources/style.css";</style></head>
<body>
<div id="content"><jsp:include page="/header.jsp" flush="true" /> <jsp:include page="/menu.jsp" flush="true"><jsp:param name="caller" value="research" /></jsp:include><div id="centerCol">
   <ack:support ID="${param.id}">
   <table>
    <tr><th>Support</th><td><ack:supportSupport/></td></tr>
   </table>
   
   <c:if test="${ack:supportHasSupporter(param.id)}">
   <h4>Supporters</h4>
   <ul>
   <ack:foreachSupporter var="prov" useOrganization="true" sortCriteria="organization">
    <ack:supporter>
        <ack:organization ID="${ack:supporterOrganizationIdValue()}">
            <li><a href="<util:applicationRoot/>/organization/organization.jsp?id=<ack:organizationID/>"><ack:organizationOrganization/></a> (PMCID: <ack:supporterPmcid/>)
        </ack:organization>
    </ack:supporter>
   </ack:foreachSupporter>
   </ul>
   </c:if>

   <h4>Mentions</h4>
   <ul>
   <ack:foreachSupportMention var="prov" sortCriteria="pmcid">
    <ack:supportMention>
        <li>PMCID: <a href="https://www.ncbi.nlm.nih.gov/pmc/articles/<ack:supportMentionPmcid/>/"><ack:supportMentionPmcid/></a>
    </ack:supportMention>
   </ack:foreachSupportMention>
   </ul>

   </ack:support>

<jsp:include page="/footer.jsp" flush="true" /></div></div></body>
</html>

