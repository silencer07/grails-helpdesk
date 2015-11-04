package org.themindmuseum.helpdesk.controller

import grails.plugin.springsecurity.annotation.Secured
import org.themindmuseum.helpdesk.TicketStatus
import org.themindmuseum.helpdesk.domain.AssetBorrowing
import org.themindmuseum.helpdesk.domain.EventSupport
import org.themindmuseum.helpdesk.domain.Incident

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
        //open event support requests
        return modelMap
    }
}
