package org.themindmuseum.helpdesk.controller

import grails.plugin.springsecurity.annotation.Secured
import org.springframework.web.servlet.support.RequestContextUtils
import org.themindmuseum.helpdesk.EquipmentStatus
import org.themindmuseum.helpdesk.TicketStatus
import org.themindmuseum.helpdesk.command.AssetBorrowingApprovalEquipmentDTO
import org.themindmuseum.helpdesk.command.AssetApprovalIntentCommand
import org.themindmuseum.helpdesk.command.AssetReturningIntentCommand
import org.themindmuseum.helpdesk.domain.AssetBorrowing
import org.themindmuseum.helpdesk.domain.Employee
import org.themindmuseum.helpdesk.domain.EventSupport
import org.themindmuseum.helpdesk.domain.Incident

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
                   |${params.additionalNotes}
                   |${incident.resolutionNotes}""".stripMargin().stripIndent()
                incident.assignee = Employee.findByEmail(params.assignee)
                incident.save()
            }

            def equipment = incident.equipment
            if(params.equipmentHistoryNotes){
                equipment.notes = """
                   |${employee.fullName} : \n
                   |${params.equipmentHistoryNotes}
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
                   |${params.additionalNotes}
                   |${assetBorrowing.resolutionNotes}""".stripMargin().stripIndent()
        }

        if(cmd.equipments){
            assetBorrowing.equipments.clear()
            Iterator<AssetBorrowingApprovalEquipmentDTO> iterator =
                cmd.equipments?.iterator()
            while(iterator.hasNext()){
                def assetApprovalEquipment = iterator.next();

                if(!assetApprovalEquipment || !assetApprovalEquipment.serialNumber){
                    iterator.remove();
                }

                if(assetApprovalEquipment?.validate()){
                    assetBorrowing.addToEquipments(assetApprovalEquipment.equipment)
                }
            }
            assetBorrowing.assignee = employee
        }
        assetBorrowing.save()
        render view : 'assetBorrowingDetails', model : [assetBorrowing : cmd]
    }

    @Secured(["hasAnyRole('IT')"])
    def resolveAssetBorrowing(AssetApprovalIntentCommand cmd){
        removeNullEquipments(cmd)
        if(cmd.validate()){
            def assetBorrowing = cmd.assetBorrowing
            assetBorrowing.status = TicketStatus.RESOLVED
            assetBorrowing.assetLent = true
            saveAssetBorrowingChanges(cmd)
        } else {
            render view : 'assetBorrowingDetails', model : [assetBorrowing : cmd]
        }
    }

    private def removeNullEquipments(AssetApprovalIntentCommand cmd){
        Iterator<AssetBorrowingApprovalEquipmentDTO> iterator =
                cmd.equipments?.iterator()
        while(iterator?.hasNext()){
            def assetApprovalEquipment = iterator.next();

            if(!assetApprovalEquipment || !assetApprovalEquipment.serialNumber){
                iterator.remove();
            }
        }
    }

    @Secured(["hasAnyRole('IT')"])
    def markAssetLent(AssetApprovalIntentCommand cmd){
        removeNullEquipments(cmd)
        if(cmd.validate()){
            def assetBorrowing = cmd.assetBorrowing
            assetBorrowing.assetLent = !assetBorrowing.assetLent
            assetBorrowing.save()
            saveAssetBorrowingChanges(cmd)
        } else {
            render view : 'assetBorrowingDetails', model : [assetBorrowing : cmd]
        }
    }

    @Secured(["hasAnyRole('IT')"])
    def reopenAssetBorrowing(AssetApprovalIntentCommand cmd){
        def assetBorrowing = cmd.assetBorrowing
        assetBorrowing.status = TicketStatus.OPEN
        assetBorrowing.assetReturned = false
        assetBorrowing.save()
        redirect action: 'assetBorrowingDetails', id: assetBorrowing.id
    }

    @Secured(["hasAnyRole('IT')"])
    def receiveBorrowedAssets(long id){
        assetBorrowingDetails(id)
    }

    @Secured(["hasAnyRole('IT')"])
    def saveAssetReturningChanges(AssetReturningIntentCommand cmd) {
        def employee = springSecurityService.loadCurrentUser()
        def assetBorrowing = cmd.assetBorrowing

        if(params.additionalNotes){
            assetBorrowing.resolutionNotes = """
                   |${employee.fullName} : \n
                   |${params.additionalNotes}
                   |${assetBorrowing.resolutionNotes}""".stripMargin().stripIndent()
            assetBorrowing.save()
        }
        redirect action : 'receiveBorrowedAssets', id : assetBorrowing.id
    }

    @Secured(["hasAnyRole('IT')"])
    def markAssetReturned(AssetReturningIntentCommand cmd) {
        if(cmd.validate()){
            render 'valid'
        } else {
            render 'invalid'
        }
    }
}
