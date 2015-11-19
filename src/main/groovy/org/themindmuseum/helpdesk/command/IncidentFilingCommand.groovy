package org.themindmuseum.helpdesk.command

import grails.validation.Validateable
import org.themindmuseum.helpdesk.domain.Equipment

/**
 * Created by aldrin on 11/19/15.
 */
class IncidentFilingCommand implements Validateable{

    String subject
    String description
    String serialNumber

    static constraints = {
        subject nullable: false, blank: false
        description nullable: false, blank: false
        serialNumber nullable: false, blank: false, validator : { serialNumber, instance ->
            return instance.equipment ? true : 'invalid.serial.number'
        }
        equipment nullable:true
    }

    Equipment getEquipment(){
        return Equipment.findBySerialNumber(serialNumber)
    }
}
