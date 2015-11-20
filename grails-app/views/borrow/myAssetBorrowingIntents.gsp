<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.themindmuseum.helpdesk.utils.DateUtils" %>
<!DOCTYPE html>
<html>
<head>
    <title>My Pending Borrow Requests</title>
    <meta name="layout" content="main"/>
</head>
<body>
<div id="wrapper">
    <div id="page-wrapper">
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">My Pending Borrow Requests</h1>
            </div>
            <!-- /.col-lg-12 -->
        </div>
        <g:if test="${intents}">
            <table>
                <thead>
                <th>Subject</th>
                <th>Filed Date</th>
                <th>Filed Time</th>
                <th>Status</th>
                </thead>
                <tbody>
                <g:each in="${intents}" var="intent">
                    <g:set var="timeFiledDate" value="${DateUtils.asDate(intent.timeFiled)}"/>
                    <tr>
                        <td><g:link action="details" id="${intent.id}">${intent.subject}</g:link></td>
                        <td><g:formatDate date="${timeFiledDate}" format="MM/dd/yyyy"/></td>
                        <td><g:formatDate date="${timeFiledDate}" format="hh:mm a"/></td>
                        <td>${intent.status}</td>
                    </tr>
                </g:each>
                </tbody>
            </table>
        </g:if>
        <g:else>
            <p>You have no borrow requests.</p>
        </g:else>
    </div>
</div>
</body>

</html>