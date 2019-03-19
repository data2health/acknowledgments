<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<%@ taglib prefix="ack"
	uri="http://icts.uiowa.edu/AcknowledgementsTagLib"%>


<!DOCTYPE html>
<html lang="en-US">
<jsp:include page="../head.jsp" flush="true">
	<jsp:param name="title" value="acknowledgments Location" />
</jsp:include>
<style type="text/css" media="all">
@import "../resources/layout.css";
</style>

<body class="home page-template-default page page-id-6 CD2H">
	<jsp:include page="../header.jsp" flush="true" />

	<div class="container pl-0 pr-0">
		<br /> <br />
		<div class="container-fluid">
            <h1>Location Mentions</h1>
			<ack:location ID="${param.id}">
				<table>
					<tr>
						<th>Location</th>
						<td><ack:locationLocation /></td>
					</tr>
					<tr>
						<th>GeoNames ID</th>
						<td><ack:locationGeonamesId /></td>
					</tr>
					<tr>
						<th>GeoNames match string</th>
						<td><ack:locationGeonamesMatchString /></td>
					</tr>
				</table>
				<h4>Mentions</h4>
				<ol class="bulletedList">
					<ack:foreachLocationMention var="prov" sortCriteria="pmcid">
						<ack:locationMention>
							<li>PMCID: <a
								href="https://www.ncbi.nlm.nih.gov/pmc/articles/<ack:locationMentionPmcid/>/"><ack:locationMentionPmcid /></a>
								[<a
								href="<util:applicationRoot/>/acknowledgement/acknowledgement.jsp?pmcid=<ack:locationMentionPmcid/>">ack</a>]
							
						</ack:locationMention>
					</ack:foreachLocationMention>
				</ol>

			</ack:location>
		</div>
		<jsp:include page="../footer.jsp" flush="true" />
	</div>
</body>

</html>

