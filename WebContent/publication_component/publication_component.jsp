<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ack" uri="http://icts.uiowa.edu/AcknowledgementsTagLib"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Publication Component</title>
<style type="text/css" media="all">    @import "<util:applicationRoot/>/resources/style.css";</style></head>
<body>
<div id="content"><jsp:include page="/header.jsp" flush="true" /> <jsp:include page="/menu.jsp" flush="true"><jsp:param name="caller" value="research" /></jsp:include><div id="centerCol">
   <ack:publicationComponent ID="${param.id}">
   <table>
    <tr><th>Publication Component</th><td><ack:publicationComponentPublicationComponent/></td></tr>
   </table>
   <h4>Mentions</h4>
   <ol class="bulletedList">
   <ack:foreachPublicationComponentMention var="prov" sortCriteria="pmcid">
    <ack:publicationComponentMention>
        <li>PMCID: <a href="https://www.ncbi.nlm.nih.gov/pmc/articles/<ack:publicationComponentMentionPmcid/>/"><ack:publicationComponentMentionPmcid/></a>
    </ack:publicationComponentMention>
   </ack:foreachPublicationComponentMention>
   </ol>

   </ack:publicationComponent>

<jsp:include page="/footer.jsp" flush="true" /></div></div></body>
</html>

