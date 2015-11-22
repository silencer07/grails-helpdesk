package org.themindmuseum.helpdesk.controller

import grails.plugin.springsecurity.annotation.Secured
import org.themindmuseum.helpdesk.TicketStatus
import org.themindmuseum.helpdesk.domain.AssetBorrowing
import org.themindmuseum.helpdesk.domain.EventSupport
import org.themindmuseum.helpdesk.domain.Incident


class NormalEmployeeController {

    def springSecurityService

    @Secured(["hasAnyRole('IT', 'EMPLOYEE')"])
    def index() {
        def employee = springSecurityService.currentUser
        def model = [:]
        model.openIncidents = Incident.findAllByStatusInListAndReportedBy(
            TicketStatus.unresolvedStatuses, employee, [sort : 'timeFiled'])
        model.pendingBorrowRequest = AssetBorrowing.withCriteria {
            eq('reportedBy', employee)
            or {
                'in'('status', TicketStatus.unresolvedStatuses)
                eq('assetLent', false)
            }
            order 'timeFiled', 'asc'
        }
        model.approvedBorrowRequest = AssetBorrowing.findAllByStatusAndAssetReturnedAndReportedBy(
            TicketStatus.RESOLVED, false, employee, [sort: 'returningDate'])
        model.pendingEventSupport = EventSupport.withCriteria {
            eq('reportedBy', employee)
            or {
                'in'('status', TicketStatus.unresolvedStatuses)
                eq('resourceIssued', false)
            }
            order 'timeFiled', 'asc'
        }
        model.pastEventSupport = EventSupport.findAllByStatusAndResourceIssuedAndReportedBy(
            TicketStatus.RESOLVED, true, employee, [sort: 'endTime'])
        return model
    }
}
