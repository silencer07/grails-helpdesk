package org.themindmuseum.helpdesk.controller

import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured
import org.themindmuseum.helpdesk.TicketStatus
import org.themindmuseum.helpdesk.domain.AssetBorrowing
import org.themindmuseum.helpdesk.domain.EventSupport
import org.themindmuseum.helpdesk.utils.DateUtils

class CalendarController {

    @Secured(["hasAnyRole('IT', 'EMPLOYEE')"])
    def equipment() {
        def supportCalendar = []
        AssetBorrowing.findAllByStatus(TicketStatus.RESOLVED).each{ borrowing ->
            borrowing.equipments.each { equipment ->
                def support = [:]
                support.title = equipment.name
                support.start = DateUtils.asDate(borrowing.borrowedDate)
                support.end = DateUtils.asDate(borrowing.returningDate)
                support.description = equipment.serialNumber

                supportCalendar << support
            }
        }
        EventSupport.findAllByStatus(TicketStatus.RESOLVED).each { event ->
            event.equipments.each { equipment ->
                def support = [:]
                support.title = equipment.name
                support.start = DateUtils.asDate(event.startTime)
                support.end = DateUtils.asDate(event.endTime)
                support.description = equipment.serialNumber

                supportCalendar << support
            }
        }
        render view : 'index', model: [title : 'Equipment Calendar', calendar : supportCalendar]
    }

    @Secured(["hasAnyRole('IT', 'EMPLOYEE')"])
    def itSupport() {
        def supportCalendar = []
        EventSupport.findAllByStatus(TicketStatus.RESOLVED).each{ event ->
            def support = [:]
            support.title = event.assignee.fullName
            support.start = DateUtils.asDate(event.startTime)
            support.end = DateUtils.asDate(event.endTime)

            supportCalendar << support

            event.supportStaff.each { staff ->
                if(staff.fullName.equals(support.title) == false){
                    def anotherSupport = [:]
                    anotherSupport.title = staff.fullName
                    anotherSupport.start = DateUtils.asDate(event.startTime)
                    anotherSupport.end = DateUtils.asDate(event.endTime)

                    supportCalendar << anotherSupport
                }
            }
        }
        render view : 'index', model: [title : 'Support Staff Calendar', calendar : supportCalendar]
    }
}
