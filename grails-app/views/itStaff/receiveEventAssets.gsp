<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.themindmuseum.helpdesk.utils.DateUtils" %>
<%@ page import="org.themindmuseum.helpdesk.TicketStatus" %>
<%@ page import="org.themindmuseum.helpdesk.domain.Employee" %>
<%@ page import="org.springframework.validation.FieldError" %>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Receive Event Assets</title>
    <script>
        $(document).ready(function(){
            $("[id*='dateTaggedString']").each(function( index ) {
                applyDateTimePickerStyle($(this).prop('id'));
            });
        });
    </script>
</head>
<body>
<h1>Receive Event Assets</h1>
<div id="wrapper">
    <div id="page-wrapper">
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">Incident Ticket</h1>
            </div>
            <!-- /.col-lg-12 -->
        </div>
        <div>
            <g:hasErrors bean="${eventSupport}">
                <ul class="errors" role="alert">
                <g:each in="${eventSupport.equipments}" var="equipment">
                    <g:eachError bean="${equipment}" var="error">
                        <li <g:if test="${error in FieldError}">data-field-id="${error.field}"</g:if>>
                            <g:message error="${error}"/>
                        </li>
                    </g:eachError>
                </g:each>
                </ul>
            </g:hasErrors>
        </div>
        <div>
            <g:form method="post">
                <g:hiddenField name="eventSupportId" value="${eventSupport.id}"/>
                Subject : ${eventSupport?.subject} <br/>
                Time Filed : <g:formatDate date="${DateUtils.asDate(eventSupport?.timeFiled)}" format="MM/dd/yyyy hh:mm a"/> <br/>
                Start Time : <g:formatDate date="${DateUtils.asDate(eventSupport?.startTime)}" format="MM/dd/yyyy hh:mm a"/> <br/>
                End Time : <g:formatDate date="${DateUtils.asDate(eventSupport?.endTime)}" format="MM/dd/yyyy hh:mm a"/> <br/>
                Status : ${eventSupport.status} <br />
                Event Support Request Fulfilled : <g:formatBoolean boolean="${eventSupport.resourceIssued}" true="Yes" false="No"/> <br/>
                Requested by : ${eventSupport.reportedBy}<br/>
                Assigned to : ${eventSupport.assignee} <br/>
                Description : <br/>
                <textArea readonly="true">${eventSupport?.description}</textArea><br/>
                notes: <br/>
                <textArea readonly="true">${eventSupport?.resolutionNotes}</textArea> <br/>

                Add additional notes: <br/>
                <g:textArea name="additionalNotes"/><br/>
                <h3>Support Staff :</h3>
                <g:if test="${eventSupport.supportStaff}">
                    <table>
                        <thead>
                        <th>Name</th>
                        <th>Email</th>
                        </thead>
                        <tbody>
                        <g:each in="${eventSupport?.supportStaff}" var="email" status="i">
                            <g:set var="staff" value="${Employee.findByEmail(email)}"/>
                            <tr id="added-staff-${i}">
                                <td>${staff?.fullName}</td>
                                <td>${staff?.email}
                                    <g:hiddenField name="supportStaff" value="${staff.email}"/></td>
                            </tr>
                        </g:each>
                        </tbody>
                    </table>
                </g:if>
                <h3>Equipments :</h3>
                <g:set var="tags" value="${[AVAILABLE : 'Returned', MISSING :'Missing', WITH_DAMAGE : 'With Damage']}"/>
                <g:each in="${eventSupport?.equipments}" var="equipment" status="i">
                    ${equipment?.name}(SN: ${equipment?.serialNumber})<g:select name="equipments[${i}].status" from="${tags.entrySet()}"
                        optionKey="key" optionValue="value" /> <g:textField name="equipments[${i}].dateTaggedString" id="equipments-${i}-dateTaggedString"/><br/>
                        <g:hiddenField name="equipments[${i}].serialNumber" value="${equipment?.serialNumber}"/>
                    equipment history:<br/>
                    <textArea readonly="true">${equipment?.notes}</textArea><br/>
                    Add equipment history:<br/>
                    <g:textArea name="equipments[${i}].additionalNotes"/>
                    <br/>
                </g:each>
                <g:actionSubmit value="Save Changes" action="saveEventAssetReturningChanges"/>
                <g:actionSubmit value="Reopen Event Support" action="reopenEventSupport"/>
                <g:if test="${eventSupport?.equipments}">
                    <g:actionSubmit value="Complete returning process" action="markEventAssetReturned"/>
                </g:if>
            </g:form>
        </div>
    </div>
</div>
</body>
</html>