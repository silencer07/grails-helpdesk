package org.themindmuseum.helpdesk.domain

class Incident extends SupportTicket{

    static constraints = {
        equipment nullable: false
    }

    static belongsTo = [equipment : Equipment]
}
