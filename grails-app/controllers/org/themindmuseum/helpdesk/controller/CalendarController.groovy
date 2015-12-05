package org.themindmuseum.helpdesk.controller

import grails.plugin.springsecurity.annotation.Secured

class CalendarController {

    @Secured(["hasAnyRole('IT', 'EMPLOYEE')"])
    def equipment() {
        render view : 'index', model: [title : 'Equipment Calendar']
    }

    @Secured(["hasAnyRole('IT', 'EMPLOYEE')"])
    def itSupport() {
        render view : 'index', model: [title : 'Support Staff Calendar']
    }
}
