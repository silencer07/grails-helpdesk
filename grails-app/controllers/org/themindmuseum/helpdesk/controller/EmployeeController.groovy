package org.themindmuseum.helpdesk.controller

import grails.plugin.springsecurity.annotation.Secured

class EmployeeController {

    @Secured(["hasAnyRole('IT', 'EMPLOYEE')"])
    def index() { }
}
