//
//  DetailMeetupEventViewController.swift
//  MeetupSecondProject
//
//  Created by Flatiron School on 2/2/17.
//  Copyright © 2017 Flatiron School. All rights reserved.
//

import UIKit

class DetailMeetupEventViewController: UIViewController {
    
    @IBOutlet weak var nameOfEventLabel: UILabel!
    @IBOutlet weak var eventTimeAndDateLabel: UILabel!
    @IBOutlet weak var nameOfMeetupGroupLabel: UILabel!
    @IBOutlet weak var rsvpdLabel: UILabel!
    
    var singleMeetupEvent: MeetupEvent?
    let store = MeetupEventsDataStore.sharedInstance

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let unwrappedSingleMeetupEvent = self.singleMeetupEvent else {
            print("singleMeetupEvent did not unwrap"); return}
        
        if let nameOfEvent = unwrappedSingleMeetupEvent.eventName{
        self.nameOfEventLabel.text = nameOfEvent
        }
        
        if let eventTiming = unwrappedSingleMeetupEvent.eventDateAndTime{
            self.eventTimeAndDateLabel.text = String(describing: eventTiming)
        }
        
        if let meetupGroupName = unwrappedSingleMeetupEvent.meetupGroupName{
            self.nameOfMeetupGroupLabel.text = meetupGroupName
        }
        
        if let rsvpdAmount = unwrappedSingleMeetupEvent.rsvpdYes{
            self.rsvpdLabel.text = String(describing: rsvpdAmount)
        }
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func savedEventButtonTapped(_ sender: Any) {
        singleMeetupEvent?.saveToCoreData()
        self.store.fetchCoreData()
        
        print("Meetup Event has been saved")
        print(self.store.favoriteMeetupEvents)
        
        let alert = UIAlertController(title: "SAVED MEETUP EVENT", message: "You have saved this Meetup Event", preferredStyle: UIAlertControllerStyle.alert)
        //add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        //show the alert
        self.present(alert, animated: true, completion: nil)
        
        
    }
    

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
