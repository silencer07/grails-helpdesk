<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.springframework.validation.FieldError" %>
<!DOCTYPE html>
<html>
<head>
    <title>${title}</title>
    <meta name="layout" content="main"/>
    <script>
        $(document).ready(function(){
            console.log("here");
            var calendar = $('#calendar');
            calendar.fullCalendar({
                header: {
                    left: 'prev,next today',
                    center: 'title',
                    right: 'month,agendaWeek,agendaDay'
                }
            })
        });
    </script>
</head>
<body>
<div id="wrapper">
    <div id="page-wrapper">
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">${title}</h1>
            </div>
            <!-- /.col-lg-12 -->
        </div>
        <div id='calendar'></div>
    </div>
</div>
</body>

</html>