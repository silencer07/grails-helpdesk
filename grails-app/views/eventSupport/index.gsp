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
                <h1 class="page-header">Create Event Support Ticket</h1>
            </div>
            <!-- /.col-lg-12 -->
        </div>
        <div>
            <g:hasErrors bean="${eventSupportIntent}">
                <ul class="errors" role="alert">
                    <g:eachError bean="${eventSupportIntent}" var="error">
                        <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>>
                            <g:message error="${error}"/>
                        </li>
                    </g:eachError>
                </ul>
            </g:hasErrors>
        </div>
        <div>
            <g:form action="saveEventSupportIntent">
                Event Title : <g:textField name="subject" value="${eventSupportIntent?.subject}"/> <!--REMOVE THESE <br/>-->  <br/>
                Venue: <g:textField name="venue" value="${eventSupportIntent?.venue}"/>                          <br/>
                Start Time : <g:textField name="startTime"/> <br/>
                End Time: <g:textField name="endTime"/> <br/>
                Equipments/Support staff needed: <g:textArea name="description" value="${eventSupportIntent?.description}"/>                          <br/>
                <input type="submit" value="OK"/>
            </g:form>
        </div>
    </div>
</div>
</body>
</html>