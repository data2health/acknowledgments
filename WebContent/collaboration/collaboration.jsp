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
	<jsp:param name="title" value="acknowledgments Collaboration" />
</jsp:include>
<style type="text/css" media="all">
@import "../resources/layout.css";
</style>

<body class="home page-template-default page page-id-6 CD2H">
	<jsp:include page="../header.jsp" flush="true" />

	<div class="container pl-0 pr-0">
		<br /> <br />
		<div class="container-fluid">
            <h1>Extracted Collaboration Mentions</h1>
			<ack:collaboration ID="${param.id}">
				<table>
					<tr>
						<th>Collaboration</th>
						<td><ack:collaborationCollaboration /></td>
					</tr>
				</table>

				<c:if test="${ack:collaborationHasCollaborator(param.id)}">
					<h4>Collaborators</h4>
					<ol class="bulletedList">
						<ack:foreachCollaborator var="prov" usePerson="true"
							sortCriteria="last_name,first_name">
							<ack:collaborator>
								<ack:person ID="${ack:collaboratorPersonIdValue()}">
									<li><a
										href="<util:applicationRoot/>/person/person.jsp?id=<ack:personID/>"><ack:personLastName />,
											<ack:personFirstName /></a> (PMCID: <ack:collaboratorPmcid />)
								</ack:person>
							</ack:collaborator>
						</ack:foreachCollaborator>
					</ol>
				</c:if>

				<c:if test="${ack:collaborationHasCollaborant(param.id)}">
					<h4>Collaborants</h4>
					<ol class="bulletedList">
						<ack:foreachCollaborant var="prov" useCollaboration="true"
							sortCriteria="collaboration">
							<ack:collaborant>
								<ack:organization ID="${ack:collaborantOrganizationIdValue()}">
									<li><a
										href="<util:applicationRoot/>/organization/organization.jsp?id=<ack:organizationID/>"><ack:organizationOrganization /></a>
										(PMCID: <ack:collaborantPmcid />)
								</ack:organization>
							</ack:collaborant>
						</ack:foreachCollaborant>
					</ol>
				</c:if>

				<h4>Mentions</h4>
				<ol class="bulletedList">
					<ack:foreachCollaborationMention var="prov" sortCriteria="pmcid">
						<ack:collaborationMention>
							<li>PMCID: <a
								href="https://www.ncbi.nlm.nih.gov/pmc/articles/<ack:collaborationMentionPmcid/>/"><ack:collaborationMentionPmcid /></a>
								[<a
								href="<util:applicationRoot/>/acknowledgement/acknowledgement.jsp?pmcid=<ack:collaborationMentionPmcid/>">ack</a>]
							
						</ack:collaborationMention>
					</ack:foreachCollaborationMention>
				</ol>

			</ack:collaboration>
		</div>
		<jsp:include page="../footer.jsp" flush="true" />
	</div>
</body>

</html>

