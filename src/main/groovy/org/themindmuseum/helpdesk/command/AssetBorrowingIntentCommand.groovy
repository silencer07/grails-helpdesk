package org.themindmuseum.helpdesk.command

import grails.validation.Validateable
import org.themindmuseum.helpdesk.domain.SupportTicket
import org.themindmuseum.helpdesk.utils.DateUtils

import java.time.LocalDateTime

class AssetBorrowingIntentCommand implements Validateable{

    String subject
    LocalDateTime borrowedDate
    LocalDateTime returningDate
    String description

    static constraints = {
        subject nullable: false, size:1..200
        description nullable: true, maxSize:1000
        borrowedDate nullable: false, validator : SupportTicket.mustBeGreaterThanOrEqualToday
        returningDate nullable: false, validator: mustBeLaterThanBorrowedDate
    }

    static def mustBeLaterThanBorrowedDate = { date, instance ->
        if(instance.borrowedDate && date){
            if(date.compareTo(instance.borrowedDate) < 0){
                return 'must.be.greater.than.borrowed.date'
            }
        }
        return true
    }

    def getBorrowedDateAsFormattedString(){
        return DateUtils.formatJQueryDateTimeInput(borrowedDate)
    }

    def getReturningDateAsFormattedString(){
        return DateUtils.formatJQueryDateTimeInput(returningDate)
    }
}
