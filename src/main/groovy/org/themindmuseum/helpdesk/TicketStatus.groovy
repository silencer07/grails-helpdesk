package org.themindmuseum.helpdesk

/**
 * Created by aldrin on 10/10/15.
 */
enum TicketStatus {
    OPEN,
    ON_HOLD,
    RESOLVED,

    static def getUnresolvedStatuses(){
        return [OPEN, ON_HOLD]
    }
}