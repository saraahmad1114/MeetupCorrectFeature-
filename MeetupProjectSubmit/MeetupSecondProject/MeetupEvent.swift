//
//  MeetupEvent.swift
//  MeetupSecondProject
//
//  Created by Flatiron School on 1/31/17.
//  Copyright © 2017 Flatiron School. All rights reserved.
//

import Foundation
import CoreData

class MeetupEvent{
    
    var eventName: String?
    var meetupGroupName: String?
    var eventDateAndTime: Double?
    var rsvpdYes: Int?
    var groupLatitude: Double?
    var groupLongitude: Double?
    
    
    //Designated initializer
    init(eventName: String, meetupGroupName: String, eventDateAndTime: Double, rsvpdYes: Int, eventLocationLatitude: Double, eventLocationLongitude: Double){
        self.eventName = eventName
        self.meetupGroupName = meetupGroupName
        self.eventDateAndTime = eventDateAndTime
        self.rsvpdYes = rsvpdYes
        self.groupLatitude = eventLocationLatitude
        self.groupLongitude = eventLocationLongitude
    }
 

    func saveToCoreData() {
        
        MeetupEventsDataStore.sharedInstance.saveMeetup(self)
    }
    
}

// MARK: - Core Data Extension
extension SavedMeetupEvent {
    
    func setup(with meetupEvent: MeetupEvent) {
        // TODO: Setup the rest of the properties here
        
       savedEventName = meetupEvent.eventName
       savedEventDateAndTime = meetupEvent.eventDateAndTime!
       savedMeetupGroupName = meetupEvent.meetupGroupName
       savedRsvpdYes = Int16(meetupEvent.rsvpdYes!)
        
    }
    
}
