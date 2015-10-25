package org.themindmuseum.helpdesk.controller

import org.themindmuseum.helpdesk.TicketStatus
import grails.plugin.springsecurity.annotation.Secured
import org.themindmuseum.helpdesk.domain.Incident

class IncidentController {

    def springSecurityService

    static allowedMethods = [addAdditionalNotes: 'POST', closeIncident: 'POST', reopenIncident: 'POST']

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

    @Secured(["hasAnyRole('IT', 'EMPLOYEE')"])
    def details(long id){
        def incident = getEmployeeIncident(id)
        if(incident){
            return [incident : Incident.get(id)]
        } else {
            redirect action : 'myOpenIncidents'
        }
    }

    @Secured(["hasAnyRole('IT', 'EMPLOYEE')"])
    def addAdditionalNotes(){
        def incident = getEmployeeIncident(params.incidentId)
    }

    @Secured(["hasAnyRole('IT', 'EMPLOYEE')"])
    def closeIncident(){

    }

    @Secured(["hasAnyRole('IT', 'EMPLOYEE')"])
    def reopenIncident(){

    }

    private def getEmployeeIncident(long id) {
        def employee = springSecurityService.currentUser
        return Incident.findByIdAndReportedBy(id, employee)
    }
}
