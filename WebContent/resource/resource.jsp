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
	<jsp:param name="title" value="acknowledgments Resource" />
</jsp:include>
<style type="text/css" media="all">
@import "../resources/layout.css";
</style>

<body class="home page-template-default page page-id-6 CD2H">
	<jsp:include page="../header.jsp" flush="true" />

	<div class="container pl-0 pr-0">
		<br /> <br />
		<div class="container-fluid">
            <h1>Resource Mentions</h1>
			<ack:resource ID="${param.id}">
				<table>
					<tr>
						<th>Resource</th>
						<td><ack:resourceResource /></td>
					</tr>
					<tr>
						<th>UMLS ID</th>
						<td><ack:resourceUmlsId /></td>
					</tr>
					<tr>
						<th>UMLS match string</th>
						<td><ack:resourceUmlsMatchString /></td>
					</tr>
					<tr>
						<th>alternative UMLS ID</th>
						<td><ack:resourceAltUmlsId /></td>
					</tr>
					<tr>
						<th>alternative UMLS match string</th>
						<td><ack:resourceAltUmlsMatchString /></td>
					</tr>
				</table>

				<c:if test="${ack:resourceHasProvider(param.id)}">
					<h4>Resource Providers</h4>
					<ol class="bulletedList">
						<ack:foreachProvider var="prov" usePerson="true"
							sortCriteria="last_name,first_name">
							<ack:provider>
								<ack:person ID="${ack:providerPersonIdValue()}">
									<li><a
										href="<util:applicationRoot/>/person/person.jsp?id=<ack:personID/>"><ack:personLastName />,
											<ack:personFirstName /></a> (PMCID: <ack:providerPmcid />)
								</ack:person>
							</ack:provider>
						</ack:foreachProvider>
					</ol>
				</c:if>

				<h4>Mentions</h4>
				<ol class="bulletedList">
					<ack:foreachResourceMention var="prov" sortCriteria="pmcid">
						<ack:resourceMention>
							<li>PMCID: <a
								href="https://www.ncbi.nlm.nih.gov/pmc/articles/<ack:resourceMentionPmcid/>/"><ack:resourceMentionPmcid /></a>
								[<a
								href="<util:applicationRoot/>/acknowledgement/acknowledgement.jsp?pmcid=<ack:resourceMentionPmcid/>">ack</a>]
							
						</ack:resourceMention>
					</ack:foreachResourceMention>
				</ol>

			</ack:resource>
		</div>
		<jsp:include page="../footer.jsp" flush="true" />
	</div>
</body>

</html>

