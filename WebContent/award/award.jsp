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
	<jsp:param name="title" value="acknowledgments Award" />
</jsp:include>
<style type="text/css" media="all">
@import "../resources/layout.css";
</style>

<body class="home page-template-default page page-id-6 CD2H">
	<jsp:include page="../header.jsp" flush="true" />

	<div class="container pl-0 pr-0">
		<br /> <br />
		<div class="container-fluid">
          <h1>Extracted Award Mentions</h1>
			<ack:award ID="${param.id}">
				<table>
					<tr>
						<th>Award</th>
						<td><ack:awardAward /></td>
					</tr>
					<tr>
						<th>Agency</th>
						<td><ack:awardAgency /></td>
					</tr>
				</table>

				<c:if test="${ack:awardHasAwardee(param.id)}">
					<h4>Awardees</h4>
					<ol class="bulletedList">
						<ack:foreachAwardee var="prov" usePerson="true"
							sortCriteria="last_name,first_name">
							<ack:awardee>
								<ack:person ID="${ack:awardeePersonIdValue()}">
									<li><a
										href="<util:applicationRoot/>/person/person.jsp?id=<ack:personID/>"><ack:personLastName />,
											<ack:personFirstName /></a> (PMCID: <ack:awardeePmcid />)
								</ack:person>
							</ack:awardee>
						</ack:foreachAwardee>
					</ol>
				</c:if>

				<c:if test="${ack:awardHasFunder(param.id)}">
					<h4>Funder</h4>
					<ol class="bulletedList">
						<ack:foreachFunder var="prov" useOrganization="true"
							sortCriteria="organization">
							<ack:funder>
								<ack:organization ID="${ack:funderOrganizationIdValue()}">
									<li><a
										href="<util:applicationRoot/>/organization/organization.jsp?id=<ack:organizationID/>"><ack:organizationOrganization /></a>
										(PMCID: <ack:funderPmcid />)
								</ack:organization>
							</ack:funder>
						</ack:foreachFunder>
					</ol>
				</c:if>

				<h4>Mentions</h4>
				<ol class="bulletedList">
					<ack:foreachAwardMention var="prov" sortCriteria="pmcid">
						<ack:awardMention>
							<li>PMCID: <a
								href="https://www.ncbi.nlm.nih.gov/pmc/articles/<ack:awardMentionPmcid/>/"><ack:awardMentionPmcid /></a>
								[<a
								href="<util:applicationRoot/>/acknowledgement/acknowledgement.jsp?pmcid=<ack:awardMentionPmcid/>">ack</a>]
							
						</ack:awardMention>
					</ack:foreachAwardMention>
				</ol>

			</ack:award>
		</div>
		<jsp:include page="../footer.jsp" flush="true" />
	</div>
</body>

</html>

