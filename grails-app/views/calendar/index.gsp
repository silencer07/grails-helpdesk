<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.springframework.validation.FieldError" %>
<!DOCTYPE html>
<html>
<head>
    <title>${title}</title>
    <meta name="layout" content="main"/>
    <script>
        $(document).ready(function(){
            $('#calendar').fullCalendar({
                header: {
                    left: 'prev,next today',
                    center: 'title',
                    right: 'month,basicWeek,basicDay'
                },
                defaultDate: '2015-12-12',
                editable: true,
                displayEventEnd : true,
                events: [
                    <g:each in="${calendar}" status="i" var="c">
                        {
                            title : '${c.title}',
                            start : '<g:formatDate date="${c.start}" format="yyyy-MM-dd'T'hh:mm:ss"/>',
                            end : '<g:formatDate date="${c.end}" format="yyyy-MM-dd'T'hh:mm:ss"/>'
                        }
                        ,
                    </g:each>
                ],
                eventRender: function(event, element) {
                    element.find('.fc-time').append("<br/>");
                }

            });
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