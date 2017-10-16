<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ack" uri="http://icts.uiowa.edu/AcknowledgementsTagLib"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Funding Agency</title>
<style type="text/css" media="all">    @import "<util:applicationRoot/>/resources/style.css";</style></head>
<body>
<div id="content"><jsp:include page="/header.jsp" flush="true" /> <jsp:include page="/menu.jsp" flush="true"><jsp:param name="caller" value="research" /></jsp:include><div id="centerCol">
   <ack:fundingAgency ID="${param.id}">
   <table>
    <tr><th>Funding Agency</th><td><ack:fundingAgencyFundingAgency/></td></tr>
   </table>
   <h4>Mentions</h4>
   <ol class="bulletedList">
   <ack:foreachFundingAgencyMention var="prov" sortCriteria="pmcid">
    <ack:fundingAgencyMention>
        <li>PMCID: <a href="https://www.ncbi.nlm.nih.gov/pmc/articles/<ack:fundingAgencyMentionPmcid/>/"><ack:fundingAgencyMentionPmcid/></a>
                    [<a href="<util:applicationRoot/>/acknowledgement/acknowledgement.jsp?pmcid=<ack:fundingAgencyMentionPmcid/>">ack</a>]
    </ack:fundingAgencyMention>
   </ack:foreachFundingAgencyMention>
   </ol>

   </ack:fundingAgency>

<jsp:include page="/footer.jsp" flush="true" /></div></div></body>
</html>

