<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<!DOCTYPE html>
<html lang="en-US">
<jsp:include page="../head.jsp" flush="true">
    <jsp:param name="title" value="SciTS API" />
</jsp:include>
<style type="text/css" media="all">
@import "../resources/layout.css";
</style>

<body class="home page-template-default page page-id-6 CD2H">
    <jsp:include page="../header.jsp" flush="true" />
 	   <div class="container pl-0 pr-0">
        <br /> <br />
        <div class="container-fluid">
	
            <h3>Unbound fragments</h3>
            <table>
                <tr>
                    <th>Frequency</th>
                    <th>Fragment</th>
                </tr>
                <sql:query var="fragments" dataSource="jdbc/AcknowledgementsTagLib">
                    select fragment,frequency
                    from pubmed_central_ack_stanford.fragments
                    where fragment~'^\[NP '
                      and fragment not in (select fragment from pubmed_central_ack_stanford.template_suppress)
                      and fragment not in (select fragment from pubmed_central_ack_stanford.template_defer)
                      and fragment not in (select fragment from pubmed_central_ack_stanford.template)
                    order by 2 desc limit 1000;
                </sql:query>
                <c:forEach items="${fragments.rows}" var="row" varStatus="rowCounter">
                    <tr>
                        <td align=right>${row.frequency}</td>
                        <td><a href="generate.jsp?fragment=${row.fragment}">${row.fragment}</a></td>
                        <td><a href="suppress.jsp?fragment=${row.fragment}&?tgrep=${param.tgrep}">suppress</a></td>
                    </tr>
                </c:forEach>
            </table>
			<jsp:include page="/footer.jsp" flush="true" /></div>
	</div>
</body>
</html>

