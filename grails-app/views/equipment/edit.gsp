<%@ page import="org.themindmuseum.helpdesk.EquipmentType" %>
<%@ page import="org.themindmuseum.helpdesk.EquipmentStatus" %>
<%@ page import="org.themindmuseum.helpdesk.utils.DateUtils" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Equipment Details</title>
    <script>
        $(document).ready(function(){
            applyDateTimePickerStyle('datePurchased');
            applyDateTimePickerStyle('warrantyEndDate');
        });
    </script>
</head>

<body>
<div id="wrapper">
    <div id="page-wrapper">
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">Equipment Details</h1>
            </div>
            <!-- /.col-lg-12 -->
        </div>

        <div id="edit-equipment" class="content scaffold-edit" role="main">
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${this.equipment}">
                <ul class="errors" role="alert">
                    <g:eachError bean="${this.equipment}" var="error">
                        <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message
                                error="${error}"/></li>
                    </g:eachError>
                </ul>
            </g:hasErrors>
            <g:form resource="${this.equipment}" method="PUT">
                <g:hiddenField name="version" value="${this.equipment?.version}"/>
                <fieldset class="form">
                    <div class="fieldcontain required">
                        <label for="name">Name
                            <span class="required-indicator">*</span>
                        </label><g:textField name="name" value="${equipment?.name}" maxlength="50"/>
                    </div>

                    <div class="fieldcontain required">
                        <label for="manufacturer">Manufacturer
                            <span class="required-indicator">*</span>
                        </label><input type="text" name="manufacturer" value="${equipment.manufacturer}"
                           required="" maxlength="50" id="manufacturer">
                    </div>

                    <div class="fieldcontain required">
                        <label for="serviceTag">Service Tag
                            <span class="required-indicator">*</span>
                        </label><input type="text" name="serviceTag" value="${equipment?.serviceTag}" required="" maxlength="50"
                                       id="serviceTag">
                    </div>

                    <div class="fieldcontain required">
                        <label for="serialNumber">Serial Number
                            <span class="required-indicator">*</span>
                        </label>
                        <input type="text" name="serialNumber" value="${equipment?.serialNumber}" required="" maxlength="200"
                                       id="serialNumber" readonly="readonly">
                    </div>

                    <div class="fieldcontain">
                        <label for="details">Details</label>
                        <g:textArea name="details" value="${equipment?.details}"/>
                    </div>

                    <div class="fieldcontain required">
                        <label for="status">Status
                            <span class="required-indicator">*</span>
                        </label>
                        <g:select name="status" from="${EquipmentStatus.values()}" value="${equipment?.status}"/>
                    </div>

                    <div class="fieldcontain required">
                        <label for="type">Type
                            <span class="required-indicator">*</span>
                        </label>
                        <g:select name="type" from="${EquipmentType.values()}" value="${equipment?.type}"/>
                    </div>
                    <div class="fieldcontain required">
                        <label for="vendor">Vendor
                            <span class="required-indicator">*</span>
                        </label><select name="vendor.id" required="" id="vendor">
                        <option value="1" selected="selected">PC Express</option>
                    </select>
                    </div>
                    <div class="fieldcontain required">
                        <label for="datePurchased">Date Purchased
                            <span class="required-indicator">*</span>
                        </label>
                        <g:textField name="datePurchased" value="${DateUtils.formatJQueryDateInput(equipment?.datePurchased)}"/>
                    </div>

                    <div class="fieldcontain required">
                        <label for="warrantyEndDate">Warranty End Date
                            <span class="required-indicator">*</span>
                        </label>
                        <g:textField name="warrantyEndDate" value="${DateUtils.formatJQueryDateInput(equipment?.warrantyEndDate)}"/>
                    </div>

                    <div class="fieldcontain">
                        <label>Date Disposed</label>
                        <g:if test="${equipment.dateDisposed}">
                            <g:formatDate date="${DateUtils.asDate(equipment.dateDisposed)}" format="${DateUtils.DEFAULT_DATE_FORMAT}"/>
                        </g:if>
                    </div>

                    <div class="fieldcontain required">
                        <label>Date Tagged</label>
                        <g:formatDate date="${DateUtils.asDate(equipment.dateTagged)}" format="${DateUtils.DEFAULT_DATE_FORMAT}"/>
                    </div>
                    <div class="fieldcontain">
                        <label for="existingNotes">Notes</label>
                        <textArea id="existingNotes" readonly="true">${equipment?.notes}</textArea> <br/>
                        <label for="notes">Additional Notes</label>
                        <g:textArea name="notes"/>
                    </div>
                </fieldset>
                <fieldset class="buttons">
                    <input class="save" type="submit"
                           value="${message(code: 'default.button.update.label', default: 'Update')}"/>
                </fieldset>
            </g:form>
        </div>
    </div>
</div>
</body>
</html>
