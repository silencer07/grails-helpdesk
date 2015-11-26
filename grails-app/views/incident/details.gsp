<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.themindmuseum.helpdesk.utils.DateUtils" %>
<%@ page import="org.themindmuseum.helpdesk.TicketStatus" %>
<html>
<head>
    <title>Incident Details</title>
    <meta name="layout" content="main"/>
</head>
<body>
<div id="wrapper">
    <div id="page-wrapper">
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">Incident Details</h1>
            </div>
            <!-- /.col-lg-12 -->
        </div>
        <div class="row">
            <div class="col-lg-10">
                <div class="panel panel-default">
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-lg-12">
                                <div class="form-group">
                                    <g:set var="timeFiledDate" value="${DateUtils.asDate(incident?.timeFiled)}"/>
                                    <div class="form-group">
                                        <label> Subject : ${incident?.subject}</label>
                                    </div>
                                    <div class="form-group">
                                        <label>Date : <g:formatDate date="${timeFiledDate}" format="MM/dd/yyyy"/></label>
                                    </div>
                                    <div class="form-group">
                                        <label> Time : <g:formatDate date="${timeFiledDate}" format="mm:ss a"/></label>
                                    </div>
                                    <div class="form-group">
                                       <label>Equipment : ${incident?.equipment.name}</label>
                                    </div>
                                    <div class="form-group">
                                        <label>Manufacturer : ${incident?.equipment.manufacturer}</label>
                                    </div>
                                    <div class="form-group">
                                        <label>Serial No. : ${incident?.equipment.serialNumber}</label>
                                    </div>
                                    <div class="form-group">
                                        <label>Status : ${incident?.status}</label>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label> Concern :</label>
                                    <textArea class="form-control" rows="3" readonly="true">${incident?.description}</textArea>
                                </div>
                                <div class="form-group">
                                    <label>notes:</label>
                                    <textArea class="form-control" rows="3" readonly="true">${incident?.resolutionNotes}</textArea>
                                </div>
                                <div class=form-group">
                                    <g:form method="post">
                                        <g:hiddenField name="incidentId" value="${incident?.id}"/>
                                        <g:if test="${incident?.status == TicketStatus.OPEN}">
                                            <div class="form-group">
                                                <label>Add additional notes:</label>
                                                <g:textArea class="form-control" rows="3" name="additionalNotes"/>
                                            </div>
                                            <div class="form-group">
                                                <g:actionSubmit class="btn btn-default" value="Add Notes" action="addAdditionalNotes"/>
                                                <g:actionSubmit class="btn btn-default" value="Resolve Incident" action="resolveIncident"/>
                                            </div>

                                        </g:if>
                                        <g:else>
                                            <div class="form-group">
                                            <g:actionSubmit class="btn btn-default" value="Reopen Incident" action="reopenIncident"/>
                                            </div>
                                        </g:else>
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