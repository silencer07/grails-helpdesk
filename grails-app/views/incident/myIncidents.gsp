<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.themindmuseum.helpdesk.utils.DateUtils" %>
<html>
<head>
    <title>My Incidents</title>
</head>
<body>
    <h1>My Incidents</h1>
    <div>
        <div>
            <g:if test="${incidents}">
                <table>
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
                                <td><g:formatDate date="${timeFiledDate}" format="hh:mm"/></td>
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
</body>
</html>