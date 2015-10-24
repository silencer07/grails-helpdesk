package org.themindmuseum.helpdesk.init

import com.themindmuseum.helpdesk.Priority
import grails.transaction.Transactional
import org.themindmuseum.helpdesk.domain.Department
import org.themindmuseum.helpdesk.domain.Employee
import org.themindmuseum.helpdesk.domain.EmployeeRole
import org.themindmuseum.helpdesk.domain.Role

/**
 * DO NOT USE THIS CLASS. this class is only used for initialization
 */
@Transactional
class InitialDataService {

    def hr
    def it
    def employeeRole
    def itRole

    def initializeSampleData() {
        initializeDepartments()
        initializeRoles()
        initializeEmployees()
    }

    def initializeDepartments(){
        hr = new Department(name : 'Human Resource')
        hr.save()

        def finance = new Department(name : 'Finance')
        finance.save()

        it = new Department(name : 'IT Services')
        it.save()
    }

    def initializeRoles(){
        employeeRole = new Role(authority : 'EMPLOYEE')
        employeeRole.save()

        itRole = new Role(authority : 'IT')
        itRole.save()
    }

    def initializeEmployees(){
        def employee1 = new Employee()
        employee1.firstName = 'Aldrin'
        employee1.lastName = 'Tingson'
        employee1.email = 'atingson@themindmuseum.org'
        employee1.password = 'password'
        employee1.department = hr;
        employee1.priority = Priority.NORMAL

        def employee1Role = new EmployeeRole(employee1, employeeRole)
        employee1.addToEmployeeRoles(employee1Role)
        employee1.save()

        def employee2 = new Employee()
        employee2.firstName = 'Bryant'
        employee2.lastName = 'Cabantac'
        employee2.email = 'bcabantac@themindmuseum.org'
        employee2.password = 'password'
        employee2.department = it;
        employee2.priority = Priority.HIGH

        def employee2Role = new EmployeeRole(employee1, itRole)
        employee2.addToEmployeeRoles(employee2Role)
        employee2.save()

        def employee3 = new Employee()
        employee3.firstName = 'Mary'
        employee3.lastName = 'Rivero'
        employee3.email = 'mrivero@themindmuseum.org'
        employee3.password = 'password'
        employee3.department = it;
        employee3.priority = Priority.NORMAL

        def employee3Role = new EmployeeRole(employee3, itRole)
        employee3.addToEmployeeRoles(employee3Role)
        employee3.save()
    }
}
