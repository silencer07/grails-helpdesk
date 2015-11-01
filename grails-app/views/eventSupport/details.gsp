<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.themindmuseum.helpdesk.utils.DateUtils" %>
<%@ page import="org.themindmuseum.helpdesk.TicketStatus" %>
<html>
<head>
    <title>My Event Support Details</title>
</head>
<body>
<h1>My Event Support Details</h1>
<div>
    <div>
        Subject : ${eventSupport?.subject} <br/>
        Time Filed : <g:formatDate date="${DateUtils.asDate(eventSupport?.timeFiled)}" format="MM/dd/yyyy hh:mm a"/> <br/>
        Start Time : <g:formatDate date="${DateUtils.asDate(eventSupport?.startTime)}" format="MM/dd/yyyy hh:mm a"/> <br/>
        End Time : <g:formatDate date="${DateUtils.asDate(eventSupport?.endTime)}" format="MM/dd/yyyy hh:mm a"/> <br/>
        Status : ${eventSupport.status} <br/>
        Resource Issued : <g:formatBoolean boolean="${eventSupport.resourceIssued}" true="Yes" false="No"/> <br/>
        <g:if test="${eventSupport?.equipments}">
            <table>
                <thead>
                <th>Equipment</th>
                <th>Serial Number</th>
                </thead>
                <tbody>
                <g:each in="${eventSupport?.equipments}" var="equipment">
                    <tr>
                        <td>${equipment.name}</td>
                        <td>${equipment.serialNumber}</td>
                    </tr>
                </g:each>
                </tbody>
            </table>
        </g:if>
        <g:if test="${eventSupport?.supportStaff}">
            <table>
                <thead>
                <th>Name</th>
                <th>Email</th>
                </thead>
                <tbody>
                <g:each in="${eventSupport?.supportStaff}" var="staff">
                    <tr>
                        <td>${staff.fullName}</td>
                        <td>${staff.email}</td>
                    </tr>
                </g:each>
                </tbody>
            </table>
        </g:if>
        Description : <br/>
            <textArea readonly="true">${eventSupport?.description}</textArea>
        notes:
            <textArea readonly="true">${eventSupport?.resolutionNotes}</textArea>

        <g:form method="post">
            <g:hiddenField name="eventSupportId" value="${eventSupport?.id}"/>
            <g:if test="${eventSupport?.status == TicketStatus.OPEN}">
                Add additional notes: <br/>
                <g:textArea name="additionalNotes"/>
                <g:actionSubmit value="Add Notes" action="addAdditionalNotes"/>
                <g:actionSubmit value="Resolve Event Support Request" action="resolveEventSupport"/>
            </g:if>
            <g:else>
                <g:actionSubmit value="Reopen Event Support Request" action="reopenEventSupport"/>
            </g:else>
            <g:if test="${eventSupport?.equipments || eventSupport?.supportStaff}">
                <g:actionSubmit value="Mark/Unmark Event Support Request as Fulfilled" action="markResourceAllocated"/>
            </g:if>
        </g:form>
    </div>
</div>
</body>
</html>