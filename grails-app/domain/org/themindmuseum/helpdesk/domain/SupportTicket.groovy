package org.themindmuseum.helpdesk.domain

import org.themindmuseum.helpdesk.TicketStatus

import java.time.LocalDateTime

abstract class SupportTicket {

    LocalDateTime timeFiled = LocalDateTime.now()
    String subject = ''
    String description = ''
    TicketStatus status = TicketStatus.OPEN
    LocalDateTime timeReopened
    LocalDateTime timeResolved
    String resolutionNotes =''

    static constraints = {
        timeFiled nullabe:false
        subject nullable: false, size:1..200
        description nullable: true, maxSize:1000
        status nullable:false
        reportedBy nullable:false
        resolutionNotes nullable: true, maxSize: 4 * 1024 * 1024 //4GB of data here
        timeReopened nullable: true
        timeResolved nullable: true
        assignee nullable: true
    }

    static belongsTo = [reportedBy: Employee, assignee: Employee]

    static mapping = {
        tablePerConcreteClass true
        resolutionNotes lazy: true //needs to be lazy-loaded since it is a huge file
    }
}
