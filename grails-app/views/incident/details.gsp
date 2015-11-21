<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.themindmuseum.helpdesk.utils.DateUtils" %>
<%@ page import="org.themindmuseum.helpdesk.TicketStatus" %>
<html>
<head>
    <title>Incident Details</title>
    <meta name="layout" content="main"/>
</head>
<body>
<div id="wrapper">
    <div id="page-wrapper">
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">Incident Details</h1>
            </div>
            <!-- /.col-lg-12 -->
        </div>
        <g:set var="timeFiledDate" value="${DateUtils.asDate(incident?.timeFiled)}"/>
        Subject : ${incident?.subject} <br/>
        Date : <g:formatDate date="${timeFiledDate}" format="MM/dd/yyyy"/> <br/>
        Time : <g:formatDate date="${timeFiledDate}" format="mm:ss a"/> <br/>
        Equipment : ${incident?.equipment.name} <br/>
        Manufacturer : ${incident?.equipment.manufacturer} <br/>
        Serial No. : ${incident?.equipment.serialNumber} <br/>
        Status : ${incident?.status} <br/>
        Concern : <br/>
            <textArea readonly="true">${incident?.description}</textArea>
        notes:
            <textArea readonly="true">${incident?.resolutionNotes}</textArea>

        <g:form method="post">
            <g:hiddenField name="incidentId" value="${incident?.id}"/>
            <g:if test="${incident?.status == TicketStatus.OPEN}">
                Add additional notes: <br/>
                <g:textArea name="additionalNotes"/>
                <g:actionSubmit value="Add Notes" action="addAdditionalNotes"/>
                <g:actionSubmit value="Resolve Incident" action="resolveIncident"/>
            </g:if>
            <g:else>
                <g:actionSubmit value="Reopen Incident" action="reopenIncident"/>
            </g:else>
        </g:form>
    </div>
</div>
</body>
</html>