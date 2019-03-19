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
	<jsp:param name="title" value="acknowledgments Sentence Parse" />
</jsp:include>
<style type="text/css" media="all">
@import "../resources/layout.css";
</style>

<body class="home page-template-default page page-id-6 CD2H">
	<jsp:include page="../header.jsp" flush="true" />

	<div class="container pl-0 pr-0">
		<br /> <br />
		<div class="container-fluid">
            <h1>Parse of an Acknowledgement Sentence</h1>
			<sql:query var="sentences" dataSource="jdbc/AcknowledgementsTagLib">
                select sentence,parse
                from pubmed_central_ack_stanford.ack_sentence,pubmed_central_ack_stanford.ack_parse
                where ack_sentence.pmcid=ack_parse.pmcid
                  and ack_sentence.seqnum=ack_parse.seqnum
                  and ack_sentence.sentnum=ack_parse.sentnum
                  and parsenum=1
                  and ack_sentence.pmcid=?::int
                  and ack_sentence.seqnum=?::int
                  and ack_sentence.sentnum=?::int;
                <sql:param>${param.pmcid}</sql:param>
				<sql:param>${param.seqnum}</sql:param>
				<sql:param>${param.sentnum}</sql:param>
			</sql:query>
			<c:forEach items="${sentences.rows}" var="row" varStatus="rowCounter">
				<c:set var="sentence" value="${row.sentence}" />
				<c:set var="parse" value="${row.parse}" />
			</c:forEach>

			<h3>Sentence: ${sentence}</h3>

			<jsp:include page="../visualization/syntaxTree.jsp" flush="true">
				<jsp:param name="tgrep" value="${parse}" />
				<jsp:param name="width" value="800" />
				<jsp:param name="height" value="500" />
			</jsp:include>
		</div>
		<div style=" float:left; width:100%">
		  <jsp:include page="../footer.jsp" flush="true" />
		</div>
	</div>
</body>

</html>

