package org.themindmuseum.helpdesk.command

import grails.validation.Validateable
import groovy.transform.PackageScope
import org.themindmuseum.helpdesk.EquipmentStatus
import org.themindmuseum.helpdesk.domain.Equipment
import org.themindmuseum.helpdesk.utils.DateUtils

import java.time.LocalDate
import java.time.LocalDateTime

/**
 * Created by aldrin on 11/18/15.
 */
class AssetReturningEquipmentDTO implements Validateable{

    String serialNumber
    EquipmentStatus status
    String dateTaggedString = DateUtils.formatJQueryDateTimeInput(LocalDate.now())
    String notes

    private Equipment equipment = Equipment.findBySerialNumber(serialNumber)

    static constraints = {
        serialNumber blank:false, size : 1..200
        status nullable: false
        dateTaggedString nullable : false
        notes nullable : true, blank : true
        dateTagged nullable : false
    }

    String getName() {
        return equipment?.name
    }

    String toString(){
        return getName()
    }

    String getDateTaggedString() {
        return dateTaggedString
    }

    void setDateTaggedString(String dateTaggedString) {
        this.dateTaggedString = dateTaggedString ?: this.dateTaggedString
    }

    LocalDate getDateTagged(){
        return DateUtils.tryParseLocalDateTimeFromDateTimePicker(dateTaggedString)?.toLocalDate()
    }
}
