<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.themindmuseum.helpdesk.utils.DateUtils" %>
<%@ page import="org.themindmuseum.helpdesk.TicketStatus" %>
<html>
<head>
    <title>My Event Support Details</title>
    <meta name="layout" content="main"/>
</head>
<body>
<div id="wrapper">
    <div id="page-wrapper">
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">My Event Support Details</h1>
            </div>
            <!-- /.col-lg-12 -->
        </div>
        <div class="row">
            <div class="col-lg-10">
                <div class="panel panel-default">
                    <div class="panel-body">
                        <div class="table-responsive">
                            <table  class="table table-bordered">
                                <tbody>
                                <tr>
                                    <td>Subject:</td>
                                    <td>${eventSupport?.subject}</td>
                                </tr>
                                <tr>
                                    <td>Time Filed</td>
                                    <td><g:formatDate date="${DateUtils.asDate(eventSupport?.timeFiled)}" format="MM/dd/yyyy hh:mm a"/></td>
                                </tr>
                                <tr>
                                    <td>Start Time:</td>
                                    <td><g:formatDate date="${DateUtils.asDate(eventSupport?.startTime)}" format="MM/dd/yyyy hh:mm a"/></td>
                                </tr>
                                <tr>
                                    <td>End Time :</td>
                                    <td><g:formatDate date="${DateUtils.asDate(eventSupport?.endTime)}" format="MM/dd/yyyy hh:mm a"/></td>
                                </tr>
                                <tr>
                                    <td>Status:</td>
                                    <td>${eventSupport.status}</td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                        <div class="table-responsive">

                            <g:if test="${eventSupport?.equipments}">
                                <label>Resource Issued : <g:formatBoolean boolean="${eventSupport.resourceIssued}" true="Yes" false="No"/></label>
                                <table class="table table-bordered">
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
                                <table class="table table-bordered">
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
                        </div>
                        <div class="row">
                            <div class="col-lg-12">
                                <div class="form-group">
                                    <label> Description:</label>
                                    <textArea class="form-control" rows="3" readonly="true">${eventSupport?.description}</textArea>
                                </div>
                                <div class="form-group">
                                    <label>Notes:</label>
                                    <textArea class="form-control" rows="3" readonly="true">${eventSupport?.resolutionNotes}</textArea>
                                </div>
                                <g:form method="post">
                                    <g:hiddenField name="eventSupportId" value="${eventSupport?.id}"/>
                                    <g:if test="${eventSupport?.status == TicketStatus.OPEN}">
                                        <div class="form-group">
                                            <label>Add additional notes:</label>
                                            <g:textArea class="form-control" rows="3" name="additionalNotes"/>
                                        </div>
                                            <g:actionSubmit class="btn btn-default" value="Add Notes" action="addAdditionalNotes"/>
                                            <g:actionSubmit class="btn btn-default" value="Resolve Event Support Request" action="resolveEventSupport"/>
                                    </g:if>
                                    <g:else>
                                        <g:actionSubmit class="btn btn-default" value="Reopen Event Support Request" action="reopenEventSupport"/>
                                    </g:else>
                                    <g:if test="${eventSupport?.equipments || eventSupport?.supportStaff}">
                                        <g:actionSubmit class="btn btn-default" value="Mark/Unmark Event Support Request as Fulfilled" action="markResourceAllocated"/>
                                    </g:if>
                                </g:form>
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