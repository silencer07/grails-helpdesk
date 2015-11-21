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
 * Created by aldrin on 11/18/15.
 */
class EventAssetReturningIntentCommand implements Validateable{
    Long eventSupportId
    List<AssetReturningEquipmentDTO> equipments = ListUtils.lazyList([], {new AssetReturningEquipmentDTO()} as Factory)
    String additionalNotes

    private EventSupport eventSupport

    static constraints = {
        additionalNotes nullable: true, maxSize: 1024
        eventSupportId nullable : false, validator : { eventSupportId, instance ->
            def eventSupport = EventSupport.findById(eventSupportId)
            if(eventSupport){
                instance.eventSupport = eventSupport
                return true
            }
            return 'asset.borrowing.must.exist'
        }
        equipments minSize: 1, validator : { equipments, instance ->
            for(def equipment : equipments){
                if(!equipment.validate()){
                    return 'equipments.return.validation.error'
                }
            }
            return equipments.isEmpty() ? 'equipments.must.not.be.empty' : true
        }

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

    boolean getAssetLent() {
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
