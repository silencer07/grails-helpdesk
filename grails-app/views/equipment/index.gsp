<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'equipment.label', default: 'Equipment')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
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
                                <table class="table table-bordered">
                                    <thead>
                                    <tr>
                                        <th class="sortable"><a
                                                href="/equipment/index?sort=name&amp;max=10&amp;order=asc">Name</a></th>
                                        <th class="sortable"><a
                                                href="/equipment/index?sort=manufacturer&amp;max=10&amp;order=asc">Manufacturer</a>
                                        </th>
                                        <th class="sortable"><a
                                                href="/equipment/index?sort=serialNumber&amp;max=10&amp;order=asc">Serial Number</a>
                                        </th>
                                        <th class="sortable"><a
                                                href="/equipment/index?sort=status&amp;max=10&amp;order=asc">Status</a>
                                        </th>
                                        <th class="sortable"><a
                                                href="/equipment/index?sort=type&amp;max=10&amp;order=asc">Type</a></th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <g:each in="${equipmentList}" var="equipment">
                                        <tr>
                                            <td>${equipment.name}</td>
                                            <td>${equipment.manufacturer}</td>
                                            <td>${equipment.serialNumber}</td>
                                            <td>${equipment.status}</td>
                                            <td>${equipment.type}</td>
                                        </tr>
                                    </g:each>
                                    </tbody>
                                </table>
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