<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.themindmuseum.helpdesk.utils.DateUtils" %>
<%@ page import="org.themindmuseum.helpdesk.TicketStatus" %>
<html>
<head>
    <title>Incident Details</title>
</head>
<body>
<h1>Incident Details</h1>
<div>
    <div>
        <g:set var="timeFiledDate" value="${DateUtils.asDate(incident?.timeFiled)}"/>
        Subject : ${incident?.subject} <br/>
        Date : <g:formatDate date="${timeFiledDate}" format="MM/dd/yyyy"/> <br/>
        Time : <g:formatDate date="${timeFiledDate}" format="mm:ss"/> <br/>
        Equipment : ${incident?.equipment.name} <br/>
        Manufacturer : ${incident?.equipment.manufacturer} <br/>
        Serial No. : ${incident?.equipment.serialNumber} <br/>
        description : <br/>
            <p>${incident?.description}</p>
        notes:
            <p>${incident?.description}</p>

        <g:form method="post">
            <g:hiddenField name="incidentId" value="${incident?.id}"/>
            <g:if test="${incident?.status == TicketStatus.OPEN}">
                Add additional notes: <br/>
                <g:textArea name="additionalNotes"/>
                <g:actionSubmit value="Add Notes" action="addAdditionalNotes"/>
                <g:actionSubmit value="Close Incident" action="closeIncident"/>
            </g:if>
            <g:else>
                <g:actionSubmit value="Reopen Incident" action="reopenIncident"/>
            </g:else>
        </g:form>
    </div>
</div>
</body>
</html>