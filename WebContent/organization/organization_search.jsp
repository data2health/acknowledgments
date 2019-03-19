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
	<jsp:param name="title" value="acknowledgments Organization Search" />
</jsp:include>
<style type="text/css" media="all">
@import "../resources/layout.css";
</style>

<body class="home page-template-default page page-id-6 CD2H">
	<jsp:include page="../header.jsp" flush="true" />

	<div class="container pl-0 pr-0">
		<br /> <br />
		<div class="container-fluid">
            <h1>Organization Search</h1>
			<form action="organization_search.jsp">
				Organization regular expression: <input type="text" id="expression"
					name="expression" size="100" value="${param.expression}">
			</form>
			<c:if test="${not empty param.expression }">
				<h3>Matching Organizations</h3>
				<table>
					<tr>
						<th>ID</th>
						<th>Organization</th>
					</tr>
					<sql:query var="fragments" dataSource="jdbc/AcknowledgementsTagLib">
                    select id,organization
                    from pubmed_central_ack_stanford.organization
                    where organization~?
                    order by 2;
                    <sql:param>${param.expression}</sql:param>
					</sql:query>
					<c:forEach items="${fragments.rows}" var="row"
						varStatus="rowCounter">
						<tr>
							<td><a href="organization.jsp?id=${row.id}">${row.id}</td>
							<td>${row.organization}</td>
						</tr>
					</c:forEach>
				</table>
			</c:if>
		</div>
		<jsp:include page="../footer.jsp" flush="true" />
	</div>
</body>

</html>

