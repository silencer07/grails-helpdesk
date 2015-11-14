<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.themindmuseum.helpdesk.utils.DateUtils" %>
<%@ page import="org.themindmuseum.helpdesk.TicketStatus" %>
<%@ page import="org.themindmuseum.helpdesk.EquipmentStatus" %>
<%@ page import="org.themindmuseum.helpdesk.domain.Incident" %>
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
        Time : <g:formatDate date="${timeFiledDate}" format="mm:ss a"/> <br/>
        Equipment : ${incident?.equipment.name} <br/>
        Manufacturer : ${incident?.equipment.manufacturer} <br/>
        Serial No. : ${incident?.equipment.serialNumber} <br/>
        Status : ${incident?.status} <br/>
        Concern : <br/>
            <textArea readonly="true">${incident?.description}</textArea><br/>
        notes:<br/>
            <textArea readonly="true">${incident?.resolutionNotes}</textArea>

        <g:form method="post">
            <g:hiddenField name="id" value="${incident?.id}"/>
            <g:hiddenField name="clazz" value="${Incident.getName()}"/>
            <g:hiddenField name="successAction" value="incidentDetails"/>
            <g:hiddenField name="failAction" value="index"/>
            <g:if test="${incident?.status == TicketStatus.OPEN}">
                Add additional notes: <br/>
                <g:textArea name="additionalNotes"/> <br/>
                Assign Ticket : <g:select name="assignee" from="${itStaff}" optionKey="email" optionValue="fullName"
                                      noSelection='["${sec.username(null, null)}":"Assign to me"]' value="${incident?.assignee?.email}"/><br/>
                Change equipment status: <g:select name="equipmentStatus" from="${EquipmentStatus.statusesForSupportTickets()}"
                                 noSelection="['':'Do not Change']"/><br/>
                Equipment History: <br/>
                <textArea readonly="true">${incident?.equipment.notes}</textArea><br/>
                Add history: <br/>
                <g:textArea name="equipmentHistoryNotes"/><br/>
                <g:actionSubmit value="Save Changes" action="saveIncidentChanges"/>
                <g:actionSubmit value="Resolve Incident" action="resolveIncident"/>
            </g:if>
            <g:else>
                Ticket Assignee: ${incident?.assignee}
                Equipment status: ${incident.equipment.status}
                Equipment History: <br/>
                <textArea readonly="true">${incident?.equipment.notes}</textArea><br/>
                <g:actionSubmit value="Reopen Incident" action="reopenIncident"/>
            </g:else>
        </g:form>
    </div>
</div>
</body>
</html>