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
                    <h1 class="page-header">Support Tickets Summary</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <div>
                Unassigned Incidents
                <g:if test="${unassignedIncidents}">
                    <table>
                        <thead>
                        <th>Concern</th>
                        <th>File Date</th>
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
            <div>
                Assigned Incidents
                <g:if test="${assignedIncidents}">
                    <table>
                        <thead>
                        <th>Concern</th>
                        <th>File Date</th>
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
            <div>
                Pending Borrowed Equipments Requests
                <g:if test="${pendingBorrowRequests}">
                    <table>
                        <thead>
                        <th>Equipment</th>
                        <th>Filed Date</th>
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
            <div>
                Approved borrowing of equipments
                <g:if test="${approvedBorrowRequests}">
                    <table>
                        <thead>
                        <th>Equipment</th>
                        <th>Filed Date</th>
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
            <div>
                Upcoming events to Support
                <g:if test="${upcomingEventsToSupports}">
                    <table>
                        <thead>
                        <th>Event name</th>
                        <th>Date</th>
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
            <div>
                Event Support Requests
                <g:if test="${openEventSupports}">
                    <table>
                        <thead>
                        <th>Event name</th>
                        <th>Date</th>
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
    </body>
</html>
