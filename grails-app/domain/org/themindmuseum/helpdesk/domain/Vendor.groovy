package org.themindmuseum.helpdesk.domain

class Vendor {

    String name
    String contactPerson
    String phone
    String email
    String address

    static constraints = {
        name unique:true, blank:false, size : 1..50
        contactPerson blank:false, size : 1..100
        phone blank:false, size : 1..50
        email email:true, blank:false, size : 1..50
    }

    static hasMany = [equipments : Equipment]
}
