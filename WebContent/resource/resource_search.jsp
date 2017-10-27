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
                <form action="resource_search.jsp">
                Resource regular expression: <input type="text" id="expression" name="expression" size="100" value="${param.expression}">
                </form>
            <c:if test="${not empty param.expression }">
            <h3>Matching Resources</h3>
            <table>
                <tr>
                    <th>ID</th>
                    <th>Resource</th>
                </tr>
                <sql:query var="fragments" dataSource="jdbc/AcknowledgementsTagLib">
                    select id,resource
                    from pubmed_central_ack_stanford.resource
                    where resource~?
                    order by 2;
                    <sql:param>${param.expression}</sql:param>
                </sql:query>
                <c:forEach items="${fragments.rows}" var="row" varStatus="rowCounter">
                    <tr>
                        <td><a href="resource.jsp?id=${row.id}">${row.id}</td>
                        <td>${row.resource}</td>
                    </tr>
                </c:forEach>
            </table>
            </c:if>
            <jsp:include page="/footer.jsp" flush="true" /></div>
    </div>
</body>
</html>

