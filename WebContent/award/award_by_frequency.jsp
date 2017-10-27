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
			<h3>Awards by Instance Count</h3>

			<table>
				<tr>
					<th>Count</th>
					<th>ID</th>
                    <th>Award</th>
				</tr>
				<sql:query var="awards" dataSource="jdbc/AcknowledgementsTagLib">
                    select award,award_id,count(*) as count
                    from pubmed_central_ack_stanford.award,pubmed_central_ack_stanford.award_mention
                    where award.id=award_mention.award_id
                    group by 1,2
                    order by 3 desc;
				</sql:query>
				<c:forEach items="${awards.rows}" var="row"
					varStatus="rowCounter">
					<tr>
						<td align=right>${row.count}</td>
						<td><a href="award.jsp?id=${row.award_id}">${row.award_id}</a></td>
						<td>${row.award }</td>
					</tr>
				</c:forEach>
			</table>
			<jsp:include page="/footer.jsp" flush="true" /></div>
	</div>
</body>
</html>

