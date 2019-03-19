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
	<jsp:param name="title" value="acknowledgments Support" />
</jsp:include>
<style type="text/css" media="all">
@import "../resources/layout.css";
</style>

<body class="home page-template-default page page-id-6 CD2H">
	<jsp:include page="../header.jsp" flush="true" />

	<div class="container pl-0 pr-0">
		<br /> <br />
		<div class="container-fluid">
            <h1>Support Mentions</h1>
			<ack:support ID="${param.id}">
				<table>
					<tr>
						<th>Support</th>
						<td><ack:supportSupport /></td>
					</tr>
				</table>

				<c:if test="${ack:supportHasSupporter(param.id)}">
					<h4>Supporters</h4>
					<ol class="bulletedList">
						<ack:foreachSupporter var="prov" useOrganization="true"
							sortCriteria="organization">
							<ack:supporter>
								<ack:organization ID="${ack:supporterOrganizationIdValue()}">
									<li><a
										href="<util:applicationRoot/>/organization/organization.jsp?id=<ack:organizationID/>"><ack:organizationOrganization /></a>
										(PMCID: <ack:supporterPmcid />)
								</ack:organization>
							</ack:supporter>
						</ack:foreachSupporter>
					</ol>
				</c:if>

				<h4>Mentions</h4>
				<ol class="bulletedList">
					<ack:foreachSupportMention var="prov" sortCriteria="pmcid">
						<ack:supportMention>
							<li>PMCID: <a
								href="https://www.ncbi.nlm.nih.gov/pmc/articles/<ack:supportMentionPmcid/>/"><ack:supportMentionPmcid /></a>
								[<a
								href="<util:applicationRoot/>/acknowledgement/acknowledgement.jsp?pmcid=<ack:supportMentionPmcid/>">ack</a>]
							
						</ack:supportMention>
					</ack:foreachSupportMention>
				</ol>

			</ack:support>
		</div>
		<jsp:include page="../footer.jsp" flush="true" />
	</div>
</body>

</html>

