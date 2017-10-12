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
			<h3>Fragment: ${param.fragment }</h3>
			
            <div id=mode style=" float:left; width:100%">
			<a href="suppress.jsp?fragment=${param.fragment}">suppress</a>
			</div>
			
			<div id=mode style=" float:left; width:150px">
			<h4>Mode</h4>
			<input id="checkBox" type="checkbox">Instantiate<br>
			<input id="checkBox" type="checkbox">Promote<br>
			<input id="checkBox" type="checkbox">Store
			</div>
            <div id=relation style=" float:left; width:150px">
            <h4>Relation</h4>
            <input id="checkBox" type="checkbox">Person<br>
            <input id="checkBox" type="checkbox">Organization<br>
            <input id="checkBox" type="checkbox">Award
            </div>
            <div id=slot0 style=" float:left; width:150px">
            <h4>Slot 0</h4>
            <input id="checkBox" type="checkbox">person_id<br>
            <input id="checkBox" type="checkbox">organization_id<br>
            <input id="checkBox" type="checkbox">award_id
            </div>
            <div id=slot1 style=" float:left; width:150px">
            <h4>Slot 1</h4>
            <input id="checkBox" type="checkbox">person_id<br>
            <input id="checkBox" type="checkbox">organization_id<br>
            <input id="checkBox" type="checkbox">award_id
            </div>
            <div id=samples style=" float:left; width:100%">
            <h4>Highest Frequency Text Fragments</h4>
            <table>
                <tr>
                    <th>Frequency</th>
                    <th>Fragment</th>
                </tr>
                <sql:query var="fragments" dataSource="jdbc/AcknowledgementsTagLib">
                    select node,count(*) as frequency
                    from pubmed_central_ack_stanford.fragment
                    where fragment = ?
                    group by 1
                    order by 2 desc limit 10;
                    <sql:param>${param.fragment}</sql:param>
                </sql:query>
                <c:forEach items="${fragments.rows}" var="row" varStatus="rowCounter">
                    <tr>
                        <td align=right>${row.frequency}</td>
                        <td>${row.node}</td>
                    </tr>
                </c:forEach>
            </table>
            </div>
			<jsp:include page="/footer.jsp" flush="true" /></div>
	</div>
</body>
</html>

