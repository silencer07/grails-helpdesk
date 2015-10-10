package org.themindmuseum.helpdesk.domain

import com.themindmuseum.helpdesk.TicketStatus

import java.time.LocalDateTime

abstract class SupportTicket {

    Employee reportedBy
    LocalDateTime timeFiled
    String description
    TicketStatus status
    LocalDateTime timeReopened
    LocalDateTime timeClosed
    String resolutionNotes
    Employee assignee

    static constraints = {
        timeFiled nullabe:false
        description size:1..1000
        status nullable:false
        reportedBy nullable:false
    }

    static belongsTo = [reportedBy: Employee, assignee: Employee]

    static mapping = {
        tablePerConcreteClass true
    }
}
