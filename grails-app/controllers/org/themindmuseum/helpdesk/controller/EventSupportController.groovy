package org.themindmuseum.helpdesk.controller

import grails.plugin.springsecurity.annotation.Secured
import org.themindmuseum.helpdesk.TicketStatus
import org.themindmuseum.helpdesk.command.AssetBorrowingIntentCommand
import org.themindmuseum.helpdesk.command.EventSupportIntentCommand
import org.themindmuseum.helpdesk.domain.AssetBorrowing
import org.themindmuseum.helpdesk.domain.EventSupport
import org.themindmuseum.helpdesk.utils.DateUtils

class EventSupportController extends SupportTicketController{

    static allowedMethods = [saveEventSupportIntent: 'POST', additionalNotes : 'POST',
                             resolveEventSupport: 'POST', reopenEventSupport: 'POST', markResourceAllocated: 'POST']

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
        def intents = EventSupport.findAllByStatusAndResourceIssuedAndReportedBy(TicketStatus.OPEN, false, employee, [sortBy: 'timeFiled'])
        return [intents : intents]
    }

    @Secured(["hasAnyRole('IT', 'EMPLOYEE')"])
    def details(long id) {
        def employee = springSecurityService.currentUser
        def eventSupport = EventSupport.findByIdAndReportedBy(id, employee)
        if(eventSupport){
            return [eventSupport : eventSupport]
        } else {
            redirect action: 'myEventSupportIntents'
        }
    }

    @Secured(["hasAnyRole('IT', 'EMPLOYEE')"])
    def addAdditionalNotes(){
        addAdditionalNotes(params.eventSupportId?.toLong(), EventSupport, 'myEventSupportIntents', 'details')
    }

    @Secured(["hasAnyRole('IT', 'EMPLOYEE')"])
    def resolveEventSupport(){
        resolveSupportTicket(params.eventSupportId?.toLong(), EventSupport,
                'myEventSupportIntents', 'myEventSupports')
    }

    @Secured(["hasAnyRole('IT', 'EMPLOYEE')"])
    def reopenEventSupport(){
        reopenSupportTicket(params.eventSupportId?.toLong(), EventSupport,
                'myEventSupportIntents', 'myEventSupports')
    }

    @Secured(["hasAnyRole('IT', 'EMPLOYEE')"])
    def markResourceAllocated(){
        def eventSupport = EventSupport.findByIdAndReportedBy(
                params.eventSupportId?.toLong(), springSecurityService.currentUser)
        if(eventSupport){
            eventSupport.resourceIssued = !eventSupport.resourceIssued
            redirect(action: 'details', id: eventSupport.id)
            return
        }
        redirect(action: 'myEventSupports')
    }

    @Secured(["hasAnyRole('IT', 'EMPLOYEE')"])
    def myEventSupports(){
        def employee = springSecurityService.currentUser
        def eventSupports = EventSupport.findAllByReportedByAndStatus(employee, TicketStatus.RESOLVED, [sortBy : 'startTime'])
        return [eventSupports : eventSupports]
    }
}
