<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<%@ taglib prefix="ack" uri="http://icts.uiowa.edu/AcknowledgementsTagLib"%>
<%@ taglib prefix="pmc" uri="http://icts.uiowa.edu/pubmedcentral"%>
<%@ taglib prefix="medline" uri="http://icts.uiowa.edu/medline"%>


<!DOCTYPE html>
<html lang="en-US">
<jsp:include page="../head.jsp" flush="true">
    <jsp:param name="title" value="acknowledgments Acknowlegement" />
</jsp:include>
<style type="text/css" media="all">
@import "../resources/layout.css";
</style>

<body class="home page-template-default page page-id-6 CD2H">
    <jsp:include page="../header.jsp" flush="true" />

    <div class="container pl-0 pr-0">
        <br /> <br />
        <div class="container-fluid">

			<h1>Acknowledgement Section of PMCID: ${param.pmcid}</h1>
			<pmc:file pmcid="${param.pmcid}">
			 <pmc:foreachContent var="con">
			     <pmc:content>
			         <c:set var="pmid"><pmc:contentPmid/></c:set>
			         <medline:article pmid="${pmid}">
			             <b><medline:articleTitle/></b>
			         </medline:article>
			     </pmc:content>
			 </pmc:foreachContent>
             <pmc:fileCitation/>
			</pmc:file>
            <pmc:article pmcid="${param.pmcid}">
            <ol class="bulletedList">
			 <pmc:foreachAuthor sortCriteria="authid" var="auth">
			     <pmc:author>
			         <li><pmc:authorLname/>, <pmc:authorFname/>
			     </pmc:author>
			 </pmc:foreachAuthor>
			 </ol>
			</pmc:article>
			<h4>Sentences</h4>
			<sql:query var="sentences" dataSource="jdbc/AcknowledgementsTagLib">
                select seqnum,sentnum,sentence from pubmed_central_ack_stanford.ack_sentence where pmcid=?::int order by 1,2;
                <sql:param>${param.pmcid}</sql:param>
			</sql:query>
			<table>
				<tr>
					<th>Segment</th>
					<th>Sentence</th>
					<th>Text</th>
				</tr>
				<c:forEach items="${sentences.rows}" var="row" varStatus="rowCounter">
					<tr>
						<td>${row.seqnum}</td>
						<td>${row.sentnum}</td>
						<td><a href="<util:applicationRoot/>/sentence/sentence.jsp?pmcid=${param.pmcid}&seqnum=${row.seqnum}&sentnum=${row.sentnum}">${row.sentence}</a></td>
					</tr>
				</c:forEach>
			</table>

            <h2>Extracted Data</h2>
            
			<sql:query var="organizations" dataSource="jdbc/AcknowledgementsTagLib">
                select id,organization,grid_id,grid_match_string,geonames_id,geonames_match_string
                from pubmed_central_ack_stanford.organization,pubmed_central_ack_stanford.organization_mention
                where pmcid=?::int
                  and organization.id=organization_mention.organization_id
                order by 1,2;
                <sql:param>${param.pmcid}</sql:param>
			</sql:query>
			<c:if test="${organizations.rowCount > 0}">
				<h4>Organizations</h4>
				<table>
					<tr>
						<th>ID</th>
						<th>Organization</th>
                        <th>GRID ID</th>
                        <th>GRID match string</th>
                        <th>GeoNames ID</th>
                        <th>GeoNames match string</th>
					</tr>
					<c:forEach items="${organizations.rows}" var="row" varStatus="rowCounter">
						<tr>
							<td><a href="<util:applicationRoot/>/organization/organization.jsp?id=${row.id}">${row.id}</a></td>
							<td>${row.organization}</td>
                            <td>${row.grid_id}</td>
                            <td>${row.grid_match_string}</td>
                            <td>${row.geonames_id}</td>
                            <td>${row.geonames_match_string}</td>
						</tr>
					</c:forEach>
				</table>
			</c:if>

			<sql:query var="persons" dataSource="jdbc/AcknowledgementsTagLib">
                select id,last_name,first_name,middle_name,title,appendix
                from pubmed_central_ack_stanford.person,pubmed_central_ack_stanford.person_mention
                where pmcid=?::int
                  and person.id=person_mention.person_id
                order by 2,3,4,5,6;
                <sql:param>${param.pmcid}</sql:param>
			</sql:query>
			<c:if test="${persons.rowCount > 0}">
				<h4>Persons</h4>
				<table>
					<tr>
						<th>ID</th>
						<th>Last Name</th>
						<th>First Name</th>
						<th>Middle Name</th>
						<th>Title</th>
						<th>Appendix</th>
					</tr>
					<c:forEach items="${persons.rows}" var="row" varStatus="rowCounter">
						<tr>
							<td><a href="<util:applicationRoot/>/person/person.jsp?id=${row.id}">${row.id}</a></td>
							<td>${row.last_name}</td>
							<td>${row.first_name}</td>
							<td>${row.middle_name}</td>
							<td>${row.title}</td>
							<td>${row.appendix}</td>
						</tr>
					</c:forEach>
				</table>
			</c:if>

			<sql:query var="awards" dataSource="jdbc/AcknowledgementsTagLib">
                select id,award
                from pubmed_central_ack_stanford.award,pubmed_central_ack_stanford.award_mention
                where pmcid=?::int
                  and award.id=award_mention.award_id
                order by 2;
                <sql:param>${param.pmcid}</sql:param>
			</sql:query>
			<c:if test="${awards.rowCount > 0}">
				<h4>Awards</h4>
				<table>
					<tr>
						<th>ID</th>
						<th>Award</th>
					</tr>
					<c:forEach items="${awards.rows}" var="row" varStatus="rowCounter">
						<tr>
							<td><a href="<util:applicationRoot/>/award/award.jsp?id=${row.id}">${row.id}</a></td>
							<td>${row.award}</td>
						</tr>
					</c:forEach>
				</table>
			</c:if>

            <sql:query var="collaborations" dataSource="jdbc/AcknowledgementsTagLib">
                select id,collaboration
                from pubmed_central_ack_stanford.collaboration,pubmed_central_ack_stanford.collaboration_mention
                where pmcid=?::int
                  and collaboration.id=collaboration_mention.collaboration_id
                order by 2;
                <sql:param>${param.pmcid}</sql:param>
            </sql:query>
            <c:if test="${collaborations.rowCount > 0}">
                <h4>Collaborations</h4>
                <table>
                    <tr>
                        <th>ID</th>
                        <th>Collaboration</th>
                    </tr>
                    <c:forEach items="${collaborations.rows}" var="row" varStatus="rowCounter">
                        <tr>
                            <td><a href="<util:applicationRoot/>/collaboration/collaboration.jsp?id=${row.id}">${row.id}</a></td>
                            <td>${row.collaboration}</td>
                        </tr>
                    </c:forEach>
                </table>
            </c:if>

            <sql:query var="resources" dataSource="jdbc/AcknowledgementsTagLib">
                select id,resource,umls_id,umls_match_string,alt_umls_id,alt_umls_match_string
                from pubmed_central_ack_stanford.resource,pubmed_central_ack_stanford.resource_mention
                where pmcid=?::int
                  and resource.id=resource_mention.resource_id
                order by 2;
                <sql:param>${param.pmcid}</sql:param>
            </sql:query>
            <c:if test="${resources.rowCount > 0}">
                <h4>Resources</h4>
                <table>
                    <tr>
                        <th>ID</th>
                        <th>Resource</th>
                        <th>UMLS CUI</th>
                        <th>UMLS match string</th>
                        <th>alternate UMLS CUI</th>
                        <th>alternate UMLS match string</th>
                    </tr>
                    <c:forEach items="${resources.rows}" var="row" varStatus="rowCounter">
                        <tr>
                            <td><a href="<util:applicationRoot/>/resource/resource.jsp?id=${row.id}">${row.id}</a></td>
                            <td>${row.resource}</td>
                            <td>${row.umls_id}</td>
                            <td>${row.umls_match_string}</td>
                            <td>${row.alt_umls_id}</td>
                            <td>${row.alt_umls_match_string}</td>
                        </tr>
                    </c:forEach>
                </table>
            </c:if>

            <sql:query var="techniques" dataSource="jdbc/AcknowledgementsTagLib">
                select id,technique,umls_id,umls_match_string
                from pubmed_central_ack_stanford.technique,pubmed_central_ack_stanford.technique_mention
                where pmcid=?::int
                  and technique.id=technique_mention.technique_id
                order by 2;
                <sql:param>${param.pmcid}</sql:param>
            </sql:query>
            <c:if test="${techniques.rowCount > 0}">
                <h4>Techniques</h4>
                <table>
                    <tr>
                        <th>ID</th>
                        <th>Technique</th>
                        <th>UMLS CUI</th>
                        <th>UMLS match string</th>
                    </tr>
                    <c:forEach items="${techniques.rows}" var="row" varStatus="rowCounter">
                        <tr>
                            <td><a href="<util:applicationRoot/>/technique/technique.jsp?id=${row.id}">${row.id}</a></td>
                            <td>${row.technique}</td>
                            <td>${row.umls_id}</td>
                            <td>${row.umls_match_string}</td>
                        </tr>
                    </c:forEach>
                </table>
            </c:if>

            <sql:query var="supports" dataSource="jdbc/AcknowledgementsTagLib">
                select id,support
                from pubmed_central_ack_stanford.support,pubmed_central_ack_stanford.support_mention
                where pmcid=?::int
                  and support.id=support_mention.support_id
                order by 2;
                <sql:param>${param.pmcid}</sql:param>
            </sql:query>
            <c:if test="${supports.rowCount > 0}">
                <h4>Support</h4>
                <table>
                    <tr>
                        <th>ID</th>
                        <th>Support</th>
                    </tr>
                    <c:forEach items="${supports.rows}" var="row" varStatus="rowCounter">
                        <tr>
                            <td><a href="<util:applicationRoot/>/support/support.jsp?id=${row.id}">${row.id}</a></td>
                            <td>${row.support}</td>
                        </tr>
                    </c:forEach>
                </table>
            </c:if>

            <sql:query var="diseases" dataSource="jdbc/AcknowledgementsTagLib">
                select id,disease,umls_id,umls_match_string
                from pubmed_central_ack_stanford.disease,pubmed_central_ack_stanford.disease_mention
                where pmcid=?::int
                  and disease.id=disease_mention.disease_id
                order by 2;
                <sql:param>${param.pmcid}</sql:param>
            </sql:query>
            <c:if test="${diseases.rowCount > 0}">
                <h4>Disease</h4>
                <table>
                    <tr>
                        <th>ID</th>
                        <th>Disease</th>
                        <th>UMLS CUI</th>
                        <th>UMLS match string</th>
                    </tr>
                    <c:forEach items="${diseases.rows}" var="row" varStatus="rowCounter">
                        <tr>
                            <td><a href="<util:applicationRoot/>/disease/disease.jsp?id=${row.id}">${row.id}</a></td>
                            <td>${row.disease}</td>
                            <td>${row.umls_id}</td>
                            <td>${row.umls_match_string}</td>
                        </tr>
                    </c:forEach>
                </table>
            </c:if>

            <sql:query var="organic_chemicals" dataSource="jdbc/AcknowledgementsTagLib">
                select id,organic_chemical,umls_id,umls_match_string
                from pubmed_central_ack_stanford.organic_chemical,pubmed_central_ack_stanford.organic_chemical_mention
                where pmcid=?::int
                  and organic_chemical.id=organic_chemical_mention.organic_chemical_id
                order by 2;
                <sql:param>${param.pmcid}</sql:param>
            </sql:query>
            <c:if test="${organic_chemicals.rowCount > 0}">
                <h4>Organic Chemicals</h4>
                <table>
                    <tr>
                        <th>ID</th>
                        <th>Organic Chemical</th>
                        <th>UMLS CUI</th>
                        <th>UMLS match string</th>
                    </tr>
                    <c:forEach items="${organic_chemicals.rows}" var="row" varStatus="rowCounter">
                        <tr>
                            <td><a href="<util:applicationRoot/>/organic_chemical/organic_chemical.jsp?id=${row.id}">${row.id}</a></td>
                            <td>${row.organic_chemical}</td>
                            <td>${row.umls_id}</td>
                            <td>${row.umls_match_string}</td>
                        </tr>
                    </c:forEach>
                </table>
            </c:if>

            <sql:query var="organisms" dataSource="jdbc/AcknowledgementsTagLib">
                select id,organism,umls_id,umls_match_string
                from pubmed_central_ack_stanford.organism,pubmed_central_ack_stanford.organism_mention
                where pmcid=?::int
                  and organism.id=organism_mention.organism_id
                order by 2;
                <sql:param>${param.pmcid}</sql:param>
            </sql:query>
            <c:if test="${organisms.rowCount > 0}">
                <h4>Organisms</h4>
                <table>
                    <tr>
                        <th>ID</th>
                        <th>Organism</th>
                        <th>UMLS CUI</th>
                        <th>UMLS match string</th>
                    </tr>
                    <c:forEach items="${organisms.rows}" var="row" varStatus="rowCounter">
                        <tr>
                            <td><a href="<util:applicationRoot/>/organic_chemical/organic_chemical.jsp?id=${row.id}">${row.id}</a></td>
                            <td>${row.organism}</td>
                            <td>${row.umls_id}</td>
                            <td>${row.umls_match_string}</td>
                        </tr>
                    </c:forEach>
                </table>
            </c:if>

            <sql:query var="locations" dataSource="jdbc/AcknowledgementsTagLib">
                select id,location,geonames_id,geonames_match_string
                from pubmed_central_ack_stanford.location,pubmed_central_ack_stanford.location_mention
                where pmcid=?::int
                  and location.id=location_mention.location_id
                order by 2;
                <sql:param>${param.pmcid}</sql:param>
            </sql:query>
            <c:if test="${locations.rowCount > 0}">
                <h4>Locations</h4>
                <table>
                    <tr>
                        <th>ID</th>
                        <th>Location</th>
                        <th>GeoNames ID</th>
                        <th>GeoNames match string</th>
                    </tr>
                    <c:forEach items="${locations.rows}" var="row" varStatus="rowCounter">
                        <tr>
                            <td><a href="<util:applicationRoot/>/location/location.jsp?id=${row.id}">${row.id}</a></td>
                            <td>${row.location}</td>
                            <td>${row.geonames_id}</td>
                            <td>${row.geonames_match_string}</td>
                        </tr>
                    </c:forEach>
                </table>
            </c:if>

            <sql:query var="projects" dataSource="jdbc/AcknowledgementsTagLib">
                select id,project
                from pubmed_central_ack_stanford.project,pubmed_central_ack_stanford.project_mention
                where pmcid=?::int
                  and project.id=project_mention.project_id
                order by 2;
                <sql:param>${param.pmcid}</sql:param>
            </sql:query>
            <c:if test="${projects.rowCount > 0}">
                <h4>Projects</h4>
                <table>
                    <tr>
                        <th>ID</th>
                        <th>Project</th>
                    </tr>
                    <c:forEach items="${projects.rows}" var="row" varStatus="rowCounter">
                        <tr>
                            <td><a href="<util:applicationRoot/>/project/project.jsp?id=${row.id}">${row.id}</a></td>
                            <td>${row.project}</td>
                        </tr>
                    </c:forEach>
                </table>
            </c:if>

            <sql:query var="funding_agencies" dataSource="jdbc/AcknowledgementsTagLib">
                select id,funding_agency
                from pubmed_central_ack_stanford.funding_agency,pubmed_central_ack_stanford.funding_agency_mention
                where pmcid=?::int
                  and funding_agency.id=funding_agency_mention.funding_agency_id
                order by 2;
                <sql:param>${param.pmcid}</sql:param>
            </sql:query>
            <c:if test="${funding_agencies.rowCount > 0}">
                <h4>Funding Agencies</h4>
                <table>
                    <tr>
                        <th>ID</th>
                        <th>Funding Agency</th>
                    </tr>
                    <c:forEach items="${funding_agencies.rows}" var="row" varStatus="rowCounter">
                        <tr>
                            <td><a href="<util:applicationRoot/>/funding_agency/funding_agency.jsp?id=${row.id}">${row.id}</a></td>
                            <td>${row.funding_agency}</td>
                        </tr>
                    </c:forEach>
                </table>
            </c:if>

            <sql:query var="disciplines" dataSource="jdbc/AcknowledgementsTagLib">
                select id,discipline
                from pubmed_central_ack_stanford.discipline,pubmed_central_ack_stanford.discipline_mention
                where pmcid=?::int
                  and discipline.id=discipline_mention.discipline_id
                order by 2;
                <sql:param>${param.pmcid}</sql:param>
            </sql:query>
            <c:if test="${disciplines.rowCount > 0}">
                <h4>Disciplines</h4>
                <table>
                    <tr>
                        <th>ID</th>
                        <th>Discipline</th>
                    </tr>
                    <c:forEach items="${disciplines.rows}" var="row" varStatus="rowCounter">
                        <tr>
                            <td><a href="<util:applicationRoot/>/discipline/discipline.jsp?id=${row.id}">${row.id}</a></td>
                            <td>${row.discipline}</td>
                        </tr>
                    </c:forEach>
                </table>
            </c:if>

            <sql:query var="publication_components" dataSource="jdbc/AcknowledgementsTagLib">
                select id,publication_component
                from pubmed_central_ack_stanford.publication_component,pubmed_central_ack_stanford.publication_component_mention
                where pmcid=?::int
                  and publication_component.id=publication_component_mention.publication_component_id
                order by 2;
                <sql:param>${param.pmcid}</sql:param>
            </sql:query>
            <c:if test="${publication_components.rowCount > 0}">
                <h4>Publication Components</h4>
                <table>
                    <tr>
                        <th>ID</th>
                        <th>Publication Component</th>
                    </tr>
                    <c:forEach items="${publication_components.rows}" var="row" varStatus="rowCounter">
                        <tr>
                            <td><a href="<util:applicationRoot/>/publication_component/publication_component.jsp?id=${row.id}">${row.id}</a></td>
                            <td>${row.publication_component}</td>
                        </tr>
                    </c:forEach>
                </table>
            </c:if>

            <sql:query var="events" dataSource="jdbc/AcknowledgementsTagLib">
                select id,event
                from pubmed_central_ack_stanford.event,pubmed_central_ack_stanford.event_mention
                where pmcid=?::int
                  and event.id=event_mention.event_id
                order by 2;
                <sql:param>${param.pmcid}</sql:param>
            </sql:query>
            <c:if test="${events.rowCount > 0}">
                <h4>Events</h4>
                <table>
                    <tr>
                        <th>ID</th>
                        <th>Event</th>
                    </tr>
                    <c:forEach items="${events.rows}" var="row" varStatus="rowCounter">
                        <tr>
                            <td><a href="<util:applicationRoot/>/event/event.jsp?id=${row.id}">${row.id}</a></td>
                            <td>${row.event}</td>
                        </tr>
                    </c:forEach>
                </table>
            </c:if>
        </div>
        <jsp:include page="../footer.jsp" flush="true" />
    </div>
</body>

</html>

