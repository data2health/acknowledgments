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
			
           <jsp:include page="../visualization/syntaxTree.jsp" flush="true">
                <jsp:param name="tgrep" value="${param.fragment }" />
           </jsp:include>
            <div id=mode style=" float:left; width:100%">
            
            <form method='GET' action='submit.jsp'>
			<a href="suppress.jsp?fragment=${param.fragment}&tgrep=${param.pattern}">Suppress</a> | <a href="defer.jsp?fragment=${param.fragment}&tgrep=${param.pattern}">Defer</a> | <input type=submit name=submitButton value=Submit> |
			tgrep: <input type="text" id="tgrep" name="tgrep" size="100" value="">
			<input type="hidden" name="pattern" value="${param.pattern}">
            <input type="hidden" name="fragment" value="${param.fragment}">
			</div>
			
			<div id=mode style=" float:left; width:100px">
			<h4>Mode</h4>
               <sql:query var="modes" dataSource="jdbc/AcknowledgementsTagLib">
                    select mode,count(*)
                    from pubmed_central_ack_stanford.template
                    group by 1
                    order by 2 desc;
                </sql:query>
                <c:forEach items="${modes.rows}" var="row" varStatus="rowCounter">
                    <input id="mode_${row.mode}" name=mode type="radio" value="${row.mode}">${row.mode}<br>
                </c:forEach>
			</div>
            <div id=relation style=" float:left; width:150px">
            <h4>Relation</h4>
               <sql:query var="modes" dataSource="jdbc/AcknowledgementsTagLib">
                    select relation,count(*)
                    from pubmed_central_ack_stanford.template
                    where relation is not null
                    group by 1
                    order by 2 desc;
                </sql:query>
                <c:forEach items="${modes.rows}" var="row" varStatus="rowCounter">
                    <c:if test="${rowCounter.index != 0 && rowCounter.index % 9 == 0}">
                        </div><div id=relation style=" float:left; width:180px"><h4>Relation, con't.</h4>
                    </c:if>
                    <input id="relation_${row.relation}" name=relation type="radio" value="${row.relation}">${row.relation}<br>
                </c:forEach>
             </div>
            <div id=slot0 style=" float:left; width:150px">
            <h4>Slot 0</h4>
                <sql:query var="modes" dataSource="jdbc/AcknowledgementsTagLib">
                    select slot0,count(*)
                    from pubmed_central_ack_stanford.template
                    where slot0 is not null and slot0 != '1'
                    group by 1
                    order by 2 desc;
                </sql:query>
                <c:forEach items="${modes.rows}" var="row" varStatus="rowCounter">
                    <input id="slot0_${row.slot0}" name=slot0 type="radio" value="${row.slot0}">${row.slot0}<br>
                </c:forEach>
            </div>
            <div id=slot1 style=" float:left; width:150px">
            <h4>Slot 1</h4>
                 <sql:query var="modes" dataSource="jdbc/AcknowledgementsTagLib">
                    select slot1,count(*)
                    from pubmed_central_ack_stanford.template
                    where slot1 is not null
                    group by 1
                    order by 2 desc;
                </sql:query>
                <c:forEach items="${modes.rows}" var="row" varStatus="rowCounter">
                    <input id="slot1_${row.slot1}" name=slot1 type="radio" value="${row.slot1}">${row.slot1}<br>
                </c:forEach>
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
