package org.themindmuseum.helpdesk.domain

class Department {

    String name

    static constraints = {
        name unique:true, blank:false, size : 1..50
    }

    static hasMany = [ employees:Employee ]
}
