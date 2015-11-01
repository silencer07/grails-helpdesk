package org.themindmuseum.helpdesk.command

import grails.validation.Validateable

import java.time.LocalDateTime

class EventSupportIntentCommand implements Validateable{
    String subject
    LocalDateTime startTime
    LocalDateTime endTime
    String venue
    String description

    static constraints = {
        subject nullable: false, size:1..200
        description nullable: false, maxSize:1000
        venue nullable:false, size:1..500
        startTime nullable: false
        endTime nullable: false, validator: mustBeLaterThanStartTime
    }

    static def mustBeLaterThanStartTime = { date, instance ->
        if(instance.startTime && date){
            if(date.compareTo(instance.startTime) < 0){
                return 'must.be.greater.than.start.time'
            }
        }
        return true
    }
}
