package org.themindmuseum.helpdesk.controller

import grails.plugin.springsecurity.annotation.Secured
import org.themindmuseum.helpdesk.domain.Employee
import org.themindmuseum.helpdesk.domain.EmployeeRole
import org.themindmuseum.helpdesk.domain.Role

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
@Secured(["hasAnyRole('IT')"])
class EmployeeController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Employee.list(params), model:[employeeCount: Employee.count()]
    }

    def show(Employee employee) {
        redirect action: 'edit', id: employee.id
    }

    def create() {
        respond new Employee(params)
    }

    def bindEmployeeData(Employee employee){
        bindData(employee, params, [exclude: ['role', 'password']])

        employee.password = params.password ?: employee.password

        def employeeRole = employee.employeeRoles?.getAt(0)
        def role = Role.get(params.role.toLong());

        if(employeeRole?.role?.id != role.id){
            if(employeeRole){
                employee.employeeRoles.clear()
            }

            employee.addToEmployeeRoles(new EmployeeRole(employee, role))
        }
        return employee
    }

    @Transactional
    def save() {
        def employee = bindEmployeeData(new Employee())
        if (employee == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (employee.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond employee.errors, view:'create'
            return
        }

        employee.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'employee.label', default: 'Employee'), employee.id])
                redirect employee
            }
            '*' { respond employee, [status: CREATED] }
        }
    }

    def edit(Employee employee) {
        respond employee
    }

    @Transactional
    def update() {
        def employee = bindEmployeeData(Employee.findById(params.id))
        if (employee == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (employee.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond employee.errors, view:'edit'
            return
        }

        employee.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'employee.label', default: 'Employee'), employee.id])
                redirect employee
            }
            '*'{ respond employee, [status: OK] }
        }
    }

    @Transactional
    def delete(Employee employee) {

        if (employee == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        employee.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'employee.label', default: 'Employee'), employee.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'employee.label', default: 'Employee'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
