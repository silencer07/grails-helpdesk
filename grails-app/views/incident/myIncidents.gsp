<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.themindmuseum.helpdesk.utils.DateUtils" %>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>My Incidents </title>
</head>
<body>
    <div id="wrapper">
        <div id="page-wrapper">
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">${title}</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-body">
                            <div class="table-responsive">
                                <g:if test="${incidents}">
                                    <table  class="table table-striped">
                                        <thead>
                                        <th>Concern</th>
                                        <th>Filed Date</th>
                                        <th>Filed Time</th>
                                        <th>Status</th>
                                        </thead>
                                        <tbody>
                                        <g:each in="${incidents}" var="incident">
                                            <g:set var="timeFiledDate" value="${DateUtils.asDate(incident.timeFiled)}"/>
                                            <tr>
                                                <td><g:link action="details" id="${incident.id}">${incident.subject}</g:link></td>
                                                <td><g:formatDate date="${timeFiledDate}" format="MM/dd/yyyy"/></td>
                                                <td><g:formatDate date="${timeFiledDate}" format="hh:mm a"/></td>
                                                <td>${incident.status}</td>
                                            </tr>
                                        </g:each>
                                        </tbody>
                                    </table>
                                </g:if>
                                <g:else>
                                    <p>You have no filed incidents.</p>
                                </g:else>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>