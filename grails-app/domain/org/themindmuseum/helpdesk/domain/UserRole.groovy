package org.themindmuseum.helpdesk.domain

class UserRole {

    Employee employee
    Role role

    static constraints = {
        employee nullable:false
        role nullable:false
    }

    static hasOne = [employee:Employee]

    static belongsTo = [role : Role]
}
