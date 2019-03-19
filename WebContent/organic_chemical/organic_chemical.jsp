<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ack"
	uri="http://icts.uiowa.edu/AcknowledgementsTagLib"%>
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
	<jsp:param name="title" value="acknowledgments Organic Chemical" />
</jsp:include>
<style type="text/css" media="all">
@import "../resources/layout.css";
</style>

<body class="home page-template-default page page-id-6 CD2H">
	<jsp:include page="../header.jsp" flush="true" />

	<div class="container pl-0 pr-0">
		<br /> <br />
		<div class="container-fluid">
            <h1>Organic Chemical Mentions</h1>
			<ack:organicChemical ID="${param.id}">
				<table>
					<tr>
						<th>Organic Chemical</th>
						<td><ack:organicChemicalOrganicChemical /></td>
					</tr>
					<tr>
						<th>UMLS ID</th>
						<td><ack:organicChemicalUmlsId /></td>
					</tr>
					<tr>
						<th>UMLS match string</th>
						<td><ack:organicChemicalUmlsMatchString /></td>
					</tr>
				</table>
				<h4>Mentions</h4>
				<ol class="bulletedList">
					<ack:foreachOrganicChemicalMention var="prov" sortCriteria="pmcid">
						<ack:organicChemicalMention>
							<li>PMCID: <a
								href="https://www.ncbi.nlm.nih.gov/pmc/articles/<ack:organicChemicalMentionPmcid/>/"><ack:organicChemicalMentionPmcid /></a>
								[<a
								href="<util:applicationRoot/>/acknowledgement/acknowledgement.jsp?pmcid=<ack:organicChemicalMentionPmcid/>">ack</a>]
							
						</ack:organicChemicalMention>
					</ack:foreachOrganicChemicalMention>
				</ol>

			</ack:organicChemical>
		</div>
		<jsp:include page="../footer.jsp" flush="true" />
	</div>
</body>

</html>

