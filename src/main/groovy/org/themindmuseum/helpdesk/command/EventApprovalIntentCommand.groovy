package org.themindmuseum.helpdesk.command

import grails.validation.Validateable
import org.apache.commons.collections.Factory
import org.apache.commons.collections.ListUtils
import org.themindmuseum.helpdesk.TicketStatus
import org.themindmuseum.helpdesk.domain.AssetBorrowing
import org.themindmuseum.helpdesk.domain.Employee
import org.themindmuseum.helpdesk.domain.EventSupport

import java.time.LocalDateTime

/**
 * Created by aldrin on 11/20/15.
 */
class EventApprovalIntentCommand implements Validateable{

    Long eventSupportId
    List<AssetBorrowingApprovalEquipmentDTO> equipments = ListUtils.lazyList([], {new AssetBorrowingApprovalEquipmentDTO()} as Factory)
    String additionalNotes
    Set<String> supportStaff = new HashSet<>();

    private EventSupport eventSupport;

    static constraints = {
        additionalNotes nullable: true, maxSize: 1024
        eventSupportId nullable : false, validator : { eventSupportId, instance ->
            def eventSupport = EventSupport.findById(eventSupportId)
            if(eventSupport){
                instance.eventSupport = eventSupport
                return true
            }
            return 'event.support.must.exist'
        }
        equipments nullable : true, minSize: 0, validator : { equipments, instance ->
            for(def equipment : equipments){
                def eventSupport = EventSupport.findById(instance.eventSupportId)
                assert eventSupport
                equipment.owner = eventSupport
                if(equipment?.validate()){
                    equipment.borrowedDate = eventSupport.startTime
                    equipment.returningDate = eventSupport.endTime
                } else {
                    return 'equipments.not.available'
                }
            }
            return true
        }
        supportStaff nullable:true, minSize : 0

        assignee nullable : true
    }

    Long getId(){
        return eventSupport?.id
    }

    Employee getAssignee() {
        return eventSupport?.assignee
    }

    Employee getReportedBy() {
        return eventSupport?.reportedBy
    }

    LocalDateTime getStartTime() {
        return eventSupport?.startTime
    }

    LocalDateTime getEndTime() {
        return eventSupport?.endTime
    }

    boolean getResourceIssued() {
        return eventSupport?.resourceIssued
    }

    LocalDateTime getTimeFiled() {
        return eventSupport?.timeFiled
    }

    String getSubject() {
        return eventSupport?.subject
    }

    String getDescription() {
        return eventSupport?.description
    }

    TicketStatus getStatus() {
        return eventSupport?.status
    }

    String getResolutionNotes() {
        return eventSupport?.resolutionNotes
    }

    EventSupport getEventSupport(){
        return eventSupport
    }
}
