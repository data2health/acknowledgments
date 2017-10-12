<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<sql:update dataSource="jdbc/Acknowledgements">
    insert into pubmed_central_ack_stanford.template_suppress values(?);
    <sql:param>${param.fragment}</sql:param>
</sql:update>
<c:redirect url="browse.jsp" />
