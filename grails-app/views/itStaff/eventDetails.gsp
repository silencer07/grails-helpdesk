<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.themindmuseum.helpdesk.utils.DateUtils" %>
<%@ page import="org.themindmuseum.helpdesk.TicketStatus" %>
<%@ page import="org.springframework.validation.FieldError" %>
<%@ page import="org.themindmuseum.helpdesk.domain.Employee" %>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Event Support Details</title>
    <asset:javascript src="equipmentAdding.js"/>
    <script>
        function removeStaff(id){
            $("#" + id).remove();
        }
    </script>
</head>
<body>
<div id="wrapper">
    <div id="page-wrapper">
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">Event Support Details</h1>
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
                Borrowing Request Fulfilled : <g:formatBoolean boolean="${eventSupport.resourceIssued}" true="Yes" false="No"/> <br/>
                Requested by : ${eventSupport.reportedBy.fullName}<br/>
                Assigned to : ${eventSupport.assignee?.fullName} <br/>
                <g:set var="equipmentIndex" value="0"/>
                <g:if test="${eventSupport?.equipments}">
                    <g:set var="equipmentIndex" value="${eventSupport?.equipments.size()}"/>
                    <table>
                        <thead>
                        <th>Equipment</th>
                        <th>Serial Number</th>
                        <g:if test="${eventSupport?.status == TicketStatus.OPEN}">
                            <th></th>
                        </g:if>
                        </thead>
                        <tbody>
                        <g:each in="${eventSupport?.equipments}" var="equipment" status="i">
                            <tr id="added-equipment-${i}">
                                <td>${equipment?.name}</td>
                                <g:if test="${eventSupport?.status == TicketStatus.OPEN}">
                                    <td><g:textField name="equipments[${i}].serialNumber" value="${equipment?.serialNumber}" readonly="readonly"/></td>
                                    <td><input type="button" value="Remove Equipment" onclick="removeEquipment(('added-equipment-${i}'))"/></td>
                                </g:if>
                                <g:else>
                                    <td>${equipment?.serialNumber}
                                        <g:hiddenField name="equipments[${i}].serialNumber" value="${equipment?.serialNumber}"/></td>
                                </g:else>
                            </tr>
                        </g:each>
                        </tbody>
                    </table>
                </g:if>
                <g:if test="${eventSupport.supportStaff}">
                    <table>
                        <thead>
                            <th>Name</th>
                            <th>Email</th>
                            <g:if test="${eventSupport?.status == TicketStatus.OPEN}">
                                <th></th>
                            </g:if>
                        </thead>
                        <tbody>
                        <g:each in="${eventSupport?.supportStaff}" var="email" status="i">
                            <g:set var="staff" value="${Employee.findByEmail(email)}"/>
                            <tr id="added-staff-${i}">
                                <td>${staff?.fullName}</td>
                                <td>${staff?.email}
                                    <g:hiddenField name="supportStaff" value="${staff.email}"/></td>
                                <g:if test="${eventSupport?.status == TicketStatus.OPEN}">
                                    <td><input type="button" value="Remove Staff" onclick="removeStaff(('added-staff-${i}'))"/></td>
                                </g:if>
                            </tr>
                        </g:each>
                        </tbody>
                    </table>
                </g:if>
                <g:if test="${eventSupport?.status == TicketStatus.OPEN}">
                    <div id="additional-equipment-div">
                        <div>
                            Serial Number: <g:textField name="equipments[${equipmentIndex}].serialNumber"/>
                        </div>
                        <input type="button" id="add-equipment" value="Add Equipment" onclick="addEquipment()"/><br/>
                        Support staff (hold ctrl/command then click for multiple select): <br/>
                        <g:select name="supportStaff" from="${itStaff}"
                              optionKey="email" optionValue="fullName" multiple="true"/>
                    </div>
                </g:if>
                Description : <br/>
                    <textArea readonly="true">${eventSupport?.description}</textArea><br/>
                notes: <br/>
                    <textArea readonly="true">${eventSupport?.resolutionNotes}</textArea><br/>

                <g:if test="${eventSupport?.status == TicketStatus.OPEN}">
                    Add additional notes: <br/>
                    <g:textArea name="additionalNotes"/><br/>
                    <g:actionSubmit value="Save Changes" action="saveEventSupportChanges"/>
                    <g:actionSubmit value="Resolve Event Support Request" action="resolveEventSupport"/>
                </g:if>
                <g:else>
                    <g:actionSubmit value="Reopen Event Support Request" action="reopenEventSupport"/>
                </g:else>
                <g:if test="${eventSupport?.equipments || eventSupport?.supportStaff}">
                    <g:actionSubmit value="Mark/Unmark Event Support Request as Fulfilled" action="markResourceIssued"/>
                </g:if>
            </g:form>
        </div>
    </div>
</div>
</body>
</html>