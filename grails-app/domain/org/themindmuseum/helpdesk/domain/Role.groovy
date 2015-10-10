package org.themindmuseum.helpdesk.domain

class Role {

    String name

    static constraints = {
        name unique:true, blank:false, size : 1..100
    }
}
