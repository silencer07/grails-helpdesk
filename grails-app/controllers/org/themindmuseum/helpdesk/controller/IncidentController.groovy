package org.themindmuseum.helpdesk.controller

import com.themindmuseum.helpdesk.TicketStatus
import grails.plugin.springsecurity.annotation.Secured
import org.themindmuseum.helpdesk.domain.Incident

class IncidentController {

    def springSecurityService

    def index() {}

    @Secured(["hasAnyRole('IT', 'EMPLOYEE')"])
    def myOpenIncidents(){
        def employee = springSecurityService.currentUser
        def incidents = Incident
            .findAllByReportedByAndStatusInList(employee, TicketStatus.unresolvedStatuses)
            .sort {a,b -> b.timeFiled <=> a.timeFiled}
        render view : 'incidents', model: [incidents : incidents]
    }

    @Secured(["hasAnyRole('IT', 'EMPLOYEE')"])
    def myClosedIncidents(){
        def employee = springSecurityService.currentUser
        def incidents = Incident
            .findAllByReportedByAndStatus(employee, TicketStatus.RESOLVED)
            .sort {a,b -> b.timeFiled <=> a.timeFiled}
        render view : 'incidents', model: [incidents : incidents]
    }
}
