<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.themindmuseum.helpdesk.utils.DateUtils" %>
<%@ page import="org.themindmuseum.helpdesk.TicketStatus" %>
<html>
    <head>
        <meta name="layout" content="main"/>
        <title>Support Tickets Summary</title>
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
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Unassigned Incidents
                        </div>
                        <div class="panel-body">
                            <div class="table-responsive">
                                <g:if test="${unassignedIncidents}">
                                    <table class="table table-striped">
                                        <thead>
                                        <tr>
                                            <th>Concern</th>
                                            <th>File Date</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <g:each in="${unassignedIncidents}" var="incident">
                                            <tr>
                                                <td><g:link action="incidentDetails" id="${incident.id}">${incident.subject}</g:link></td>
                                                <td><g:formatDate date="${DateUtils.asDate(incident.timeFiled)}" format="MM/dd/yyyy hh:mm a"/></td>
                                            </tr>
                                        </g:each>
                                        </tbody>
                                    </table>
                                </g:if>
                                <g:else>
                                    <p>No Filed Incidents</p>
                                </g:else>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- / unassigned tickets-->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Assigned Incidents
                        </div>
                        <div class="panel-body">
                            <div class="table-responsive">
                                <g:if test="${assignedIncidents}">
                                    <table class="table table-striped">
                                        <thead>
                                        <tr>
                                            <th>Concern</th>
                                            <th>File Date</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <g:each in="${assignedIncidents}" var="incident">
                                            <tr>
                                                <td><g:link action="incidentDetails" id="${incident.id}">${incident.subject}</g:link></td>
                                                <td><g:formatDate date="${DateUtils.asDate(incident.timeFiled)}" format="MM/dd/yyyy hh:mm a"/></td>
                                            </tr>
                                        </g:each>
                                        </tbody>
                                    </table>
                                </g:if>
                                <g:else>
                                    <p>No Assigned Incidents</p>
                                </g:else>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- / assigned tickets-->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Pending Borrowed Equipments Requests
                        </div>
                        <div class="panel-body">
                            <div class="table-responsive">
                                <g:if test="${pendingBorrowRequests}">
                                    <table class="table table-striped">
                                        <thead>
                                        <tr>
                                            <th>Equipment</th>
                                            <th>Filed Date</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <g:each in="${pendingBorrowRequests}" var="borrowRequest">
                                            <tr>
                                                <td><g:link action="assetBorrowingDetails" id="${borrowRequest.id}">${borrowRequest.subject}</g:link></td>
                                                <td><g:formatDate date="${DateUtils.asDate(borrowRequest.timeFiled)}" format="MM/dd/yyyy hh:mm a"/></td>
                                            </tr>
                                        </g:each>
                                        </tbody>
                                    </table>
                                </g:if>
                                <g:else>
                                    <p>No Borrow Requests Pending</p>
                                </g:else>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- / pending Borrowed Equipments Requests-->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Approved borrowing of equipments
                        </div>
                        <div class="panel-body">
                            <div class="table-responsive">
                                <g:if test="${approvedBorrowRequests}">
                                    <table class="table table-striped">
                                        <thead>
                                        <tr>
                                            <th>Equipment</th>
                                            <th>Filed Date</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <g:each in="${approvedBorrowRequests}" var="borrowRequest">
                                            <tr>
                                                <g:if test="${TicketStatus.unresolvedStatuses.contains(borrowRequest.status)}">
                                                    <td><g:link action="assetBorrowingDetails" id="${borrowRequest.id}">${borrowRequest.subject}</g:link></td>
                                                </g:if>
                                                <g:else>
                                                    <td><g:link action="receiveBorrowedAssets" id="${borrowRequest.id}">${borrowRequest.subject}</g:link></td>
                                                </g:else>
                                                <td><g:formatDate date="${DateUtils.asDate(borrowRequest.timeFiled)}" format="MM/dd/yyyy hh:mm a"/></td>
                                            </tr>
                                        </g:each>
                                        </tbody>
                                    </table>
                                </g:if>
                                <g:else>
                                    <p>No Approved Requests</p>
                                </g:else>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- / Approved borrowing of equipments-->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Upcoming events to Support
                        </div>
                        <div class="panel-body">
                            <div class="table-responsive">
                                <g:if test="${upcomingEventsToSupports}">
                                    <table class="table table-striped">
                                        <thead>
                                        <tr>
                                            <th>Event name</th>
                                            <th>Date</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <g:each in="${upcomingEventsToSupports}" var="event">
                                            <tr>
                                                <td><g:link action="receiveEventAssets" id="${event.id}">${event.subject}</g:link></td>
                                                <td><g:formatDate date="${DateUtils.asDate(event.startTime)}" format="MM/dd/yyyy hh:mm a"/></td>
                                            </tr>
                                        </g:each>
                                        </tbody>
                                    </table>
                                </g:if>
                                <g:else>
                                    <p>No upcoming events assigned/to support</p>
                                </g:else>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- / Upcoming events to Support-->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Event Support Requests
                        </div>
                        <div class="panel-body">
                            <div class="table-responsive">
                                <g:if test="${openEventSupports}">
                                    <table class="table table-striped">
                                        <thead>
                                        <tr>
                                            <th>Event name</th>
                                            <th>Date</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <g:each in="${openEventSupports}" var="event">
                                            <tr>
                                                <td><g:link action="eventDetails" id="${event.id}">${event.subject}</g:link></td>
                                                <td><g:formatDate date="${DateUtils.asDate(event.startTime)}" format="MM/dd/yyyy hh:mm a"/></td>
                                            </tr>
                                        </g:each>
                                        </tbody>
                                    </table>
                                </g:if>
                                <g:else>
                                    <p>No upcoming event support requests</p>
                                </g:else>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- / Event Support Requests-->
        </div>
    </div>
    </body>
</html>
