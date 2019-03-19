<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<%@ taglib prefix="ack"	uri="http://icts.uiowa.edu/AcknowledgementsTagLib"%>


<!DOCTYPE html>
<html lang="en-US">
<jsp:include page="../head.jsp" flush="true">
	<jsp:param name="title" value="acknowledgments Person" />
</jsp:include>
<style type="text/css" media="all">
@import "../resources/layout.css";
</style>

<body class="home page-template-default page page-id-6 CD2H">
	<jsp:include page="../header.jsp" flush="true" />

	<div class="container pl-0 pr-0">
		<br /> <br />
		<div class="container-fluid">
		  <h1>Person Name Mentions</h1>
			<ack:person ID="${param.id}">
				<table>
					<tr>
						<th>First Name</th>
						<td><ack:personFirstName /></td>
					</tr>
					<tr>
						<th>Middle Name</th>
						<td><ack:personMiddleName /></td>
					</tr>
					<tr>
						<th>Last Name</th>
						<td><ack:personLastName /></td>
					</tr>
					<tr>
						<th>Title</th>
						<td><ack:personTitle /></td>
					</tr>
					<tr>
						<th>Appendix</th>
						<td><ack:personAppendix /></td>
					</tr>
				</table>

				<c:if test="${ack:personHasInvestigator(param.id)}">
					<h4>Investigator For</h4>
					<ol class="bulletedList">
						<ack:foreachInvestigator var="prov" useOrganization="true"
							sortCriteria="organization">
							<ack:investigator>
								<ack:organization ID="${ack:investigatorOrganizationIdValue()}">
									<li><a
										href="<util:applicationRoot/>/organization/organization.jsp?id=<ack:organizationID/>"><ack:organizationOrganization /></a>
										(PMCID: <ack:awardeePmcid />)
								</ack:organization>
							</ack:investigator>
						</ack:foreachInvestigator>
					</ol>
				</c:if>

				<c:if test="${ack:personHasAffiliation(param.id)}">
					<h4>Affiliations</h4>
					<ol class="bulletedList">
						<ack:foreachAffiliation var="prov" useOrganization="true"
							sortCriteria="organization">
							<ack:affiliation>
								<ack:organization ID="${ack:affiliationOrganizationIdValue()}">
									<li><a
										href="<util:applicationRoot/>/organization/organization.jsp?id=<ack:organizationID/>"><ack:organizationOrganization /></a>
										(PMCID: <ack:affiliationPmcid />)
								</ack:organization>
							</ack:affiliation>
						</ack:foreachAffiliation>
					</ol>
				</c:if>

				<c:if test="${ack:personHasCollaborator(param.id)}">
					<h4>Collaborator on</h4>
					<ol class="bulletedList">
						<ack:foreachCollaborator var="prov">
							<ack:collaborator>
								<ack:collaboration
									ID="${ack:collaboratorCollaborationIdValue()}">
									<li><a
										href="<util:applicationRoot/>/acknowledgement/acknowledgement.jsp?pmcid=<ack:collaboratorPmcid/>"><ack:collaboratorPmcid /></a>
										(<ack:collaborationCollaboration />)
								</ack:collaboration>
							</ack:collaborator>
						</ack:foreachCollaborator>
					</ol>
				</c:if>

				<c:if test="${ack:personHasAwardee(param.id)}">
					<h4>Awardee on</h4>
					<ol class="bulletedList">
						<ack:foreachAwardee var="prov">
							<ack:awardee>
								<ack:award ID="${ack:awardeeAwardIdValue()}">
									<li><a
										href="<util:applicationRoot/>/award/award.jsp?id=<ack:awardeeAwardId/>"><ack:awardeeAwardId /></a>
										(<ack:awardeePmcid />)
								</ack:award>
							</ack:awardee>
						</ack:foreachAwardee>
					</ol>
				</c:if>

				<c:if test="${ack:personHasProvider(param.id)}">
					<h4>Resources Provided</h4>
					<ol class="bulletedList">
						<ack:foreachProvider var="prov" useResource="true"
							sortCriteria="resource">
							<ack:provider>
								<ack:resource ID="${ack:providerResourceIdValue()}">
									<li><a
										href="<util:applicationRoot/>/resource/resource.jsp?id=<ack:resourceID/>"><ack:resourceResource /></a>
										(PMCID: <ack:providerPmcid />)
								</ack:resource>
							</ack:provider>
						</ack:foreachProvider>
					</ol>
				</c:if>

				<c:if test="${ack:personHasSkill(param.id)}">
					<h4>Technique Provided</h4>
					<ol class="bulletedList">
						<ack:foreachSkill var="prov" useTechnique="true"
							sortCriteria="technique">
							<ack:skill>
								<ack:technique ID="${ack:skillTechniqueIdValue()}">
									<li><a
										href="<util:applicationRoot/>/technique/technique.jsp?id=<ack:techniqueID/>"><ack:techniqueTechnique /></a>
										(PMCID: <ack:skillPmcid />)
								</ack:technique>
							</ack:skill>
						</ack:foreachSkill>
					</ol>
				</c:if>

				<h4>Mentions</h4>
				<ol class="bulletedList">
					<ack:foreachPersonMention var="prov" sortCriteria="pmcid">
						<ack:personMention>
							<li>PMCID: <a
								href="https://www.ncbi.nlm.nih.gov/pmc/articles/<ack:personMentionPmcid/>/"><ack:personMentionPmcid /></a>
								[<a
								href="<util:applicationRoot/>/acknowledgement/acknowledgement.jsp?pmcid=<ack:personMentionPmcid/>">ack</a>]
							
						</ack:personMention>
					</ack:foreachPersonMention>
				</ol>

			</ack:person>
		</div>
		<jsp:include page="../footer.jsp" flush="true" />
	</div>
</body>

</html>

