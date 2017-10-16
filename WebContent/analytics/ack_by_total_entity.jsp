<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>PubMed Central Acknowledgements 1.0</title>
<style type="text/css" media="all">
@import "<util:applicationRoot/>/resources/style.css";
</style>
</head>
<body>
	<div id="content"><jsp:include page="/header.jsp" flush="true" />
		<jsp:include page="/menu.jsp" flush="true"><jsp:param
				name="caller" value="research" /></jsp:include><div id="centerCol">
			<h3>Acknowledgements by Total Entity Instance Count</h3>

			<table>
				<tr>
					<th>Count</th>
					<th>PMCID</th>
				</tr>
				<sql:query var="pmcids" dataSource="jdbc/AcknowledgementsTagLib">
                    select sum,pmcid
                    from pubmed_central_ack_stanford.ack_by_total_entity
                    order by sum desc limit 1000;
				</sql:query>
				<c:forEach items="${pmcids.rows}" var="row"
					varStatus="rowCounter">
					<tr>
						<td>${row.sum}</td>
						<td><a href="<util:applicationRoot/>/acknowledgement/acknowledgement.jsp?pmcid=${row.pmcid}">${row.pmcid}</a></td>
					</tr>
				</c:forEach>
			</table>
			<jsp:include page="/footer.jsp" flush="true" /></div>
	</div>
</body>
</html>

