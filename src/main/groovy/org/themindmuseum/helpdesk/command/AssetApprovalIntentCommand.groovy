package org.themindmuseum.helpdesk.command

import grails.validation.Validateable
import groovy.transform.PackageScope
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
    List<AssetApprovalEquipmentDTO> equipments = ListUtils.lazyList([], {new AssetApprovalEquipmentDTO()} as Factory)
    String additionalNotes

    private AssetBorrowing assetBorrowing;

    static constraints = {
        additionalNotes nullable: true, maxSize: 1024
        equipments minSize: 1, validator : { equipments, instance ->
            for(def equipment : equipments){
                if(equipment?.validate()){
                    equipment.borrowedDate = instance.assetBorrowing?.borrowedDate
                    equipment.returningDate = instance.assetBorrowing?.returningDate
                    return true
                }
                return 'equipments.not.available'
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
