<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.themindmuseum.helpdesk.utils.DateUtils" %>
<%@ page import="org.themindmuseum.helpdesk.TicketStatus" %>
<%@ page import="org.springframework.validation.FieldError" %>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Asset Borrowing Details</title>
    <script>
        $(document).ready(function(){
            $("[id*='dateTagged']").each(function( index ) {
                applyDateTimePickerStyle($(this).prop('id'));
            });
        });
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

            <table>
                <thead>
                <th>Equipment</th>
                <th>Serial Number</th>
                <th>Tag as</th> <!-- AVAILABLE, MISSING, WITH_DAMAGE -->
                <th>Date Tagged</th>
                </thead>
                <tbody>
                <g:set var="tags" value="${[AVAILABLE : 'Returned', MISSING :'Missing', WITH_DAMAGE : 'With Damage']}"/>
                <g:each in="${assetBorrowing?.equipments}" var="equipment" status="i">
                    <tr id="added-equipment-${i}">
                        <td>${equipment?.name}</td>
                        <td>${equipment?.serialNumber}
                            <g:hiddenField name="equipments[${i}].serialNumber" value="${equipment?.serialNumber}"/></td>
                        <td><g:select name="equipments[${i}].status" from="${tags.entrySet()}"
                                  optionKey="key" optionValue="value" /></td>
                        <td><g:textField name="equipments[${i}].dateTagged" id="equipments-${i}-dateTagged"/></td>
                    </tr>
                </g:each>
                </tbody>
            </table>

            Description : <br/>
                <textArea readonly="true">${assetBorrowing?.description}</textArea><br/>
            notes: <br/>
                <textArea readonly="true">${assetBorrowing?.resolutionNotes}</textArea> <br/>

            Add additional notes: <br/>
            <g:textArea name="additionalNotes"/><br/>
            <g:actionSubmit value="Save Changes" action="saveAssetBorrowingChanges"/>
            <g:actionSubmit value="Reopen Borrowing Request" action="reopenAssetBorrowing"/>
            <g:actionSubmit value="Complete returning process" action="markAssetReturned"/>
        </g:form>
    </div>
</div>
</body>
</html>