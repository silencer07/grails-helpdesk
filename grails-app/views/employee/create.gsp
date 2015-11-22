<%@ page import="org.themindmuseum.helpdesk.domain.Department" %>
<%@ page import="org.themindmuseum.helpdesk.domain.Role" %>
<%@ page import="org.themindmuseum.helpdesk.Priority" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <title>Create User Account</title>
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
            <div id="create-employee" class="content scaffold-create" role="main">
                <g:if test="${flash.message}">
                    <div class="message" role="status">${flash.message}</div>
                </g:if>
                <g:hasErrors bean="${this.employee}">
                    <ul class="errors" role="alert">
                        <g:eachError bean="${this.employee}" var="error">
                        <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                        </g:eachError>
                    </ul>
                </g:hasErrors>
                <g:form action="save">
                    <fieldset class="form">
                        <div class="fieldcontain required">
                            <label for="firstName">First Name
                                <span class="required-indicator">*</span>
                            </label><input type="text" name="firstName" value="${employee?.firstName}" required="" maxlength="100"
                                           id="firstName">
                        </div>

                        <div class="fieldcontain required">
                            <label for="lastName">Last Name
                                <span class="required-indicator">*</span>
                            </label><input type="text" name="lastName" value="${employee?.lastName}" required="" maxlength="100"
                                           id="lastName">
                        </div>

                        <div class="fieldcontain required">
                            <label for="email">Email
                                <span class="required-indicator">*</span>
                            </label><input type="text" name="email" value="${employee?.email}" required="" maxlength="100"
                                           id="email">
                        </div>

                        <div class="fieldcontain required">
                            <label for="password">Password
                                <span class="required-indicator">*</span>
                            </label>
                            <g:passwordField name="password" required="true" maxlength="100"/>
                            <span>Leave it blank so password won't change</span>
                        </div>

                        <div class="fieldcontain required">
                            <label for="department">Department
                                <span class="required-indicator">*</span>
                            </label>
                            <g:select name="department" from="${Department.list()}" optionKey="id" optionValue="name"
                                      value="${employee?.department?.id}"/>
                        </div>

                        <div class="fieldcontain required">
                            <label for="priority">Priority
                                <span class="required-indicator">*</span>
                            </label>
                            <g:select name="priority" required="required" from="${Priority.values()}"/>
                        </div>

                        <div class="fieldcontain required">
                            <label for="role">Role
                                <span class="required-indicator">*</span>
                            </label>
                            <g:select name="role" from="${Role.list()}" optionKey="id" optionValue="authority"
                                      value="${employee?.employeeRoles?.getAt(0)?.role?.id}"/>
                        </div>

                        <div class="fieldcontain">
                            <label for="enabled">Enabled</label>
                            <g:checkBox name="enabled" value="${employee?.enabled}"/>
                        </div>
                    </fieldset>
                    <fieldset class="buttons">
                        <g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" />
                    </fieldset>
                </g:form>
            </div>
        </div>
    </div>
    </body>
</html>
