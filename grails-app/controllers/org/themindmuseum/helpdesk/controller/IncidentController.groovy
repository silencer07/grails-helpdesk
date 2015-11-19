package org.themindmuseum.helpdesk.controller

import org.themindmuseum.helpdesk.TicketStatus
import grails.plugin.springsecurity.annotation.Secured
import org.themindmuseum.helpdesk.command.IncidentFilingCommand
import org.themindmuseum.helpdesk.domain.Incident
import sun.security.krb5.internal.Ticket

class IncidentController extends SupportTicketController{

    static allowedMethods = [addAdditionalNotes: 'POST', resolveIncident: 'POST', reopenIncident: 'POST', 'saveIncident' : 'POST']

    @Secured(["hasAnyRole('IT', 'EMPLOYEE')"])
    def index() {}

    @Secured(["hasAnyRole('IT', 'EMPLOYEE')"])
    def saveIncident(IncidentFilingCommand cmd) {
        def model = [incident: cmd]
        if(cmd.validate()){
            def incident = new Incident(cmd.properties)
            incident.reportedBy = springSecurityService.currentUser
            incident.save()
            model.successMessage = "Incident filed Successfully"
        }

        render view:'index', model : model
    }

    @Secured(["hasAnyRole('IT', 'EMPLOYEE')"])
    def myOpenIncidents(){
        def employee = springSecurityService.currentUser
        def incidents = Incident
            .findAllByReportedByAndStatusInList(employee, TicketStatus.unresolvedStatuses)
            .sort {a,b -> b.timeFiled <=> a.timeFiled}
        render view : 'myIncidents', model: [incidents : incidents, title : 'My Open Incidents']
    }

    @Secured(["hasAnyRole('IT', 'EMPLOYEE')"])
    def myResolvedIncidents(){
        def employee = springSecurityService.currentUser
        def incidents = Incident
            .findAllByReportedByAndStatus(employee, TicketStatus.RESOLVED)
            .sort {a,b -> b.timeFiled <=> a.timeFiled}
        render view : 'myIncidents', model: [incidents : incidents, title : 'My Resolved Incidents']
    }

    @Secured(["hasAnyRole('IT', 'EMPLOYEE')"])
    def details(long id){
        def incident = getSupportTicket(id, Incident)
        if(incident){
            return [incident : incident]
        } else {
            redirect action : 'myOpenIncidents'
        }
    }

    @Secured(["hasAnyRole('IT', 'EMPLOYEE')"])
    def addAdditionalNotes(){
        addAdditionalNotes(params.incidentId?.toLong(), Incident, 'myOpenIncidents', 'details')
    }

    @Secured(["hasAnyRole('IT', 'EMPLOYEE')"])
    def resolveIncident(){
        resolveSupportTicket(params.incidentId?.toLong(), Incident,
                'myOpenIncidents', 'myResolvedIncidents')
    }

    @Secured(["hasAnyRole('IT', 'EMPLOYEE')"])
    def reopenIncident(){
        reopenSupportTicket(params.incidentId?.toLong(), Incident,
                'myOpenIncidents', 'myResolvedIncidents')
    }
}
