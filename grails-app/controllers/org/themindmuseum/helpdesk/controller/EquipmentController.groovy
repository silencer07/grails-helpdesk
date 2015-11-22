package org.themindmuseum.helpdesk.controller

import grails.plugin.springsecurity.annotation.Secured
import org.themindmuseum.helpdesk.EquipmentStatus
import org.themindmuseum.helpdesk.domain.Equipment
import org.themindmuseum.helpdesk.utils.DateUtils

import java.time.LocalDate

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
@Secured(["hasAnyRole('IT')"])
class EquipmentController {

    def springSecurityService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Equipment.list(params), model:[equipmentCount: Equipment.count()]
    }

    def show(Equipment equipment) {
        redirect action : 'edit', id : equipment.id
    }

    def create() {
        respond new Equipment(params)
    }

    private def bindEquipmentData(Equipment equipment){
        bindData(equipment, params, [exclude: ['status', 'dateTagged', 'dateDisposed', 'notes', 'datePurchased', 'warrantyEndDate']])

        def employee = springSecurityService.currentUser

        if(params.notes){
            equipment.notes = """
                   |${employee.fullName} : \n
                   |${params.notes}
                   |${equipment.notes}""".stripMargin().stripIndent()
        }

        def status = EquipmentStatus.valueOf(params.status)
        if(equipment.status != status){
            equipment.status = status

            if(equipment.status == EquipmentStatus.DISPOSED){
                equipment.dateDisposed = LocalDate.now()
            }
        }

        equipment.datePurchased = DateUtils.tryParseLocalDateTimeFromDateTimePicker(params.datePurchased)?.toLocalDate()
        equipment.warrantyEndDate = DateUtils.tryParseLocalDateTimeFromDateTimePicker(params.warrantyEndDate)?.toLocalDate()

        return equipment
    }

    @Transactional
    def update() {
        Equipment equipment = bindEquipmentData(Equipment.findById(params.id))
        if (equipment == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (equipment.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond equipment.errors, view:'edit'
            return
        }

        equipment.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'equipment.label', default: 'Equipment'), equipment.id])
                redirect equipment
            }
            '*'{ respond equipment, [status: OK] }
        }
    }

    @Transactional
    def save() {
        Equipment equipment = bindEquipmentData(new Equipment())
        if (equipment == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (equipment.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond equipment.errors, view:'create'
            return
        }


        try{
            equipment.save flush:true
        } catch (Exception e) {
            respond equipment.errors, view:'create'
            return
        }


        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'equipment.label', default: 'Equipment'), equipment.id])
                redirect equipment
            }
            '*' { respond equipment, [status: CREATED] }
        }
    }

    def edit(Equipment equipment) {
        respond equipment
    }

    @Transactional
    def delete(Equipment equipment) {

        if (equipment == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        equipment.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'equipment.label', default: 'Equipment'), equipment.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'equipment.label', default: 'Equipment'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
