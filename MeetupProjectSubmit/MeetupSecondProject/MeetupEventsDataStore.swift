//
//  MeetupEventsDataStore.swift
//  MeetupSecondProject
//
//  Created by Flatiron School on 1/31/17.
//  Copyright © 2017 Flatiron School. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class MeetupEventsDataStore{

    
    static let sharedInstance = MeetupEventsDataStore()
    private init(){}
    
    var meetupEvents: [MeetupEvent] = []

    var favoriteMeetupEvents: [SavedMeetupEvent] = []
    
    
    //Method to be used to fetch results for the tableview
    func fetchCoreData() {
        
        do {
            
            let request = NSFetchRequest<SavedMeetupEvent>(entityName: "SavedMeetupEvent")
            
            self.favoriteMeetupEvents = try CoreDataStack.shared.context.fetch(request)
                } catch {
            print(error.localizedDescription)
        }
    }
    
   

    //Method to be called in the button to save the meetupEvent 
    func saveMeetup(_ meetup: MeetupEvent) {
        
        let eventSaved = SavedMeetupEvent(context: CoreDataStack.shared.context)
        eventSaved.setup(with: meetup)
        
        try? CoreDataStack.shared.context.save()
    }
    
    func getMeetupEvents (zipCode: String, topic: String, completion:@escaping ([MeetupEvent]) -> ()) {
    
        MeetupAPIClient.getMeetupEvents(zipCode: zipCode, topic: topic) { (jsonResponseArray) in
            
            for singleDictionary in jsonResponseArray {
            
                guard let unwrappedSingleDictionary = singleDictionary as? [String:Any] else {print("singleDictionary did not unwrap"); return}
                
                guard let nameOfEvent = unwrappedSingleDictionary["name"] as? String else {
                    print("nameOfEvent did not unwrap"); return}
                
                guard let timeOfEvent = unwrappedSingleDictionary["time"] as? Double else {
                    print("timeOfEvent did not unwrap"); return}
                
                guard let rsvpdYesOfEvent = unwrappedSingleDictionary["yes_rsvp_count"] as? Int else{ print("rsvpdYesOfEvent did not unwrap"); return}
                
                guard let meetupGroupInfoDictionary = unwrappedSingleDictionary["group"] as? [String: Any] else {print("meetupGroupInfoDictionary did not unwrap"); return}
                
                guard let meetupGroupName = meetupGroupInfoDictionary["name"] as? String else{
                    print("meetupGroupName did not unwrap"); return}
                
                guard let meetupGroupLng = meetupGroupInfoDictionary["group_lon"] as? Double else {
                    print("meetupGroupLng did not unwrap"); return}
                
                guard let meetupGroupLat = meetupGroupInfoDictionary["group_lat"] as? Double else {
                    print("meetupGroupLat did not unwrap"); return}
            
             let singleMeetupEventObject = MeetupEvent.init(eventName: nameOfEvent, meetupGroupName: meetupGroupName, eventDateAndTime: timeOfEvent, rsvpdYes: rsvpdYesOfEvent, eventLocationLatitude: meetupGroupLat, eventLocationLongitude: meetupGroupLng)
                
                print("*******************************************************")
                print("eventName: \(singleMeetupEventObject.eventName)")
                print("meetupGroupName: \(singleMeetupEventObject.meetupGroupName)")
                print("meetupEventDataAndTime: \(singleMeetupEventObject.eventDateAndTime)")
                print("meetupRSVPDYES: \(singleMeetupEventObject.rsvpdYes)")
                print("meetupGroupLat: \(singleMeetupEventObject.groupLatitude)")
                print("meetupGroupLng: \(singleMeetupEventObject.groupLongitude)")
                print("*******************************************************")
                
                self.meetupEvents.append(singleMeetupEventObject)
                print(self.meetupEvents.count)
            }
            completion(self.meetupEvents)
        }
    }



}
