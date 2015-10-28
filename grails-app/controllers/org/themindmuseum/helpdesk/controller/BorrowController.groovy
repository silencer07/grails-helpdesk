package org.themindmuseum.helpdesk.controller

import grails.plugin.springsecurity.annotation.Secured
import org.themindmuseum.helpdesk.TicketStatus
import org.themindmuseum.helpdesk.command.AssetBorrowingIntentCommand
import org.themindmuseum.helpdesk.domain.AssetBorrowing
import org.themindmuseum.helpdesk.utils.DateUtils

class BorrowController extends SupportTicketController{

    static allowedMethods = [saveAssetBorrowingIntent: 'POST', additionalNotes : 'POST',
         resolveAssetBorrowing: 'POST', reopenAssetBorrowing: 'POST', markAssetLent: 'POST']

    @Secured(["hasAnyRole('IT', 'EMPLOYEE')"])
    def index() {}

    @Secured(["hasAnyRole('IT', 'EMPLOYEE')"])
    def saveAssetBorrowingIntent(){
        def assetBorrowingIntent = new AssetBorrowingIntentCommand()
        bindData(assetBorrowingIntent, params, [exclude: ['returningDate', 'borrowedDate']])
        assetBorrowingIntent.returningDate = DateUtils.tryParseLocalDateTimeFromDateTimePicker(params.returningDate)
        assetBorrowingIntent.borrowedDate = DateUtils.tryParseLocalDateTimeFromDateTimePicker(params.borrowedDate)

        if(assetBorrowingIntent.validate()){
            def assetBorrowing = new AssetBorrowing(assetBorrowingIntent.properties)
            assetBorrowing.reportedBy = springSecurityService.currentUser
            assetBorrowing.save()
            redirect action : 'myAssetBorrowingIntents'
            return
        }
        render view : 'index', model: [assetBorrowingIntent : assetBorrowingIntent]
    }

    @Secured(["hasAnyRole('IT', 'EMPLOYEE')"])
    def myAssetBorrowingIntents(){
        def employee = springSecurityService.currentUser
        def intents = AssetBorrowing.findAllByReportedByAndStatusAndAssetLent(employee, TicketStatus.OPEN, false, [sortBy : 'timeFiled'])
        return [intents : intents]
    }

    @Secured(["hasAnyRole('IT', 'EMPLOYEE')"])
    def details(long id){
        def assetBorrowing = AssetBorrowing.findByIdAndReportedBy(id, springSecurityService.currentUser)
        if(assetBorrowing){
            return [assetBorrowing: assetBorrowing]
        } else {
            redirect action : 'myAssetBorrowing'
        }
    }

    @Secured(["hasAnyRole('IT', 'EMPLOYEE')"])
    def myAssetBorrowings(){
        def employee = springSecurityService.currentUser
        def assetBorrowings = AssetBorrowing.findAllByReportedByAndStatus(employee, TicketStatus.RESOLVED, [sortBy : 'returningDate'])
        return [assetBorrowings : assetBorrowings]
    }

    @Secured(["hasAnyRole('IT', 'EMPLOYEE')"])
    def addAdditionalNotes(){
        addAdditionalNotes(params.assetBorrowingId?.toLong(), AssetBorrowing, 'myAssetBorrowingIntents', 'details')
    }

    @Secured(["hasAnyRole('IT', 'EMPLOYEE')"])
    def resolveAssetBorrowing(){
        resolveSupportTicket(params.assetBorrowingId?.toLong(), AssetBorrowing,
                'myAssetBorrowingIntents', 'myAssetBorrowings')
    }

    @Secured(["hasAnyRole('IT', 'EMPLOYEE')"])
    def reopenAssetBorrowing(){
        reopenSupportTicket(params.assetBorrowingId?.toLong(), AssetBorrowing,
                'myAssetBorrowingIntents', 'myAssetBorrowings')
    }

    @Secured(["hasAnyRole('IT', 'EMPLOYEE')"])
    def markAssetLent(){
        def assetBorrowing = AssetBorrowing.findByIdAndReportedBy(
            params.assetBorrowingId?.toLong(), springSecurityService.currentUser)
        if(assetBorrowing){
            assetBorrowing.assetLent = !assetBorrowing.assetLent
            redirect(action: 'details', id: assetBorrowing.id)
            return
        }
        redirect(action: 'myAssetBorrowings')
    }

    /**
     * TODO:
     * dividing myAssetBorrowing between present/future and past borrowings
     * marking intents/assetBorrowings as red if they are about to lapse
     */
}
