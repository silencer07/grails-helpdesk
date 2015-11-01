<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.themindmuseum.helpdesk.utils.DateUtils" %>
<%@ page import="org.themindmuseum.helpdesk.TicketStatus" %>
<html>
<head>
    <title>My Asset Borrowing Details</title>
</head>
<body>
<h1>My Asset Borrowing Details</h1>
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
            <g:if test="${assetBorrowing?.equipments}">
                <table>
                    <thead>
                    <th>Equipment</th>
                    <th>Serial Number</th>
                    </thead>
                    <tbody>
                    <g:each in="${assetBorrowing?.equipments}" var="equipment">
                        <tr>
                            <td>${equipment.name}</td>
                            <td>${equipment.serialNumber}</td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </g:if>
            <g:if test="${assetBorrowing?.supportStaff}">
                <table>
                    <thead>
                    <th>Name</th>
                    <th>Email</th>
                    </thead>
                    <tbody>
                    <g:each in="${assetBorrowing?.supportStaff}" var="staff">
                        <tr>
                            <td>${staff.fullName}</td>
                            <td>${staff.email}</td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </g:if>
        </g:if>
        Description : <br/>
            <textArea readonly="true">${assetBorrowing?.description}</textArea>
        notes:
            <textArea readonly="true">${assetBorrowing?.resolutionNotes}</textArea>

        <g:form method="post">
            <g:hiddenField name="assetBorrowingId" value="${assetBorrowing?.id}"/>
            <g:if test="${assetBorrowing?.status == TicketStatus.OPEN}">
                Add additional notes: <br/>
                <g:textArea name="additionalNotes"/>
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