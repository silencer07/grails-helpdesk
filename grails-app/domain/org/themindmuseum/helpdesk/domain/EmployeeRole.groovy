package org.themindmuseum.helpdesk.domain

import grails.gorm.DetachedCriteria
import groovy.transform.ToString

import org.apache.commons.lang.builder.HashCodeBuilder

@ToString(cache=true, includeNames=true, includePackage=false)
class EmployeeRole implements Serializable {

	private static final long serialVersionUID = 1

	Employee employee
	Role role

	EmployeeRole(Employee u, Role r) {
		employee = u
		role = r
	}

	@Override
	boolean equals(other) {
		if (!(other instanceof EmployeeRole)) {
			return false
		}

		other.employee?.id == employee?.id && other.role?.id == role?.id
	}

	@Override
	int hashCode() {
		def builder = new HashCodeBuilder()
		if (employee) builder.append(employee.id)
		if (role) builder.append(role.id)
		builder.toHashCode()
	}

	static EmployeeRole get(long employeeId, long roleId) {
		criteriaFor(employeeId, roleId).get()
	}

	static boolean exists(long employeeId, long roleId) {
		criteriaFor(employeeId, roleId).count()
	}

	private static DetachedCriteria criteriaFor(long employeeId, long roleId) {
		EmployeeRole.where {
			employee == Employee.load(employeeId) &&
			role == Role.load(roleId)
		}
	}

	static EmployeeRole create(Employee employee, Role role, boolean flush = false) {
		def instance = new EmployeeRole(employee, role)
		instance.save(flush: flush, insert: true)
		instance
	}

	static boolean remove(Employee u, Role r, boolean flush = false) {
		if (u == null || r == null) return false

		int rowCount = EmployeeRole.where { employee == u && role == r }.deleteAll()

		if (flush) { EmployeeRole.withSession { it.flush() } }

		rowCount
	}

	static void removeAll(Employee u, boolean flush = false) {
		if (u == null) return

		EmployeeRole.where { employee == u }.deleteAll()

		if (flush) { EmployeeRole.withSession { it.flush() } }
	}

	static void removeAll(Role r, boolean flush = false) {
		if (r == null) return
		EmployeeRole.where { role == r }.deleteAll()

		if (flush) { EmployeeRole.withSession { it.flush() } }
	}

	static mapping = {
		id composite: ['employee', 'role']
		version false
	}

	static belongsTo = [employee : Employee, role : Role]
}
