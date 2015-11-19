<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>File an incident</title>
</head>
<body>
<div id="wrapper">
    <div id="page-wrapper">
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">Incident Ticket</h1>
            </div>
            <!-- /.col-lg-12 -->
        </div>
        <g:hasErrors bean="${incident}">
            <div class="alert alert-danger">
                <ul class="errors" role="alert">
                    <g:eachError bean="${incident}" var="error">
                        <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>>
                            <g:message error="${error}"/>
                        </li>
                    </g:eachError>
                </ul>
            </div>
        </g:hasErrors>
        <g:if test="${successMessage}">
            <div class="alert alert-success">
                ${successMessage}
            </div>
        </g:if>

        <!-- /.row -->
        <div class="row">
            <div class="col-lg-10">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        File an Incident Ticket
                    </div>
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-lg-12">
                                <g:form controller="incident" action="saveIncident" role="form">
                                    <div class="form-group">
                                        <label> Subject </label>
                                        <g:textField name="subject" value="${incident?.subject}"
                                             class="form-control" placeholder="e.g. Mouse not working"/>
                                    </div>
                                    <div class="form-group">
                                        <label> Equipment Serial Number</label>
                                        <g:textField name="serialNumber" value="${incident?.serialNumber}"
                                             class="form-control" placeholder="Serial number here"/>
                                    </div>

                                    <div class="form-group">
                                        <label>Concern</label>
                                        <g:textArea name="description" value="${incident?.description}"
                                                    class="form-control" rows="3"/>
                                    </div>
                                    <g:submitButton name="submit" value="File Ticket" class="btn btn-default"/>
                                </g:form>
                            </div>
                            <!-- /.col-lg-6 (nested) -->
                        </div>
                        <!-- /.row (nested) -->
                    </div>
                    <!-- /.panel-body -->
                </div>
                <!-- /.panel -->
            </div>
            <!-- /.col-lg-12 -->
        </div>
        <!-- /.row -->
    </div>
    <!-- /#page-wrapper -->

</div>
</body>
</html>