package org.themindmuseum.helpdesk.controller

import grails.plugin.springsecurity.SpringSecurityUtils
import grails.plugin.springsecurity.annotation.Secured

class IndexController {

    @Secured(["hasAnyRole('IT', 'EMPLOYEE')"])
    def index() {
        if(SpringSecurityUtils.ifAnyGranted('IT')){
            redirect action : 'index', controller : 'itStaff'
        } else {
            redirect action : 'index', controller : 'employee'
        }
    }
}
