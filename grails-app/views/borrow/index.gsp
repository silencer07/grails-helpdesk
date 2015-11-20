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
                <h1 class="page-header">Borrow an Asset</h1>
            </div>
            <!-- /.col-lg-12 -->
        </div>
        <div>
            <g:hasErrors bean="${assetBorrowingIntent}">
                <ul class="errors" role="alert">
                    <g:eachError bean="${assetBorrowingIntent}" var="error">
                        <li <g:if test="${error in FieldError}">data-field-id="${error.field}"</g:if>>
                            <g:message error="${error}"/>
                        </li>
                    </g:eachError>
                </ul>
            </g:hasErrors>
        </div>
        <div>
            <g:form action="saveAssetBorrowingIntent">
                Subject : <g:textField name="subject" value="${assetBorrowingIntent?.subject}"/> <br/>
                Borrow from: <g:textField name="borrowedDate"/> <br/>
                Return in: <g:textField name="returningDate"/> <br/>
                Description: <g:textArea name="description" value="${assetBorrowingIntent?.description}"/> <br/>
                <g:submitButton name="OK"/>
            </g:form>
        </div>
    </div>
</div>
</body>

</html>