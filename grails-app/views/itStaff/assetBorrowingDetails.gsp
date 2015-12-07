<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.themindmuseum.helpdesk.utils.DateUtils" %>
<%@ page import="org.themindmuseum.helpdesk.TicketStatus" %>
<%@ page import="org.springframework.validation.FieldError" %>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Asset Borrowing Details</title>
    <asset:javascript src="equipmentAdding.js"/>
</head>
<body>
<div id="wrapper">
    <div id="page-wrapper">
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">Asset Borrowing Details</h1>
            </div>
            <!-- /.col-lg-12 -->
        </div>
        <div>
            <g:hasErrors bean="${assetBorrowing}">
                <div class="alert alert-danger">
                    <ul class="errors" role="alert">
                        <g:each in="${assetBorrowing.equipments}" var="equipment">
                            <g:eachError bean="${equipment}" var="error">
                                <li <g:if test="${error in FieldError}">data-field-id="${error.field}"</g:if>>
                                    <g:message error="${error}"/>
                                </li>
                            </g:eachError>
                        </g:each>
                    </ul>
                </div>
            </g:hasErrors>
        </div>
        <div class ="row">
            <div class="col-lg-10">
                <div class="panel panel-default">
                    <div class="panel-body">
                        <g:form method="post">
                        <div class="table-responsive">
                            <table  class="table">
                                <tbody>

                                    <g:hiddenField name="assetBorrowingId" value="${assetBorrowing.id}"/>
                                    <tr>
                                        <td>Subject:</td>
                                        <td>${assetBorrowing?.subject}</td>
                                    </tr>
                                    <tr>
                                        <td>Time Filed:</td>
                                        <td> <g:formatDate date="${DateUtils.asDate(assetBorrowing?.timeFiled)}" format="MM/dd/yyyy hh:mm a"/></td>
                                    </tr>
                                    <tr>
                                        <td>Borrow Time:</td>
                                        <td> <g:formatDate date="${DateUtils.asDate(assetBorrowing?.borrowedDate)}" format="MM/dd/yyyy hh:mm a"/></td>
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
                                    <tr>
                                        <td>Requested by:</td>
                                        <td>${assetBorrowing.reportedBy}</td>
                                    </tr>
                                    <tr>
                                        <td>Assigned to:</td>
                                        <td>${assetBorrowing.assignee}</td>
                                    </tr>
                                    <g:if test="${assetBorrowing?.assetLent}">
                                        <tr>
                                            <td>Returned Time:</td>
                                            <td><g:formatDate date="${assetBorrowing?.returnedDate ? DateUtils.asDate(assetBorrowing?.returnedDate) : null}"
                                                              format="MM/dd/yyyy hh:mm a"/></td>
                                        </tr>
                                    </g:if>
                                </tbody>
                            </table>
                        </div>
                        <!-- /table class responsive -->
                        <div class="row">
                            <div class="col-lg-12">
                                <div class="form-group">
                                    <g:set var="equipmentIndex" value="0"/>
                                    <g:if test="${assetBorrowing?.equipments}">
                                        <g:set var="equipmentIndex" value="${assetBorrowing?.equipments.size()}"/>
                                        <div class="table-responsive">
                                            <table class= "table table-bordered">
                                                <thead>
                                                <th>Equipment</th>
                                                <th>Serial Number</th>
                                                <g:if test="${assetBorrowing?.status == TicketStatus.OPEN}">
                                                    <th></th>
                                                </g:if>
                                                </thead>
                                                <tbody>
                                                <g:each in="${assetBorrowing?.equipments}" var="equipment" status="i">
                                                    <tr id="added-equipment-${i}">
                                                        <td>${equipment?.name}</td>
                                                        <g:if test="${assetBorrowing?.status == TicketStatus.OPEN}">
                                                            <td><g:textField name="equipments[${i}].serialNumber" value="${equipment?.serialNumber}" readonly="readonly"/></td>
                                                            <td><input type="button" value="Remove Equipment" onclick="removeEquipment(('added-equipment-${i}'))"/></td>
                                                        </g:if>
                                                        <g:else>
                                                            <td>${equipment?.serialNumber}
                                                                <g:hiddenField name="equipments[${i}].serialNumber" value="${equipment?.serialNumber}"/></td>
                                                        </g:else>
                                                    </tr>
                                                </g:each>
                                                </tbody>
                                            </table>
                                            <!-- /table itself-->
                                        </div>
                                        <!-- /table class responsive of serial number-->
                                    </g:if>
                                </div>
                                <!-- /serial equipment -->
                                <div class="form-group">
                                <g:if test="${assetBorrowing?.status == TicketStatus.OPEN}">
                                    <div id="additional-equipment-div">
                                        <div class="form-group">
                                            <label>Serial Number:</label>
                                            <g:textField class="form-control" rows="1" name="equipments[${equipmentIndex}].serialNumber"/>
                                        </div>
                                        <input type="button" class="btn btn-default"  id="add-equipment" value="Add Equipment" onclick="addEquipment()"/>
                                    </div>
                                </g:if>
                                </div>
                                <!-- /serial number -->
                                <div class="form-group">
                                   <label>Description:</label>
                                    <textArea class="form-control" rows="3" readonly="true">${assetBorrowing?.description}</textArea><br/>
                                </div>
                                <!-- /description -->
                                <div class="form-group">
                                    <label>Notes:</label>
                                    <textArea class="form-control" rows="3"  readonly="true">${assetBorrowing?.resolutionNotes}</textArea>
                                </div>
                                <!-- /notes -->
                                <div class="form-group">
                                <g:hiddenField name="assetBorrowingId" value="${assetBorrowing?.id}"/>
                                <g:if test="${assetBorrowing?.status == TicketStatus.OPEN}">
                                    <div class="form-group">
                                        <label>Add Additional Notes:</label>
                                        <g:textArea class="form-control" rows="3"  name="additionalNotes"/>
                                    </div>
                                    <div class="form-group">
                                        <g:actionSubmit class="btn btn-default" value="Save Changes" action="saveAssetBorrowingChanges"/>
                                        <g:actionSubmit class="btn btn-default" value="Resolve Borrowing Request" action="resolveAssetBorrowing"/>
                                    </div>
                                </g:if>
                                <g:else>
                                    <div class="form-group">
                                        <g:actionSubmit class="btn btn-default" value="Reopen Borrowing Request" action="reopenAssetBorrowing"/>
                                    </div>
                                </g:else>
                                <g:if test="${assetBorrowing?.equipments}">
                                    <div class="form-group">
                                        <g:actionSubmit class="btn btn-default" value="Mark/Unmark Borrow Request as Fulfilled" action="markAssetLent"/>
                                    </div>
                                </g:if>
                                </div>
                                <!-- /add additional notes and buttons -->
                            </div>
                        </div>
                        <!-- /row for all buttons not included in the table -->
                        </g:form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</div>
</body>
</html>
