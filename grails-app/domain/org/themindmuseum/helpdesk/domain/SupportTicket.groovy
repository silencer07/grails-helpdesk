package org.themindmuseum.helpdesk.domain

import com.themindmuseum.helpdesk.TicketStatus

import java.time.LocalDateTime

abstract class SupportTicket {

    LocalDateTime timeFiled
    String subject
    String description
    TicketStatus status
    LocalDateTime timeReopened
    LocalDateTime timeClosed
    String resolutionNotes

    static constraints = {
        timeFiled nullabe:false
        subject size:1..200
        description size:1..1000
        status nullable:false
        reportedBy nullable:false
        resolutionNotes maxSize: 4 * 1024 * 1024 //4GB of data here
    }

    static belongsTo = [reportedBy: Employee, assignee: Employee]

    static mapping = {
        tablePerConcreteClass true
        resolutionNotes lazy: true //needs to be lazy-loaded since it is a huge file
    }
}
