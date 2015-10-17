package org.themindmuseum.helpdesk.domain

import com.themindmuseum.helpdesk.EquipmentStatus
import com.themindmuseum.helpdesk.EquipmentType

import java.time.LocalDate

class Equipment {

    String name
    String manufacturer
    Vendor vendor
    String serviceTag
    String serialNumber
    String details
    EquipmentStatus status
    EquipmentType type
    LocalDate datePurchased
    LocalDate warrantyEndDate
    LocalDate dateDisposed
    String notes

    static constraints = {
        name blank:false, size : 1..50
        manufacturer unique:true, blank:false, size : 1..50
        serviceTag blank:false, size : 1..50
        serialNumber unique:true, blank:false, size : 1..200
        details size : 1..1000
        status nullable: false
        type nullable: false
        datePurchased nullable: false
        //TODO warranty should be <= datePurchased
        warrantyEndDate nullable: false
        //TODO dateDisposed should be <= datePurchased
        vendor nullable: false
        notes nullable: true
    }

    static hasOne = [vendor:Vendor]
}
