<%@ page import="org.springframework.validation.FieldError" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Create Event Support Ticket</title>
    <meta name="layout" content="main"/>
    <script>
        $(document).ready(function(){
            applyDateTimePickerStyle('startTime');
            applyDateTimePickerStyle('endTime');
        });
    </script>
</head>
<body>
<div id="wrapper">
    <div id="page-wrapper">
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">Event Support Ticket</h1>
            </div>
            <!-- /.col-lg-12 -->
        </div>
        <g:hasErrors bean="${eventSupportIntent}">
            <div class="alert alert-danger">
                <ul class="errors" role="alert">
                    <g:eachError bean="${eventSupportIntent}" var="error">
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
        <div class="row">
            <div class="col-lg-10">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        File an Event Support Request
                    </div>
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-lg-12">
                                <g:form controller="eventSupport" action="saveEventSupportIntent" role="form">
                                    <div class="form-group">
                                        <label>Event Title:</label>
                                        <g:textField class="form-control" placeholder="e.g. Star Wars Premier" name="subject" value="${eventSupportIntent?.subject}"/>
                                    </div>
                                    <div class="form-group">
                                        <label>Venue:</label>
                                        <g:textField class="form-control" name="venue" value="${eventSupportIntent?.venue}"/>
                                    </div>
                                    <div class="form-group">
                                        <label>Start Time:</label>
                                        <g:textField class="form-control" name="startTime"/>
                                    </div>
                                    <div class="form-group">
                                        <label>End Time:</label>
                                        <g:textField class="form-control" name="endTime"/>
                                    </div>
                                    <div class="form-group">
                                        <label>Equipments/Support staff needed:</label>
                                        <g:textArea class="form-control" rows="3" name="description" value="${eventSupportIntent?.description}"/>
                                    </div>
                                    <div class="form-group">
                                        <input class="btn btn-default" type="submit" value="Submit"/>
                                    </div>
                                </g:form>
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