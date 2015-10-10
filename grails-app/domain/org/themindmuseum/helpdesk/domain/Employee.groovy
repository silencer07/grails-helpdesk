package org.themindmuseum.helpdesk.domain

import com.themindmuseum.helpdesk.Priority

class Employee {

    String firstName
    String lastName
    String email
    String password
    Department department
    Priority priority
    Set<UserRole> userRoles

    static constraints = {
        firstName blank:false, size : 1..100
        lastName blank:false, size : 1..100
        email unique:true, blank:false, size : 1..100, email:true
        password password:true, blank:false, size : 1..100
        department nullable: false
        priority nullable : false
        department nullable : false
        userRoles nullable: false, minSize: 1
    }

    static hasOne = [department:Department]

    static hasMany = [userRoles:UserRole]
}
