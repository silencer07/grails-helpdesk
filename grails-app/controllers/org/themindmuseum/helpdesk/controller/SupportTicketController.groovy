package org.themindmuseum.helpdesk.controller

import grails.plugin.springsecurity.annotation.Secured
import org.themindmuseum.helpdesk.TicketStatus
import org.themindmuseum.helpdesk.domain.SupportTicket

abstract class SupportTicketController {

    static allowedMethods = [addAdditionalNotes: 'POST', resolveIncident: 'POST', reopenIncident: 'POST']

    def springSecurityService

    @Secured(["hasAnyRole('IT', 'EMPLOYEE')"])
    def addAdditionalNotes(long id, Class clazz, String failAction, String successAction){
        def supportTicket = getSupportTicket(id, clazz)
        if(supportTicket){
            if(params.additionalNotes){
                def employee = springSecurityService.loadCurrentUser()
                supportTicket.resolutionNotes +=
                        """${employee.firstName} ${employee.lastName} : \n
                   | ${params.additionalNotes} \n
                   |""".stripMargin().stripIndent()
                supportTicket.save()
            }
            redirect(action: successAction, id: supportTicket.id)
        } else {
            redirect action : failAction
        }
    }

    @Secured(["hasAnyRole('IT', 'EMPLOYEE')"])
    def resolveSupportTicket(long id, Class clazz, String openSupportTicketAction, String resolvedSupportTicketAction){
        changeSupportTicketStatus(id, clazz, TicketStatus.RESOLVED, openSupportTicketAction, resolvedSupportTicketAction)
    }

    @Secured(["hasAnyRole('IT', 'EMPLOYEE')"])
    def reopenSupportTicket(long id, Class clazz, String openSupportTicketAction, String resolvedSupportTicketAction){
        changeSupportTicketStatus(id, clazz, TicketStatus.OPEN, openSupportTicketAction, resolvedSupportTicketAction)
    }

    private def changeSupportTicketStatus(long id, Class clazz, TicketStatus status,
      String openSupportTicketAction, String resolvedSupportTicketAction){
        def supportTicket = getSupportTicket(id, clazz)
        if(supportTicket){
            supportTicket.status = status
            supportTicket.save()
            redirect(action: 'details', id: supportTicket.id)
            return
        }

        if(status == TicketStatus.OPEN){
            redirect action : openSupportTicketAction
        } else {
            redirect action : resolvedSupportTicketAction
        }
    }

    protected def getSupportTicket(long id, Class clazz) {
        def employee = springSecurityService.currentUser
        return clazz.findByIdAndReportedBy(id, employee)
    }
}
