<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.springframework.validation.FieldError" %>
<!DOCTYPE html>
<html>
<head>
    <title>Borrow an Asset</title>
    <meta name="layout" content="main"/>
    <script>
        $(document).ready(function(){
            applyDateTimePickerStyle('borrowedDate');
            applyDateTimePickerStyle('returningDate');
        });
    </script>
</head>
<body>
<div id="wrapper">
    <div id="page-wrapper">
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">Equipment Borrowing Request</h1>
            </div>
            <!-- /.col-lg-12 -->
        </div>
            <g:hasErrors bean="${assetBorrowingIntent}">
                <div class="alert alert-danger">
                    <ul class="errors" role="alert">
                        <g:eachError bean="${assetBorrowingIntent}" var="error">
                            <li <g:if test="${error in FieldError}">data-field-id="${error.field}"</g:if>>
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
                        File an Equipment Borrowing Ticket
                    </div>
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-lg-12">
                                <g:form controller="borrow" action="saveAssetBorrowingIntent" role="form">
                                    <div class="form-group">
                                        <label>Subject:</label>
                                        <g:textField class="form-control" placeholder="e.g. HDMI cable" name="subject" value="${assetBorrowingIntent?.subject}"/>
                                    </div>
                                    <div class="form-group">
                                        <label>Borrow from:</label>
                                        <g:textField class="form-control" name="borrowedDate"/>
                                    </div>
                                    <div class="form-group">
                                        <label>Return in:</label>
                                        <g:textField class="form-control" name="returningDate"/>
                                    </div>
                                    <div class="form-group">
                                        <label>Description:</label>
                                        <g:textArea class="form-control" rows="3" name="description" value="${assetBorrowingIntent?.description}"/>
                                    </div>
                                    <div class="form-group">
                                        <g:submitButton class="btn btn-default" value="Submit" name="submit"/>
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