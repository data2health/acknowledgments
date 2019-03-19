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
	<jsp:param name="title" value="acknowledgments Organization" />
</jsp:include>
<style type="text/css" media="all">
@import "../resources/layout.css";
</style>

<body class="home page-template-default page page-id-6 CD2H">
	<jsp:include page="../header.jsp" flush="true" />

	<div class="container pl-0 pr-0">
		<br /> <br />
		<div class="container-fluid">
            <h1>Organisation Mentions</h1>
			<ack:organization ID="${param.id}">
				<table>
					<tr>
						<th>Organization</th>
						<td><ack:organizationOrganization /></td>
					</tr>
					<tr>
						<th>GRID ID</th>
						<td><ack:organizationGridId /></td>
					</tr>
					<tr>
						<th>GRID match string</th>
						<td><ack:organizationGridMatchString /></td>
					</tr>
					<tr>
						<th>GeoNames ID</th>
						<td><ack:organizationGeonamesId /></td>
					</tr>
					<tr>
						<th>GeoNames match string</th>
						<td><ack:organizationGeonamesMatchString /></td>
					</tr>
				</table>

				<c:if test="${ack:organizationHasInvestigator(param.id)}">
					<h4>Investigators</h4>
					<ol class="bulletedList">
						<ack:foreachInvestigator var="prov" usePerson="true"
							sortCriteria="last_name,first_name">
							<ack:investigator>
								<ack:person ID="${ack:investigatorPersonIdValue()}">
									<li><a
										href="<util:applicationRoot/>/person/person.jsp?id=<ack:personID/>"><ack:personLastName />,
											<ack:personFirstName /></a> (PMCID: <ack:awardeePmcid />)
								</ack:person>
							</ack:investigator>
						</ack:foreachInvestigator>
					</ol>
				</c:if>

				<c:if test="${ack:organizationHasAffiliation(param.id)}">
					<h4>Affiliates</h4>
					<ol class="bulletedList">
						<ack:foreachAffiliation var="prov" usePerson="true"
							sortCriteria="last_name,first_name">
							<ack:affiliation>
								<ack:person ID="${ack:affiliationPersonIdValue()}">
									<li><a
										href="<util:applicationRoot/>/person/person.jsp?id=<ack:personID/>"><ack:personLastName />,
											<ack:personFirstName /></a> (PMCID: <ack:affiliationPmcid />)
								</ack:person>
							</ack:affiliation>
						</ack:foreachAffiliation>
					</ol>
				</c:if>

				<c:if test="${ack:organizationHasCollaborant(param.id)}">
					<h4>Collaborations</h4>
					<ol class="bulletedList">
						<ack:foreachCollaborant var="prov" useCollaboration="true"
							sortCriteria="collaboration">
							<ack:collaborant>
								<ack:collaboration ID="${ack:collaborantCollaborationIdValue()}">
									<li><a
										href="<util:applicationRoot/>/collaboration/collaboration.jsp?id=<ack:collaborationID/>"><ack:collaborationCollaboration /></a>
										(PMCID: <ack:collaborantPmcid />)
								</ack:collaboration>
							</ack:collaborant>
						</ack:foreachCollaborant>
					</ol>
				</c:if>

				<c:if test="${ack:organizationHasFunder(param.id)}">
					<h4>Awards</h4>
					<ol class="bulletedList">
						<ack:foreachFunder var="prov" useAward="true" sortCriteria="award">
							<ack:funder>
								<ack:award ID="${ack:funderAwardIdValue()}">
									<li><a
										href="<util:applicationRoot/>/award/award.jsp?id=<ack:awardID/>"><ack:awardAward /></a>
										(PMCID: <ack:funderPmcid />)
								</ack:award>
							</ack:funder>
						</ack:foreachFunder>
					</ol>
				</c:if>

				<c:if test="${ack:organizationHasSupporter(param.id)}">
					<h4>Supports</h4>
					<ol class="bulletedList">
						<ack:foreachSupporter var="prov" useSupport="true"
							sortCriteria="support">
							<ack:supporter>
								<ack:support ID="${ack:supporterSupportIdValue()}">
									<li><a
										href="<util:applicationRoot/>/support/support.jsp?id=<ack:supportID/>"><ack:supportSupport /></a>
										(PMCID: <ack:supporterPmcid />)
								</ack:support>
							</ack:supporter>
						</ack:foreachSupporter>
					</ol>
				</c:if>

				<h4>Mentions</h4>
				<ol class="bulletedList">
					<ack:foreachOrganizationMention var="prov" sortCriteria="pmcid">
						<ack:organizationMention>
							<li>PMCID: <a
								href="https://www.ncbi.nlm.nih.gov/pmc/articles/<ack:organizationMentionPmcid/>/"><ack:organizationMentionPmcid /></a>
								[<a
								href="<util:applicationRoot/>/acknowledgement/acknowledgement.jsp?pmcid=<ack:organizationMentionPmcid/>">ack</a>]
							
						</ack:organizationMention>
					</ack:foreachOrganizationMention>
				</ol>

			</ack:organization>
		</div>
		<jsp:include page="../footer.jsp" flush="true" />
	</div>
</body>

</html>

