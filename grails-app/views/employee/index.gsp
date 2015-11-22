<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>User Account List</title>
</head>

<body>
<div id="wrapper">
    <div id="page-wrapper">
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">Create User Account</h1>
            </div>
            <!-- /.col-lg-12 -->
        </div>

        <div id="list-employee" class="content scaffold-list" role="main">
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>
            <table>
                <thead>
                <tr>
                    <th class="sortable"><a href="/employee/index?sort=email&amp;max=10&amp;order=asc">Email</a></th>
                    <th class="sortable"><a href="/employee/index?sort=firstName&amp;max=10&amp;order=asc">Name</a></th>
                    <th class="sortable"><a href="/employee/index?sort=employeeRoles&amp;max=10&amp;order=asc">Employee Roles</a></th>
                    <th class="sortable"><a href="/employee/index?sort=department&amp;max=10&amp;order=asc">Department</a></th>
                </tr>
                </thead>
                <tbody>
                    <g:each in="${employeeList}" var="employee">
                        <tr>
                            <td><g:link action="edit" id="${employee.id}">${employee.email}</g:link></td>
                            <td>${employee.fullName}</td>
                            <td>${employee.employeeRoles[0].role.authority}</td>
                            <td>${employee.department.name}</td>
                        </tr>
                    </g:each>
                </tbody>
            </table>

            <div class="pagination">
                <g:paginate total="${employeeCount ?: 0}"/>
            </div>
        </div>
    </div>
</div>
</body>
</html>