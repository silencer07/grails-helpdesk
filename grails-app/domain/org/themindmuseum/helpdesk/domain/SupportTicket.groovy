package org.themindmuseum.helpdesk.domain

import org.themindmuseum.helpdesk.TicketStatus

import java.time.LocalDateTime

abstract class SupportTicket {

    LocalDateTime timeFiled = LocalDateTime.now()
    String subject
    String description
    TicketStatus status = TicketStatus.OPEN
    LocalDateTime timeReopened
    LocalDateTime timeResolved
    String resolutionNotes

    static constraints = {
        timeFiled nullabe:false
        subject size:1..200
        description nullable: true, maxSize:1000
        status nullable:false, validator: mustHaveAnAssigneeWhenResolved
        reportedBy nullable:false
        resolutionNotes nullable: true, maxSize: 4 * 1024 * 1024 //4GB of data here
        timeReopened nullable: true
        timeResolved nullable: true
        assignee nullable: true, validator: mustHaveAnAssigneeWhenResolved
    }

    static belongsTo = [reportedBy: Employee, assignee: Employee]

    static mapping = {
        tablePerConcreteClass true
        resolutionNotes lazy: true //needs to be lazy-loaded since it is a huge file
    }

    static def mustHaveAnAssigneeWhenResolved = { status, instance ->
        if(status == TicketStatus.RESOLVED && !instance.assignee){
            return 'must.have.assignee.when.resolved'
        }
        return true
    }
}
