package org.themindmuseum.helpdesk.domain

class Incident extends SupportTicket{

    static constraints = {
        //TODO, when closed, should have an assignee
        equipment nullable: false
    }

    static belongsTo = [equipment : Equipment]
}
