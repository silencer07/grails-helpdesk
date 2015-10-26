<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Borrow an Asset</title>
    <meta name="layout" content="main"/>
    <script>
        $(document).ready(function(){
            alert("hello");
        });
        alert("before hello");
    </script>
</head>
<body>
    <h1>Borrow an Asset</h1>
    <div>
        <div>
            <g:hasErrors bean="${cmd}">
                <ul class="errors" role="alert">
                    <g:eachError bean="${cmd}" var="error">
                        <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                    </g:eachError>
                </ul>
            </g:hasErrors>
        </div>
        <div>
            Asset Name : <g:textField name="subject"/> <br/>
            Borrow from: <g:textField name="borrowDate"/> <br/>
            Return in: <g:textField name="returningDate"/> <br/>
            Description: <g:textArea name="description"/> <br/>
            <g:submitButton name="OK"/>
        </div>
    </div>
</body>

</html>