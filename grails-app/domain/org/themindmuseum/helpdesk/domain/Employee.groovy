package org.themindmuseum.helpdesk.domain

import org.themindmuseum.helpdesk.Priority

class Employee implements Serializable {

	private static final long serialVersionUID = 1

	transient springSecurityService

	String firstName
	String lastName
	String email
	String password
	Department department
	Priority priority

	boolean enabled = true
	boolean accountExpired
	boolean accountLocked
	boolean passwordExpired

	static constraints = {
		firstName blank:false, size : 1..100
		lastName blank:false, size : 1..100
		email unique:true, blank:false, size : 1..100, email:true
		password password:true, blank:false
		department nullable: false
		priority nullable : false
		department nullable : false
		employeeRoles nullable: false, minSize: 1
	}

	static hasOne = [department:Department]

	static hasMany = [employeeRoles: EmployeeRole]

	static transients = ['springSecurityService']

	static mapping = {
		password column: '`password`'
	}

	Employee(String email, String password) {
		this.email = email
		this.password = password
	}

	@Override
	int hashCode() {
		email?.hashCode() ?: 0
	}

	@Override
	boolean equals(other) {
		is(other) || (other instanceof Employee && other.email == email)
	}

	@Override
	String toString() {
		email
	}

	Set<Role> getAuthorities() {
		EmployeeRole.findAllByEmployee(this)*.role
	}

	def beforeInsert() {
		encodePassword()
	}

	def beforeUpdate() {
		if (isDirty('password')) {
			encodePassword()
		}
	}

	protected void encodePassword() {
		password = springSecurityService?.passwordEncoder ? springSecurityService.encodePassword(password) : password
	}

	def getFullName(){
		return "${firstName} ${lastName}"
	}
}
