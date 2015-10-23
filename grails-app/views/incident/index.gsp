<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>File an incident</title>
</head>
<body>
    <h1>File an incident</h1>
    <div>
        <div>
            <ul>
                <li>Subject is required</li>
                <li>Serial number is required</li>
            </ul>
        </div>
        <div>
            <!--Of course this should be arranged this way in UI. NO USING of <br/> -->
            Subject : <g:textField name="subject"/> <!--REMOVE THESE <br/>-->  <br/>
            Equipment serial number : <g:textField name="serialNumber"/>       <br/>
            Concern: <g:textArea name="description"/>                          <br/>
            <input type="submit" value="OK"/>
        </div>
    </div>
</body>
</html>