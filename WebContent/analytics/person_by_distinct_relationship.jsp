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
			<h3>Persons by Number of Distinct Relationship Types</h3>

			<table>
				<tr>
					<th>Count</th>
					<th>ID</th>
                    <th>Last Name</th>
                    <th>First Name</th>
                    <th>Middle Name</th>
                    <th>Title</th>
                    <th>Appendix</th>
				</tr>
				<sql:query var="pmcids" dataSource="jdbc/AcknowledgementsTagLib">
                    select count,id,first_name,last_name,middle_name,title,appendix
                    from pubmed_central_ack_stanford.person,pubmed_central_ack_stanford.person_by_distinct_relationship
                    where id=person_id
                    order by count desc limit 1000;
				</sql:query>
				<c:forEach items="${pmcids.rows}" var="row"
					varStatus="rowCounter">
					<tr>
						<td>${row.count}</td>
						<td><a href="<util:applicationRoot/>/person/person.jsp?id=${row.id}">${row.id}</a></td>
                        <td>${row.last_name}</td>
                        <td>${row.first_name}</td>
                        <td>${row.middle_name}</td>
                        <td>${row.title}</td>
                        <td>${row.appendix}</td>
					</tr>
				</c:forEach>
			</table>
			<jsp:include page="/footer.jsp" flush="true" /></div>
	</div>
</body>
</html>

