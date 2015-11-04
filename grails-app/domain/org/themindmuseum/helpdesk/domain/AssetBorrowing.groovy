package org.themindmuseum.helpdesk.domain

import java.time.LocalDateTime

class AssetBorrowing extends SupportTicket{

    LocalDateTime borrowedDate
    LocalDateTime returningDate
    LocalDateTime returnedDate
    boolean assetLent = false
    boolean assetReturned = false

    static constraints = {
        equipments nullable: true, validator: mustHaveAtLeastOneEquipment
        borrowedDate nullable: false
        returningDate nullable: false, validator: mustBeLaterThanBorrowedDate
        returnedDate nullable: true, validator: mustBeLaterThanBorrowedDate
    }

    static def mustBeLaterThanBorrowedDate = { date, instance ->
        if(instance.borrowedDate && date){
            if(date.compareTo(instance.borrowedDate) < 0){
                return 'must.be.greater.than.borrowed.date'
            }
        }
        return true
    }

    static def mustHaveAtLeastOneEquipment = { equipments, instance ->
        if(instance.assetLent && !equipments){
            return 'must.lend.at.least.one.equipment'
        }
        return true
    }

    static hasMany = [equipments : Equipment]
}
