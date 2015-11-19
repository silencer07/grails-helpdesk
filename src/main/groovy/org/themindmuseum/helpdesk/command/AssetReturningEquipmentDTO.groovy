package org.themindmuseum.helpdesk.command

import grails.validation.Validateable
import groovy.transform.PackageScope
import org.themindmuseum.helpdesk.EquipmentStatus
import org.themindmuseum.helpdesk.domain.Equipment
import org.themindmuseum.helpdesk.utils.DateUtils

import java.time.LocalDate
import java.time.LocalDateTime
import java.time.format.DateTimeFormatter

/**
 * Created by aldrin on 11/18/15.
 */
class AssetReturningEquipmentDTO implements Validateable{

    String serialNumber
    EquipmentStatus status
    String dateTaggedString = LocalDateTime.now().format(DateTimeFormatter.ofPattern(DateUtils.DEFAULT_JQUERY_DATETIME_PICKER_FORMAT))
    String additionalNotes

    private Equipment equipment

    static constraints = {
        serialNumber blank:false, size : 1..200, validator : { serialNumber, instance ->
            def equipment = Equipment.findBySerialNumber(serialNumber)
            if(equipment){
                instance.equipment = equipment
                return true
            }
            return 'serial.number.invalid'
        }
        status nullable: false
        dateTaggedString nullable : false
        notes nullable : true, blank : true
        dateTagged nullable : false
        additionalNotes nullable:true
        equipment nullable : true
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

    Equipment getEquipment(){
        return equipment
    }

    String getNotes(){
        return equipment?.notes
    }
}
