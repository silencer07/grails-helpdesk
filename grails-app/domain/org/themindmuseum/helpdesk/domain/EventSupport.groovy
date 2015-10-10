package org.themindmuseum.helpdesk.domain

import java.time.LocalDateTime

class EventSupport extends SupportTicket{

    LocalDateTime startTime
    LocalDateTime endTime
    Set<Equipment> equipments
    Set<Employee> supportStaff
    String venue

    static constraints = {
        startTime nullable: false
        endTime nullable: false
        venue nullable:false, size:1..500
    }

    static hasMany = [equipments:Equipment, supportStaff: Employee]
}
