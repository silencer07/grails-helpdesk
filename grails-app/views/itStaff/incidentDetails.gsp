<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.themindmuseum.helpdesk.utils.DateUtils" %>
<%@ page import="org.themindmuseum.helpdesk.TicketStatus" %>
<%@ page import="org.themindmuseum.helpdesk.EquipmentStatus" %>
<%@ page import="org.themindmuseum.helpdesk.domain.Incident" %>
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
        <!-- /row -->
        <div class="row">
            <div class="col-lg-10">
                <div class="panel panel-default">
                    <div class="panel-body">
                        <div class="table-responsive">
                            <table  class="table">
                                <tbody>
                                <g:set var="timeFiledDate" value="${DateUtils.asDate(incident?.timeFiled)}"/>
                                <tr>
                                    <td>Subject:</td>
                                    <td>${incident?.subject}</td>
                                </tr>
                                <tr>
                                    <td>Date:</td>
                                    <td><g:formatDate date="${timeFiledDate}" format="MM/dd/yyyy"/></td>
                                </tr>
                                <tr>
                                    <td>Time:</td>
                                    <td> <g:formatDate date="${timeFiledDate}" format="mm:ss a"/></td>
                                </tr>
                                <tr>
                                    <td>Equipment:</td>
                                    <td>${incident?.equipment.name}</td>
                                </tr>
                                <tr>
                                    <td>Manufacturer:</td>
                                    <td>${incident?.equipment.manufacturer}</td>
                                </tr>
                                <tr>
                                    <td>Serial Number:</td>
                                    <td>${incident?.equipment.serialNumber}</td>
                                </tr>
                                <tr>
                                    <td>Status:</td>
                                    <td>${incident?.status}</td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                        <div class="row">
                            <div class="col-lg-12">
                                <div class="form-group">
                                    <label> Concern:</label>
                                    <textArea class="form-control" rows="3" readonly="true">${incident?.description}</textArea>
                                </div>
                                <div class="form-group">
                                    <label>Notes:</label>
                                    <textArea class="form-control" rows="3" readonly="true">${incident?.resolutionNotes}</textArea>
                                </div>
                                <div class=form-group">
                                    <g:form method="post">
                                        <g:hiddenField name="id" value="${incident?.id}"/>
                                        <g:hiddenField name="clazz" value="${Incident.getName()}"/>
                                        <g:hiddenField name="successAction" value="incidentDetails"/>
                                        <g:hiddenField name="failAction" value="index"/>
                                        <g:if test="${incident?.status == TicketStatus.OPEN}">
                                            <div class="form-group">
                                                <label>Add additional notes:</label>
                                                <g:textArea class="form-control" rows="3" name="additionalNotes"/>
                                            </div>
                                            <div class="form-group">
                                                Assign Ticket : <g:select class="btn dropdown-toggle" name="assignee" from="${itStaff}" optionKey="email" optionValue="fullName"
                                                                          noSelection='["${sec.username(null, null)}":"Assign to me"]' value="${incident?.assignee?.email}"/>
                                            </div>
                                            <div class="form-group">
                                                Change equipment status: <g:select class="btn dropdown-toggle" name="equipmentStatus" from="${EquipmentStatus.statusesForSupportTickets()}"
                                                                                   noSelection="['':'Do not Change']"/>
                                            </div>
                                            <div class="form-group">
                                                <label>Equipment History:</label>
                                                <textArea class="form-control" rows="3" readonly="true">${incident?.equipment?.notes}</textArea>
                                            </div>
                                            <div class="form-group">
                                                <label>Add History:</label>
                                                <g:textArea class="form-control" rows="3" name="equipmentHistoryNotes"/>
                                            </div>
                                            <div class="form-group">
                                                <g:actionSubmit class="btn btn-default" value="Save Changes" action="saveIncidentChanges"/>
                                                <g:actionSubmit class="btn btn-default" value="Resolve Incident" action="openCloseIncident"/>
                                            </div>
                                        </g:if>
                                        <g:else>
                                            <div class="table-responsive">
                                                <table  class="table">
                                                    <tbody>
                                                    <g:set var="timeFiledDate" value="${DateUtils.asDate(incident?.timeFiled)}"/>
                                                    <tr>
                                                        <td>Ticket Assignee:</td>
                                                        <td>${incident?.assignee?.fullName}</td>
                                                    </tr>
                                                    <tr>
                                                        <td>Equipment status:</td>
                                                        <td>${incident.equipment?.status}</td>
                                                    </tr>
                                                    </tbody>
                                                </table>
                                            </div>
                                            <div class="form-group">
                                                <label>Equipment History:</label>
                                                <textArea class="form-control" rows="3" readonly="true">${incident?.equipment.notes}</textArea><br/>
                                                <g:actionSubmit class="btn btn-default" value="Reopen Incident" action="openCloseIncident"/>
                                            </div>
                                        </g:else>
                                    </g:form>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
