<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>


<!DOCTYPE html>
<html lang="en-US">
<jsp:include page="head.jsp" flush="true">
    <jsp:param name="title" value="CD2H Analytics" />
</jsp:include>
<style type="text/css" media="all">
@import "resources/layout.css";
</style>

<body class="home page-template-default page page-id-6 CD2H">
    <jsp:include page="header.jsp" flush="true" />

    <div class="container pl-0 pr-0">
        <br/> <br/>
        <div class="container-fluid">
The acknowledgement sections of journal articles are a rich source of contributions to research that do not rise to the level of authorship.
This application is an initial deployment of a tool supporting exploration of PubMed Central acknowledgements.
We have two primary goals at this stage.  The first is to serve as a source of expertise for <a href="http://labs.cd2h.org/search/facetSearch.jsp">CTSAsearch</a>
regarding individuals key to research success
that typically are not coauthors or coinvestigators.
The second is as a source of ground truth for coathor contribution to feed into the CD2H
<a href="https://github.com/data2health/CTS-Personas">CTS Personas</a> project and the
<a href="https://github.com/data2health/scits-platform">Science of Translational Science Platform</a>.
        </div>
        <jsp:include page="footer.jsp" flush="true" />
        </div>
</body>

</html>
