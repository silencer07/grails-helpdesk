package org.themindmuseum.helpdesk.controller

import grails.plugin.springsecurity.annotation.Secured
import org.themindmuseum.helpdesk.TicketStatus
import org.themindmuseum.helpdesk.command.AssetBorrowingIntentCommand
import org.themindmuseum.helpdesk.domain.AssetBorrowing
import org.themindmuseum.helpdesk.utils.DateUtils

class BorrowController {

    static allowedMethods = [saveAssetBorrowingIntent: 'POST']

    def springSecurityService

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

    /**
     * TODO:
     * additional notes functionality
     * resolve borrowing
     * mark/unmark as fulfilled
     * dividing myAssetBorrowing between present/future and past borrowings
     * marking intents/assetBorrowings as red if they are about to lapse
     * abstract SupportTicketController that handles common scenarios like:
     *  reopening
     *  closing
     *  adding additional notes
     */
}
