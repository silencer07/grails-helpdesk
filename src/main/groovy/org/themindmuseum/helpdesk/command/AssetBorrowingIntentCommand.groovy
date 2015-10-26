package org.themindmuseum.helpdesk.command

import grails.validation.Validateable

import java.time.LocalDateTime

class AssetBorrowingIntentCommand implements Validateable{

    String subject
    LocalDateTime borrowDate
    LocalDateTime returningDate
    String description

    static constraints = {
        subject nullable: false, size:1..200
        description nullable: true, maxSize:1000
        borrowDate nullable: false
        returningDate nullable: false, validator: mustBeLaterThanBorrowedDate
    }

    static def mustBeLaterThanBorrowedDate = { date, instance ->
        if(instance.borrowedDate && date){
            if(returningDate.compareTo(instance.borrowedDate) < 0){
                return 'must.be.greater.than.borrowed.date'
            }
        }
        return true
    }
}
