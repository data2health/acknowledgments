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
                  <c:set var="sentence" value="${row.sentence}"/>
                  <c:set var="parse" value="${row.parse}"/>
              </c:forEach>
              
            <h3>Sentence: ${sentence}</h3>
            
           <jsp:include page="../visualization/syntaxTree2.jsp" flush="true">
                <jsp:param name="tgrep" value="${parse}" />
           </jsp:include>
            
			<jsp:include page="/footer.jsp" flush="true" /></div>
	</div>
</body>
</html>

