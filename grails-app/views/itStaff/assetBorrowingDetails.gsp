<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.themindmuseum.helpdesk.utils.DateUtils" %>
<%@ page import="org.themindmuseum.helpdesk.TicketStatus" %>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Asset Borrowing Details</title>
    <script>
        function addEquipment(){

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
        Subject : ${assetBorrowing?.subject} <br/>
        Time Filed : <g:formatDate date="${DateUtils.asDate(assetBorrowing?.timeFiled)}" format="MM/dd/yyyy hh:mm a"/> <br/>
        Borrow Time : <g:formatDate date="${DateUtils.asDate(assetBorrowing?.borrowedDate)}" format="MM/dd/yyyy hh:mm a"/> <br/>
        Returning Time : <g:formatDate date="${DateUtils.asDate(assetBorrowing?.returningDate)}" format="MM/dd/yyyy hh:mm a"/> <br/>
        Status : ${assetBorrowing.status} <br />
        Borrowing Request Fulfilled : <g:formatBoolean boolean="${assetBorrowing.assetLent}" true="Yes" false="No"/> <br/>
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
                        <td>${equipment.name}</td>
                        <g:if test="${assetBorrowing?.status == TicketStatus.OPEN}">
                            <td><g:textField name="equipments[${i}].serialNumber" value="${equipment.serialNumber}" readonly="readonly"/></td>
                            <td><input type="button" value="Remove Equipment" onclick="removeEquipment(('added-equipment-${i}'))"/></td>
                        </g:if>
                        <g:else>
                            <td>${equipment.serialNumber}</td>
                        </g:else>
                    </tr>
                </g:each>
                </tbody>
            </table>
        </g:if>
        <g:if test="${assetBorrowing?.status == TicketStatus.OPEN}">
            <div id="additional-equipment-div">
                <div>Serial Number: <g:textField name="equipments[${equipmentIndex}].serialNumber"/></div>
                <input type="button" id="add-equipment" value="Add Equipment" onclick="addEquipment()"/>
            </div>
        </g:if>
        Description : <br/>
            <textArea readonly="true">${assetBorrowing?.description}</textArea><br/>
        notes: <br/>
            <textArea readonly="true">${assetBorrowing?.resolutionNotes}</textArea>

        <g:form method="post">
            <g:hiddenField name="assetBorrowingId" value="${assetBorrowing?.id}"/>
            <g:if test="${assetBorrowing?.status == TicketStatus.OPEN}">
                Add additional notes: <br/>
                <g:textArea name="additionalNotes"/><br/>
                <g:actionSubmit value="Add Notes" action="addAdditionalNotes"/>
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