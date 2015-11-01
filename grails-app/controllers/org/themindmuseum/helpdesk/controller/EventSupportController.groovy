package org.themindmuseum.helpdesk.controller

import grails.plugin.springsecurity.annotation.Secured
import org.themindmuseum.helpdesk.TicketStatus
import org.themindmuseum.helpdesk.command.AssetBorrowingIntentCommand
import org.themindmuseum.helpdesk.command.EventSupportIntentCommand
import org.themindmuseum.helpdesk.domain.AssetBorrowing
import org.themindmuseum.helpdesk.domain.EventSupport
import org.themindmuseum.helpdesk.utils.DateUtils

class EventSupportController extends SupportTicketController{

    @Secured(["hasAnyRole('IT', 'EMPLOYEE')"])
    def index() {}

    @Secured(["hasAnyRole('IT', 'EMPLOYEE')"])
    def saveEventSupportIntent(){
        def eventSupportIntent = new EventSupportIntentCommand()

        bindData(eventSupportIntent, params, [exclude: ['startTime', 'endTime']])
        eventSupportIntent.startTime = DateUtils.tryParseLocalDateTimeFromDateTimePicker(params.startTime)
        eventSupportIntent.endTime = DateUtils.tryParseLocalDateTimeFromDateTimePicker(params.endTime)

        if(eventSupportIntent.validate()){
            def eventSupport = new EventSupport(eventSupportIntent.properties)
            eventSupport.reportedBy = springSecurityService.currentUser
            eventSupport.save()
            redirect action : 'myEventSupportIntents'
            return
        }
        render view : 'index', model: [eventSupportIntent : eventSupportIntent]
    }

    @Secured(["hasAnyRole('IT', 'EMPLOYEE')"])
    def myEventSupportIntents(){
        def employee = springSecurityService.currentUser
        def intents = EventSupport.findAllByReportedByAndStatusAndResourceIssued(employee, TicketStatus.OPEN, false, [sortBy: 'timeFiled'])
        return [intents : intents]
    }
}
