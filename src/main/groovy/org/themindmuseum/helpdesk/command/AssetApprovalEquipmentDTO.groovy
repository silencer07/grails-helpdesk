package org.themindmuseum.helpdesk.command

import grails.validation.Validateable
import groovy.transform.PackageScope
import org.apache.commons.collections.Factory
import org.apache.commons.collections.ListUtils
import org.themindmuseum.helpdesk.EquipmentStatus
import org.themindmuseum.helpdesk.TicketStatus
import org.themindmuseum.helpdesk.domain.AssetBorrowing
import org.themindmuseum.helpdesk.domain.Employee
import org.themindmuseum.helpdesk.domain.Equipment
import org.themindmuseum.helpdesk.domain.EventSupport

import java.time.LocalDateTime

/**
 * Created by aldrin on 11/15/15.
 */
class AssetApprovalEquipmentDTO implements Validateable {

    String serialNumber

    private Equipment equipment

    @PackageScope
    LocalDateTime borrowedDate

    @PackageScope
    LocalDateTime returningDate

    static constraints = {
        serialNumber nullable: false, validator: { serialNumber, instance ->
            def equipment = Equipment.findBySerialNumber(serialNumber)
            if (equipment) {
                instance.equipment = equipment
                return true
            }
            return 'serial.number.incorrect'
        }

        equipment nullable: true, validator: { equipment, instance ->
            if(equipment) {
                def borrowedEquipments = []
                def eventSupportEquipments = []
                if (equipment) {
                    borrowedEquipments = AssetBorrowing.withCriteria {
                        ge('borrowedDate', instance.borrowedDate)
                        le('returningDate', instance.returningDate)
                        equipments {
                            eq('id', equipment.id)
                        }
                    }

                    eventSupportEquipments = EventSupport.withCriteria {
                        ge('startTime', instance.borrowedDate)
                        le('endTime', instance.returningDate)
                        equipments {
                            eq('id', equipment.id)
                        }
                    }
                }

                def equipmentHasNotBeenBooked = borrowedEquipments.isEmpty() && eventSupportEquipments.isEmpty()
                def available = equipment.status == EquipmentStatus.AVAILABLE

                return equipmentHasNotBeenBooked && available ? true : 'equipment.not.available.within.those.days'
            }
            return true
        }
    }

    String getName() {
        if(equipment){
            return equipment.validate() ? equipment.name : 'not available'
        }
        return 'invalid serial'
    }

    Equipment getEquipment() {
        return equipment
    }

    String toString(){
        return equipment ? equipment.name : 'invalid serial'
    }
}
