<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ack" uri="http://icts.uiowa.edu/AcknowledgementsTagLib"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Organic Chemical</title>
<style type="text/css" media="all">    @import "<util:applicationRoot/>/resources/style.css";</style></head>
<body>
<div id="content"><jsp:include page="/header.jsp" flush="true" /> <jsp:include page="/menu.jsp" flush="true"><jsp:param name="caller" value="research" /></jsp:include><div id="centerCol">
   <ack:organicChemical ID="${param.id}">
   <table>
    <tr><th>Organic Chemical</th><td><ack:organicChemicalOrganicChemical/></td></tr>
    <tr><th>UMLS ID</th><td><ack:organicChemicalUmlsId/></td></tr>
    <tr><th>UMLS match string</th><td><ack:organicChemicalUmlsMatchString/></td></tr>
   </table>
   <h4>Mentions</h4>
   <ol class="bulletedList">
   <ack:foreachOrganicChemicalMention var="prov" sortCriteria="pmcid">
    <ack:organicChemicalMention>
        <li>PMCID: <a href="https://www.ncbi.nlm.nih.gov/pmc/articles/<ack:organicChemicalMentionPmcid/>/"><ack:organicChemicalMentionPmcid/></a>
                    [<a href="<util:applicationRoot/>/acknowledgement/acknowledgement.jsp?pmcid=<ack:organicChemicalMentionPmcid/>">ack</a>]
    </ack:organicChemicalMention>
   </ack:foreachOrganicChemicalMention>
   </ol>

   </ack:organicChemical>

<jsp:include page="/footer.jsp" flush="true" /></div></div></body>
</html>

