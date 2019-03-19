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
	<jsp:param name="title" value="acknowledgments Technique" />
</jsp:include>
<style type="text/css" media="all">
@import "../resources/layout.css";
</style>

<body class="home page-template-default page page-id-6 CD2H">
	<jsp:include page="../header.jsp" flush="true" />

	<div class="container pl-0 pr-0">
		<br /> <br />
		<div class="container-fluid">
            <h1>Technique Mentions</h1>
			<ack:technique ID="${param.id}">
				<table>
					<tr>
						<th>Technique</th>
						<td><ack:techniqueTechnique /></td>
					</tr>
					<tr>
						<th>UMLS ID</th>
						<td><ack:techniqueUmlsId /></td>
					</tr>
					<tr>
						<th>UMLS match string</th>
						<td><ack:techniqueUmlsMatchString /></td>
					</tr>
				</table>

				<c:if test="${ack:techniqueHasSkill(param.id)}">
					<h4>Technique Providers</h4>
					<ol class="bulletedList">
						<ack:foreachSkill var="prov" usePerson="true"
							sortCriteria="last_name,first_name">
							<ack:skill>
								<ack:person ID="${ack:skillPersonIdValue()}">
									<li><a
										href="<util:applicationRoot/>/person/person.jsp?id=<ack:personID/>"><ack:personLastName />,
											<ack:personFirstName /></a> (PMCID: <ack:skillPmcid />)
								</ack:person>
							</ack:skill>
						</ack:foreachSkill>
					</ol>
				</c:if>

				<h4>Mentions</h4>
				<ol class="bulletedList">
					<ack:foreachTechniqueMention var="prov" sortCriteria="pmcid">
						<ack:techniqueMention>
							<li>PMCID: <a
								href="https://www.ncbi.nlm.nih.gov/pmc/articles/<ack:techniqueMentionPmcid/>/"><ack:techniqueMentionPmcid /></a>
								[<a
								href="<util:applicationRoot/>/acknowledgement/acknowledgement.jsp?pmcid=<ack:techniqueMentionPmcid/>">ack</a>]
							
						</ack:techniqueMention>
					</ack:foreachTechniqueMention>
				</ol>

			</ack:technique>
		</div>
		<jsp:include page="../footer.jsp" flush="true" />
	</div>
</body>

</html>

