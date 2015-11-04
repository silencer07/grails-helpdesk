<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.themindmuseum.helpdesk.utils.DateUtils" %>
<!DOCTYPE html>
<html>
<head>
    <title>My Resolved Event Support Requests</title>
    <meta name="layout" content="main"/>
</head>
<body>
<h1>My Resolved Event Support Requests</h1>
<div>
    <g:if test="${eventSupports}">
        <table>
            <thead>
            <th>Subject</th>
            <th>Start Time</th>
            <th>End Time</th>
            </thead>
            <tbody>
            <g:each in="${eventSupports}" var="eventSupport">
                <tr>
                    <td><g:link action="details" id="${eventSupport.id}">${eventSupport.subject}</g:link></td>
                    <td><g:formatDate date="${DateUtils.asDate(eventSupport.startTime)}" format="MM/dd/yyyy hh:mm"/></td>
                    <td><g:formatDate date="${DateUtils.asDate(eventSupport.endTime)}" format="MM/dd/yyyy hh:mm"/></td>
                </tr>
            </g:each>
            </tbody>
        </table>
    </g:if>
    <g:else>
        <p>You have no resolved event support requests.</p>
    </g:else>
</div>
</body>

</html>