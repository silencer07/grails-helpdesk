<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.themindmuseum.helpdesk.utils.DateUtils" %>
<%@ page import="org.themindmuseum.helpdesk.TicketStatus" %>
<%@ page import="org.springframework.validation.FieldError" %>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Asset Borrowing Details</title>
    <script>
        function addEquipment(){
            var additionalEquipmentDiv = $('#additional-equipment-div div:last');
            var $divClone = additionalEquipmentDiv.clone();

            var $textBox = $divClone.children('input:text');
            $textBox.prop('value', '');
            var textName = $textBox.prop('name');
            var index = textName.substring(textName.indexOf('[') + 1, textName.indexOf(']'));
            textName = textName.replace(index, (parseInt(index) + 1).toString());
            $textBox.prop('name', textName);
            additionalEquipmentDiv.after($divClone);
        }

        function removeEquipment(tableRowId){
            $("#" + tableRowId).remove();
        }
    </script>
</head>
<body>
<h1>Asset Borrowing Details</h1>
<div>
    <div>
        <g:hasErrors bean="${assetBorrowing}">
            <ul class="errors" role="alert">
            <g:each in="${assetBorrowing.equipments}" var="equipment">
                <g:eachError bean="${equipment}" var="error">
                    <li <g:if test="${error in FieldError}">data-field-id="${error.field}"</g:if>>
                        <g:message error="${error}"/>
                    </li>
                </g:eachError>
            </g:each>
            </ul>
        </g:hasErrors>
    </div>
    <div>
        <g:form method="post">
            <g:hiddenField name="assetBorrowingId" value="${assetBorrowing.id}"/>
            Subject : ${assetBorrowing?.subject} <br/>
            Time Filed : <g:formatDate date="${DateUtils.asDate(assetBorrowing?.timeFiled)}" format="MM/dd/yyyy hh:mm a"/> <br/>
            Borrow Time : <g:formatDate date="${DateUtils.asDate(assetBorrowing?.borrowedDate)}" format="MM/dd/yyyy hh:mm a"/> <br/>
            Returning Time : <g:formatDate date="${DateUtils.asDate(assetBorrowing?.returningDate)}" format="MM/dd/yyyy hh:mm a"/> <br/>
            Status : ${assetBorrowing.status} <br />
            Borrowing Request Fulfilled : <g:formatBoolean boolean="${assetBorrowing.assetLent}" true="Yes" false="No"/> <br/>
            Requested by : ${assetBorrowing.reportedBy}<br/>
            Assigned to : ${assetBorrowing.assignee} <br/>
            <g:if test="${assetBorrowing?.assetLent}">
                Returned Time : <g:formatDate date="${assetBorrowing?.returnedDate ? DateUtils.asDate(assetBorrowing?.returnedDate) : null}"
                                      format="MM/dd/yyyy hh:mm a"/> <br/>
            </g:if>
            <g:set var="equipmentIndex" value="0"/>
            <g:if test="${assetBorrowing?.equipments}">
                <g:set var="equipmentIndex" value="${assetBorrowing?.equipments.size()}"/>
                <table>
                    <thead>
                    <th>Equipment</th>
                    <th>Serial Number</th>
                    <g:if test="${assetBorrowing?.status == TicketStatus.OPEN}">
                        <th></th>
                    </g:if>
                    </thead>
                    <tbody>
                    <g:each in="${assetBorrowing?.equipments}" var="equipment" status="i">
                        <tr id="added-equipment-${i}">
                            <td>${equipment?.name}</td>
                            <g:if test="${assetBorrowing?.status == TicketStatus.OPEN}">
                                <td><g:textField name="equipments[${i}].serialNumber" value="${equipment?.serialNumber}" readonly="readonly"/></td>
                                <td><input type="button" value="Remove Equipment" onclick="removeEquipment(('added-equipment-${i}'))"/></td>
                            </g:if>
                            <g:else>
                                <td>${equipment?.serialNumber}
                                    <g:hiddenField name="equipments[${i}].serialNumber" value="${equipment?.serialNumber}"/></td>
                            </g:else>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </g:if>
            <g:if test="${assetBorrowing?.status == TicketStatus.OPEN}">
                <div id="additional-equipment-div">
                    <div>
                        Serial Number: <g:textField name="equipments[${equipmentIndex}].serialNumber"/>
                    </div>
                    <input type="button" id="add-equipment" value="Add Equipment" onclick="addEquipment()"/>
                </div>
            </g:if>
            Description : <br/>
                <textArea readonly="true">${assetBorrowing?.description}</textArea><br/>
            notes: <br/>
                <textArea readonly="true">${assetBorrowing?.resolutionNotes}</textArea>

            <g:hiddenField name="assetBorrowingId" value="${assetBorrowing?.id}"/><br/>
            <g:if test="${assetBorrowing?.status == TicketStatus.OPEN}">
                Add additional notes: <br/>
                <g:textArea name="additionalNotes"/><br/>
                <g:actionSubmit value="Save Changes" action="saveAssetBorrowingChanges"/>
                <g:actionSubmit value="Resolve Borrowing Request" action="resolveAssetBorrowing"/>
            </g:if>
            <g:else>
                <g:actionSubmit value="Reopen Borrowing Request" action="reopenAssetBorrowing"/>
            </g:else>
            <g:if test="${assetBorrowing?.equipments}">
                <g:actionSubmit value="Mark/Unmark Borrow Request as Fulfilled" action="markAssetLent"/>
            </g:if>
        </g:form>
    </div>
</div>
</body>
</html>