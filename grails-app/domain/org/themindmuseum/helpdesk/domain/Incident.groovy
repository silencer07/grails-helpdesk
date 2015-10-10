package org.themindmuseum.helpdesk.domain

class Incident extends SupportTicket{

    Equipment equipment

    static constraints = {
        //TODO, when closed, should have an assignee
        equipment nullable: false
    }

    static belongsTo = [equipment : Equipment]
}
