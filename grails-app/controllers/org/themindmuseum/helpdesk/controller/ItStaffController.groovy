package org.themindmuseum.helpdesk.controller

import grails.plugin.springsecurity.annotation.Secured
import org.apache.commons.lang.ClassUtils
import org.themindmuseum.helpdesk.EquipmentStatus
import org.themindmuseum.helpdesk.TicketStatus
import org.themindmuseum.helpdesk.command.AssetApprovalIntentCommand
import org.themindmuseum.helpdesk.domain.AssetBorrowing
import org.themindmuseum.helpdesk.domain.Employee
import org.themindmuseum.helpdesk.domain.EventSupport
import org.themindmuseum.helpdesk.domain.Incident
import org.themindmuseum.helpdesk.domain.Role

class ItStaffController {

    static allowedMethods = [index: ['GET', 'POST'], saveIncidentChanges: 'POST', openCloseIncident: 'POST']

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

    @Secured(["hasAnyRole('IT')"])
    def saveIncidentChanges(){
        def employee = springSecurityService.loadCurrentUser()
        def incident = Incident.findByIdAndReportedByNotEquals(params.id.toLong(), employee)
        if(incident){
            if(params.additionalNotes){
                incident.resolutionNotes = """
                   |${employee.fullName} : \n
                   |${params.additionalNotes} \n
                   |${incident.resolutionNotes}""".stripMargin().stripIndent()
                incident.assignee = Employee.findByEmail(params.assignee)
                incident.save()
            }

            def equipment = incident.equipment
            if(params.equipmentHistoryNotes){
                equipment.notes = """
                   |${employee.fullName} : \n
                   |${params.equipmentHistoryNotes} \n
                   |${equipment.notes}""".stripMargin().stripIndent()
            }
            equipment.status = params.equipmentStatus ? EquipmentStatus.valueOf(params.equipmentStatus) : equipment.status
            equipment.save()
            redirect(action: params.successAction, id: incident.id)
        } else {
            redirect action : params.failAction
        }
    }

    @Secured(["hasAnyRole('IT')"])
    def openCloseIncident(){
        def employee = springSecurityService.loadCurrentUser()
        def incident = Incident.findByIdAndReportedByNotEquals(params.id.toLong(), employee)
        if(incident){
            incident.status = incident.status == TicketStatus.OPEN ? TicketStatus.RESOLVED : TicketStatus.OPEN
        }
        saveIncidentChanges()
    }

    @Secured(["hasAnyRole('IT')"])
    def assetBorrowingDetails(long id){
        def assetBorrowing = AssetBorrowing.findByIdAndReportedByNotEqual(id, springSecurityService.currentUser)
        if(assetBorrowing){
            return [assetBorrowing: assetBorrowing]
        } else {
            redirect action : 'index'
        }
    }

    @Secured(["hasAnyRole('IT')"])
    def saveAssetBorrowingChanges(AssetApprovalIntentCommand cmd){
        def employee = springSecurityService.loadCurrentUser()
        def assetBorrowing = cmd.assetBorrowing
        if(params.additionalNotes){
            assetBorrowing.resolutionNotes = """
                   |${employee.fullName} : \n
                   |${params.additionalNotes} \n
                   |${assetBorrowing.resolutionNotes}""".stripMargin().stripIndent()
        }

        if(cmd.equipments){
            Iterator<AssetApprovalIntentCommand.AssetApprovalEquipment> iterator =
                cmd.equipments?.iterator()
            while(iterator.hasNext()){
                def assetApprovalEquipment = iterator.next();

                if(!assetApprovalEquipment || !assetApprovalEquipment.serialNumber){
                    iterator.remove();
                }

                /*
                 * validate = false when
                 * 1. equipment not available
                 * 2. the borrowing date overlaps with another
                 *
                 * TODO
                 * 1. makr asset lent of the assetBorrowing
                 */
                if(assetApprovalEquipment.validate()){
                    assetBorrowing.addToEquipments(assetApprovalEquipment.equipment)
                }
            }
            assetBorrowing.assignee = employee
        }
        assetBorrowing.save()
        render view : 'assetBorrowingDetails', model : [assetBorrowing : cmd]
    }

    //resolveAssetBorrowing - with validation
    //reopenAssetBorrowing - no validation
    //markAssetLent - with validation
}
