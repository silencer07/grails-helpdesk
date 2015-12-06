<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'equipment.label', default: 'Equipment')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
    <div id="wrapper">
        <div id="page-wrapper">
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">Equipment List</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-body">
                            <div class="table-responsive">
                                <div id="list-equipment" class="content scaffold-list" role="main">
                                    <g:if test="${flash.message}">
                                        <div class="message" role="status">${flash.message}</div>
                                    </g:if>
                                    <f:table collection="${equipmentList}"  />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div id="list-equipment" class="content scaffold-list" role="main">
                <g:if test="${flash.message}">
                    <div class="message" role="status">${flash.message}</div>
                </g:if>
                <f:table collection="${equipmentList}"  />
            </div>
        </div>
    </div>
    </body>
</html>