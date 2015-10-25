package org.themindmuseum.helpdesk.controller

import org.themindmuseum.helpdesk.TicketStatus
import grails.plugin.springsecurity.annotation.Secured
import org.themindmuseum.helpdesk.domain.Incident
import sun.security.krb5.internal.Ticket

class IncidentController {

    def springSecurityService

    static allowedMethods = [addAdditionalNotes: 'POST', resolveIncident: 'POST', reopenIncident: 'POST']

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
        def incident = getEmployeeIncident(params.incidentId?.toLong())
        if(incident){
            if(params.additionalNotes){
                def employee = springSecurityService.loadCurrentUser()
                incident.resolutionNotes +=
                """${employee.firstName} ${employee.lastName} : \n
                   | ${params.additionalNotes} \n
                   |""".stripMargin().stripIndent()
                println incident.resolutionNotes
                incident.save()
            }
            redirect(action: 'details', id: incident.id)
        } else {
            redirect action : 'myOpenIncidents'
        }
    }

    @Secured(["hasAnyRole('IT', 'EMPLOYEE')"])
    def resolveIncident(){
        changeIncidentStatus(params.incidentId?.toLong(), TicketStatus.RESOLVED)
    }

    @Secured(["hasAnyRole('IT', 'EMPLOYEE')"])
    def reopenIncident(){
        changeIncidentStatus(params.incidentId?.toLong(), TicketStatus.OPEN)
    }

    private def changeIncidentStatus(long id, TicketStatus status){
        def incident = getEmployeeIncident(id)
        if(incident){
            incident.status = status
            incident.save()
            redirect(action: 'details', id: incident.id)
            return
        }

        if(status == TicketStatus.OPEN){
            redirect action : 'myOpenIncidents'
        } else {
            redirect action : 'myClosedIncidentsIncidents'
        }
    }

    private def getEmployeeIncident(long id) {
        def employee = springSecurityService.currentUser
        return Incident.findByIdAndReportedBy(id, employee)
    }
}
