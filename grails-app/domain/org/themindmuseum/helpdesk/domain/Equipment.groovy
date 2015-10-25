package org.themindmuseum.helpdesk.domain

import org.themindmuseum.helpdesk.EquipmentStatus
import org.themindmuseum.helpdesk.EquipmentType

import java.time.LocalDate

class Equipment {

    String name
    String manufacturer
    Vendor vendor
    String serviceTag
    String serialNumber
    String details
    EquipmentStatus status = EquipmentStatus.AVAILABLE
    EquipmentType type
    LocalDate datePurchased
    LocalDate warrantyEndDate
    LocalDate dateDisposed
    String notes

    static constraints = {
        name blank:false, size : 1..50
        manufacturer unique:false, blank:false, size : 1..50
        serviceTag blank:false, size : 1..50
        serialNumber unique:true, blank:false, size : 1..200
        details size : 1..1000
        status nullable: false
        type nullable: false
        datePurchased nullable: false
        warrantyEndDate nullable: false, validator : warrantyEndDateMustBeGreaterOrEqualThanPurchaseDate
        dateDisposed nullable: true, validator: dateDisposedMustBeGreaterThanPurchaseDate
        vendor nullable: false
        notes nullable: true
        details nullable: true
    }

    static def warrantyEndDateMustBeGreaterOrEqualThanPurchaseDate = { warrantyEndDate, instance ->
        return warrantyEndDate >= instance.datePurchased ? true : 'warranty.end.date.check'
    }

    static def dateDisposedMustBeGreaterThanPurchaseDate = { dateDisposed, instance ->
        return !dateDisposed || dateDisposed > instance.datePurchased ? true : 'date.disposed.check'
    }

    static hasOne = [vendor:Vendor]
}
