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
            $("[id*='dateTaggedString']").each(function( index ) {
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
            Returned Time : <g:formatDate date="${assetBorrowing?.returnedDate ? DateUtils.asDate(assetBorrowing?.returnedDate) : null}"
              format="MM/dd/yyyy hh:mm a"/> <br/>
            Description : <br/>
            <textArea readonly="true">${assetBorrowing?.description}</textArea><br/>
            notes: <br/>
            <textArea readonly="true">${assetBorrowing?.resolutionNotes}</textArea> <br/>

            Add additional notes: <br/>
            <g:textArea name="additionalNotes"/><br/>
            <h3>Equipments :</h3>
            <g:set var="tags" value="${[AVAILABLE : 'Returned', MISSING :'Missing', WITH_DAMAGE : 'With Damage']}"/>
            <g:each in="${assetBorrowing?.equipments}" var="equipment" status="i">
                ${equipment?.name}(SN: ${equipment?.serialNumber})<g:select name="equipments[${i}].status" from="${tags.entrySet()}"
                    optionKey="key" optionValue="value" /> <g:textField name="equipments[${i}].dateTaggedString" id="equipments-${i}-dateTaggedString"/><br/>
                    <g:hiddenField name="equipments[${i}].serialNumber" value="${equipment?.serialNumber}"/>
                equipment history:<br/>
                <textArea readonly="true">${equipment?.notes}</textArea><br/>
                Add equipment history:<br/>
                <g:textArea name="equipments[${i}].notes"/>
                <br/>
            </g:each>
            <g:actionSubmit value="Save Changes" action="saveAssetReturningChanges"/>
            <g:actionSubmit value="Reopen Borrowing Request" action="reopenAssetBorrowing"/>
            <g:actionSubmit value="Complete returning process" action="markAssetReturned"/>
        </g:form>
    </div>
</div>
</body>
</html>