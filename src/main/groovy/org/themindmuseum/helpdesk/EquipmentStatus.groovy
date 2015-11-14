package org.themindmuseum.helpdesk

/**
 * Created by aldrin on 10/10/15.
 */
enum EquipmentStatus {
    AVAILABLE,
    ISSUED,
    BORROWED,
    ON_HOLD,
    DISPOSED,
    MISSING,
    WITH_DAMAGE

    static def statusesForSupportTickets(){
        return [
            ON_HOLD,
            DISPOSED,
            MISSING,
            WITH_DAMAGE
        ]
    }
}
