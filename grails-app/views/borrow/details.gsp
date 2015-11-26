<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.themindmuseum.helpdesk.utils.DateUtils" %>
<%@ page import="org.themindmuseum.helpdesk.TicketStatus" %>
<html>
<head>
    <title>My Asset Borrowing Details</title>
    <meta name="layout" content="main"/>
</head>
<body>
<div id="wrapper">
    <div id="page-wrapper">
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">My Asset Borrowing Details</h1>
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
                                        <td>${assetBorrowing?.subject}</td>
                                    </tr>
                                    <tr>
                                        <td>Time Filed</td>
                                        <td><g:formatDate date="${DateUtils.asDate(assetBorrowing?.timeFiled)}" format="MM/dd/yyyy hh:mm a"/></td>
                                    </tr>
                                    <tr>
                                        <td>Borrowing Time:</td>
                                        <td><g:formatDate date="${DateUtils.asDate(assetBorrowing?.borrowedDate)}" format="MM/dd/yyyy hh:mm a"/></td>
                                    </tr>
                                    <tr>
                                        <td>Returning Time:</td>
                                        <td><g:formatDate date="${DateUtils.asDate(assetBorrowing?.returningDate)}" format="MM/dd/yyyy hh:mm a"/></td>
                                    </tr>
                                    <tr>
                                        <td>Status:</td>
                                        <td>${assetBorrowing.status}</td>
                                    </tr>
                                    <tr>
                                        <td>Borrowing Request Fulfilled:</td>
                                        <td><g:formatBoolean boolean="${assetBorrowing.assetLent}" true="Yes" false="No"/></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <div class="table-responsive">
                            <g:if test="${assetBorrowing?.assetLent}">
                                <label>
                                    Returned Time:
                                    <g:formatDate date="${assetBorrowing?.returnedDate ? DateUtils.asDate(assetBorrowing?.returnedDate) : null}"
                                                              format="MM/dd/yyyy hh:mm a"/>
                                </label>
                                <g:if test="${assetBorrowing?.equipments}">
                                    <table class="table table-bordered">
                                        <thead>
                                        <th>Equipment</th>
                                        <th>Serial Number</th>
                                        </thead>
                                        <tbody>
                                        <g:each in="${assetBorrowing?.equipments}" var="equipment">
                                            <tr>
                                                <td>${equipment.name}</td>
                                                <td>${equipment.serialNumber}</td>
                                            </tr>
                                        </g:each>
                                        </tbody>
                                    </table>
                                </g:if>
                            </g:if>
                        </div>
                        <div class="row">
                            <div class="col-lg-12">
                                <div class="form-group">
                                    <label> Description:</label>
                                    <textArea class="form-control" rows="3" readonly="true">${assetBorrowing?.description}</textArea>
                                </div>
                                <div class="form-group">
                                    <label>Notes:</label>
                                    <textArea class="form-control" rows="3" readonly="true">${assetBorrowing?.resolutionNotes}</textArea>
                                </div>
                                <div class="form-group">
                                    <g:form method="post">
                                        <g:hiddenField name="assetBorrowingId" value="${assetBorrowing?.id}"/>
                                        <g:if test="${assetBorrowing?.status == TicketStatus.OPEN}">
                                            <label>Add additional notes:</label>
                                            <g:textArea class="form-control" rows="3" name="additionalNotes"/>
                                            <g:actionSubmit class="btn btn-default" value="Add Notes" action="addAdditionalNotes"/>
                                            <g:actionSubmit class="btn btn-default" value="Resolve Borrowing Request" action="resolveAssetBorrowing"/>
                                        </g:if>
                                        <g:else>
                                            <g:actionSubmit class="btn btn-default" value="Reopen Borrowing Request" action="reopenAssetBorrowing"/>
                                        </g:else>
                                        <g:if test="${assetBorrowing?.equipments}">
                                            <g:actionSubmit class="btn btn-default" value="Mark/Unmark Borrow Request as Fulfilled" action="markAssetLent"/>
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
</div>
</body>
</html>