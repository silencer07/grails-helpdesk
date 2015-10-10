package org.themindmuseum.helpdesk.domain

import java.time.LocalDateTime

class AssetBorrowing extends SupportTicket{

    Set<Equipment> equipments
    LocalDateTime borrowedDate
    LocalDateTime returningDate
    LocalDateTime returnedDate


    static constraints = {
        //TODO borrowedDate >= returningDate
        equipments nullable: false, minSize: 1
    }

    static hasMany = [equipments : Equipment]
}
