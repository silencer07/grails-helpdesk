package org.themindmuseum.helpdesk.command

import grails.validation.Validateable
import org.apache.commons.collections.ListUtils
import org.apache.commons.collections.Factory
import org.themindmuseum.helpdesk.TicketStatus
import org.themindmuseum.helpdesk.domain.AssetBorrowing
import org.themindmuseum.helpdesk.domain.Employee

import java.time.LocalDateTime

/**
 * Created by aldrin on 11/15/15.
 */
class AssetApprovalIntentCommand implements Validateable{

    Long assetBorrowingId
    List<AssetBorrowingApprovalEquipmentDTO> equipments = ListUtils.lazyList([], {new AssetBorrowingApprovalEquipmentDTO()} as Factory)
    String additionalNotes

    private AssetBorrowing assetBorrowing;

    static constraints = {
        additionalNotes nullable: true, maxSize: 1024
        assetBorrowingId nullable : false, validator : { assetBorrowingId, instance ->
            def assetBorrowing = AssetBorrowing.findById(assetBorrowingId)
            if(assetBorrowing){
                instance.assetBorrowing = assetBorrowing
                return true
            }
            return 'asset.borrowing.must.exist'
        }
        equipments minSize: 1, validator : { equipments, instance ->
            for(def equipment : equipments){
                def assetBorrowing = AssetBorrowing.findById(instance.assetBorrowingId)
                assert assetBorrowing
                equipment.owner = assetBorrowing
                if(equipment?.validate()){
                    equipment.borrowedDate = assetBorrowing.borrowedDate
                    equipment.returningDate = assetBorrowing.returningDate
                } else {
                    return 'equipments.not.available'
                }
            }
            return equipments.isEmpty() ? 'equipments.must.not.be.empty' : true
        }

        assignee nullable : true
        returnedDate nullable : true
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

    LocalDateTime getReturnedDate(){
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

    String getResolutionNotes() {
        return assetBorrowing?.resolutionNotes
    }

    AssetBorrowing getAssetBorrowing(){
        return assetBorrowing
    }
}
