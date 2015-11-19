<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.themindmuseum.helpdesk.utils.DateUtils" %>
<html>
    <head>
        <meta name="layout" content="main"/>
        <title>Employee Home</title>
    </head>
    <body>
    <div id="wrapper">
        <div id="page-wrapper">
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">Home</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            My Unresolved Incidents
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            <div class="table-responsive">
                                <g:if test="${openIncidents}">
                                    <table class="table table-striped">
                                        <thead>
                                        <tr>
                                            <th>#</th>
                                            <th>Concern</th>
                                            <th>File Date</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                            <g:each in="${openIncidents}" var="incident" status="i">
                                                <tr>
                                                    <td>${i + 1}</td>
                                                    <td>
                                                        <g:link controller="incident" action="details" id="${incident.id}">${incident.subject}</g:link>
                                                    </td>
                                                    <td><g:formatDate date="${DateUtils.asDate(incident.timeFiled)}"
                                                      format="MM/dd/yyyy hh:mm a"/></td>
                                                </tr>
                                            </g:each>
                                        </tbody>
                                    </table>
                                </g:if>
                                <g:else>
                                    <p>No incidents filed</p>
                                </g:else>
                            </div>
                            <!-- /.table-responsive -->
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-6 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Pending Borrow Requests
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            <div class="table-responsive">
                                <g:if test="${pendingBorrowRequest}">
                                    <table class="table table-striped">
                                        <thead>
                                            <th>#</th>
                                            <th>Subject</th>
                                            <th>Borrow Date</th>
                                        </thead>
                                        <tbody>
                                            <g:each in="${pendingBorrowRequest}" var="borrowReq" status="i">
                                                <tr class="${DateUtils.isPastAlready(borrowReq.borrowedDate) ? 'danger' : ''}">
                                                    <td>${i + 1}</td>
                                                    <td><g:link controller="borrow" action="details"
                                                        id="${borrowReq.id}">${borrowReq.subject}</g:link></td>
                                                    <td><g:formatDate date="${DateUtils.asDate(borrowReq.borrowedDate)}"
                                                        format="MM/dd/yyyy hh:mm a"/></td>
                                                </tr>
                                            </g:each>
                                        </tbody>
                                    </table>
                                </g:if>
                                <g:else>
                                    <p>No pending request</p>
                                </g:else>
                            </div>
                            <!-- /.table-responsive -->
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-6 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Approved Borrow Requests
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            <div class="table-responsive">
                                <g:if test="${approvedBorrowRequest}">
                                    <table class="table table-striped">
                                        <thead>
                                            <th>#</th>
                                            <th>Subject</th>
                                            <th>Returning Date</th>
                                        </thead>
                                        <tbody>
                                        <g:each in="${approvedBorrowRequest}" var="borrowReq" status="i">
                                            <tr class="${DateUtils.isPastAlready(borrowReq.returningDate) ? 'danger' : ''}">
                                                <td>${i + 1}</td>
                                                <td><g:link controller="borrow" action="details"
                                                            id="${borrowReq.id}">${borrowReq.subject}</g:link></td>
                                                <td><g:formatDate date="${DateUtils.asDate(borrowReq.returningDate)}"
                                                                  format="MM/dd/yyyy hh:mm a"/></td>
                                            </tr>
                                        </g:each>
                                        </tbody>
                                    </table>
                                </g:if>
                                <g:else>
                                    <p>No approved request</p>
                                </g:else>
                            </div>
                            <!-- /.table-responsive -->
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-6 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Pending Event Support Request
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            <div class="table-responsive">
                                <g:if test="${pendingEventSupport}">
                                    <table class="table table-striped">
                                        <thead>
                                            <th>#</th>
                                            <th>Event Name</th>
                                            <th>Start Date</th>
                                            <th>End Date</th>
                                        </thead>
                                        <tbody>
                                            <g:each in="${pendingEventSupport}" var="event" status="i">
                                                <tr class="${DateUtils.isPastAlready(event.startTime) ? 'danger' : ''}">
                                                    <td>${i + 1}</td>
                                                    <td><g:link controller="eventSupport" action="details"
                                                            id="${event.id}">${event.subject}</g:link></td>
                                                    <td><g:formatDate date="${DateUtils.asDate(event.startTime)}"
                                                                      format="MM/dd/yyyy hh:mm a"/></td>
                                                    <td><g:formatDate date="${DateUtils.asDate(event.endTime)}"
                                                                      format="MM/dd/yyyy hh:mm a"/></td>
                                                </tr>
                                            </g:each>
                                        </tbody>
                                    </table>
                                </g:if>
                                <g:else>
                                    <p>No pending event support request</p>
                                </g:else>
                            </div>
                            <!-- /.table-responsive -->
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-6 -->
            </div>
            <!-- /.row -->
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Upcoming Events
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            <div class="table-responsive">
                                <g:if test="${pastEventSupport}">
                                    <table class="table table-striped">
                                        <thead>
                                        <th>#</th>
                                        <th>Event Name</th>
                                        <th>Start Date</th>
                                        <th>End Date</th>
                                        </thead>
                                        <tbody>
                                        <g:each in="${pastEventSupport}" var="event" status="i">
                                            <tr class="${DateUtils.isPastAlready(event.endTime) ? 'danger' : ''}">
                                                <td>${i + 1}</td>
                                                <td><g:link controller="eventSupport" action="details"
                                                            id="${event.id}">${event.subject}</g:link></td>
                                                <td><g:formatDate date="${DateUtils.asDate(event.startTime)}"
                                                                  format="MM/dd/yyyy hh:mm a"/></td>
                                                <td><g:formatDate date="${DateUtils.asDate(event.endTime)}"
                                                                  format="MM/dd/yyyy hh:mm a"/></td>
                                            </tr>
                                        </g:each>
                                        </tbody>
                                    </table>
                                </g:if>
                                <g:else>
                                    <p>No upcoming events</p>
                                </g:else>
                            </div>
                            <!-- /.table-responsive -->
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-6 -->
            </div>
            <!-- /.row -->

        </div>
        <!-- /#page-wrapper -->
    </div>
    </body>
</html>
