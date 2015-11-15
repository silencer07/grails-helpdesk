package org.themindmuseum.helpdesk.command

import grails.validation.Validateable
import org.apache.commons.collections.ListUtils
import org.apache.commons.collections.Factory
import org.themindmuseum.helpdesk.TicketStatus
import org.themindmuseum.helpdesk.domain.AssetBorrowing
import org.themindmuseum.helpdesk.domain.Employee
import org.themindmuseum.helpdesk.domain.Equipment

import java.time.LocalDateTime

/**
 * Created by aldrin on 11/15/15.
 */
class AssetApprovalIntentCommand implements Validateable{

    Long assetBorrowingId
    List<AssetApprovalEquipment> equipments = ListUtils.lazyList([], {new AssetApprovalEquipment()} as Factory)
    String additionalNotes

    private AssetBorrowing assetBorrowing;

    static constraints = {
        additionalNotes nullable: true, maxSize: 1024
        equipments minSize: 1, validator : { equipments ->
            for(def equipment : equipments){
                if(equipment.validate() == false){
                    return 'equipments.has.invalid.serial'
                }
                return true
            }
        }
        assetBorrowingId nullable : false, validator : { assetBorrowingId, instance ->
            def assetBorrowing = AssetBorrowing.findById(assetBorrowingId);
            if(assetBorrowing){
                instance.assetBorrowing = assetBorrowing
                return true
            }
            return 'asset.borrowing.must.exist'
        }
    }

    public static class AssetApprovalEquipment implements Validateable {

        private Equipment equipment
        String serialNumber

        static constraints = {
            serialNumber nullable:false, validator : { serialNumber, instance ->
                def equipment = Equipment.findBySerialNumber(serialNumber)
                if(equipment) {
                    instance.equipment = equipment
                    return true
                }
                return 'serial.number.incorrect'
            }
            equipment validator : { equipment ->
                if(equipment){
                    //put validation here
                }
            }
        }

        String getName(){
            return equipment ? equipment.name : 'invalid serial'
        }

        Equipment getEquipment(){
            return equipment
        }
    }

    Long getId(){
        return assetBorrowing?.id
    }

    Employee getAssignee() {
        return assetBorrowing?.assignee
    }

    Employee getReportedBy() {
        return assetBorrowing?.reportedBy
    }

    LocalDateTime getBorrowedDate() {
        return assetBorrowing?.borrowedDate
    }

    LocalDateTime getReturningDate() {
        return assetBorrowing?.returningDate
    }

    LocalDateTime getReturnedDate() {
        return assetBorrowing?.returnedDate
    }

    boolean getAssetLent() {
        return assetBorrowing?.assetLent
    }

    boolean getAssetReturned() {
        return assetBorrowing?.assetReturned
    }

    LocalDateTime getTimeFiled() {
        return assetBorrowing?.timeFiled
    }

    String getSubject() {
        return assetBorrowing?.subject
    }

    String getDescription() {
        return assetBorrowing?.description
    }

    TicketStatus getStatus() {
        return assetBorrowing?.status
    }

    LocalDateTime getTimeReopened() {
        return assetBorrowing?.timeReopened
    }

    LocalDateTime getTimeResolved() {
        return assetBorrowing?.timeResolved
    }

    String getResolutionNotes() {
        return assetBorrowing?.resolutionNotes
    }

    AssetBorrowing getAssetBorrowing(){
        return assetBorrowing
    }
}
