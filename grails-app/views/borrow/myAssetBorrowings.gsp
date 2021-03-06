<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.themindmuseum.helpdesk.utils.DateUtils" %>
<!DOCTYPE html>
<html>
<head>
    <title>My Resolved Borrow Requests</title>
    <meta name="layout" content="main"/>
</head>
<body>
<div id="wrapper">
    <div id="page-wrapper">
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">My Resolved Borrow Requests</h1>
            </div>
            <!-- /.col-lg-12 -->
        </div>
        <div class="row">
            <div class="col-lg-12">
                <div class="panel panel-default">
                    <div class="panel-body">
                        <div class="table-responsive">
                            <g:if test="${assetBorrowings}">
                                <table class="table table-striped">
                                    <thead>
                                    <th>Subject</th>
                                    <th>Time Filed</th>
                                    <th>Returning Time</th>
                                    </thead>
                                    <tbody>
                                    <g:each in="${assetBorrowings}" var="assetBorrowing">
                                        <tr>
                                            <td><g:link action="details" id="${assetBorrowing.id}">${assetBorrowing.subject}</g:link></td>
                                            <td><g:formatDate date="${DateUtils.asDate(assetBorrowing.timeFiled)}" format="MM/dd/yyyy hh:mm a"/></td>
                                            <td><g:formatDate date="${DateUtils.asDate(assetBorrowing.returningDate)}" format="MM/dd/yyyy hh:mm a"/></td>
                                        </tr>
                                    </g:each>
                                    </tbody>
                                </table>
                            </g:if>
                            <g:else>
                                <p>You have no resolved borrow requests.</p>
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