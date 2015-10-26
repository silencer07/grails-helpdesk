package org.themindmuseum.helpdesk.controller

import grails.plugin.springsecurity.annotation.Secured
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
            redirect action : 'myOpenBorrowRequests'
            return
        }
        render view : 'index', model: [assetBorrowingIntent : assetBorrowingIntent]
    }

    @Secured(["hasAnyRole('IT', 'EMPLOYEE')"])
    def myOpenBorrowRequests(){

    }
}
