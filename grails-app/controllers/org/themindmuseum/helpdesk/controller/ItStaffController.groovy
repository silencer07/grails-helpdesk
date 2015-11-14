package org.themindmuseum.helpdesk.controller

import grails.plugin.springsecurity.annotation.Secured
import org.apache.commons.lang.ClassUtils
import org.themindmuseum.helpdesk.TicketStatus
import org.themindmuseum.helpdesk.domain.AssetBorrowing
import org.themindmuseum.helpdesk.domain.Employee
import org.themindmuseum.helpdesk.domain.EventSupport
import org.themindmuseum.helpdesk.domain.Incident
import org.themindmuseum.helpdesk.domain.Role

class ItStaffController {

    def springSecurityService

    @Secured(["hasAnyRole('IT')"])
    def index() {
        def itStaff = springSecurityService.currentUser
        def modelMap = [:]

        modelMap.unassignedIncidents = Incident.
            findAllByReportedByNotEqualAndAssigneeIsNullAndStatusInList(
                itStaff, TicketStatus.unresolvedStatuses, [sort : 'timeFiled'])
        modelMap.assignedIncidents = Incident.findAllByAssigneeAndStatusInList(
                itStaff, TicketStatus.unresolvedStatuses, [sort : 'timeFiled'])
        modelMap.pendingBorrowRequests = AssetBorrowing.
            findAllByReportedByNotEqualAndAssigneeIsNullAndStatusInList(
                itStaff, TicketStatus.unresolvedStatuses, [sort : 'timeFiled'])
        modelMap.approvedBorrowRequests = AssetBorrowing.findAllByAssigneeAndAssetReturned(
                itStaff, false, [sort : 'returningDate'])
        modelMap.upcomingEventsToSupports = EventSupport.withCriteria {
            or {
                eq('assignee', itStaff)
                supportStaff {
                    eq("id", itStaff.id) //if user is one of the support staff
                }
            }
            order('startTime', 'desc')
        }
        modelMap.openEventSupports = EventSupport.
                findAllByReportedByNotEqualAndAssigneeIsNullAndStatusInList(
                        itStaff, TicketStatus.unresolvedStatuses, [sort : 'timeFiled'])
        return modelMap
    }

    @Secured(["hasAnyRole('IT')"])
    def incidentDetails(long id) {
        def incident = Incident.findByIdAndReportedByNotEqual(id, springSecurityService.currentUser)
        if(incident){
            def itStaff = Employee.withCriteria {
                employeeRoles {
                    role {
                        eq('authority', 'IT')
                    }
                }
                ne('id', springSecurityService.currentUser.id)
            }
            return [incident : incident, itStaff : itStaff]
        } else {
            redirect action:'index'
        }
    }

    @Secured(["hasAnyRole('EMPLOYEE')"])
    def addAdditionalNotes(){
        def supportTicket = getSupportTicket(params.id.toLong(), ClassUtils.getClass(params.clazz))
        if(supportTicket){
            if(params.additionalNotes){
                def employee = springSecurityService.loadCurrentUser()
                supportTicket.resolutionNotes =
                        """${employee.fullName} : \n
                   | ${params.additionalNotes} \n
                   |""".stripMargin().stripIndent() +
                    supportTicket.resolutionNotes
                supportTicket.assignee = Employee.findByEmail(params.assignee)
                supportTicket.save()
            }
            redirect(action: params.successAction, id: supportTicket.id)
        } else {
            redirect action : params.failAction
        }
    }

    private def getSupportTicket(long id, Class clazz) {
        def employee = springSecurityService.currentUser
        return clazz.findByIdAndReportedByNotEqual(id, employee)
    }
    //save changes
    //resolve incident
}
