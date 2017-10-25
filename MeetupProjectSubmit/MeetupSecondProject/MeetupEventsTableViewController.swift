//
//  MeetupEventsTableViewController.swift
//  MeetupSecondProject
//
//  Created by Flatiron School on 2/2/17.
//  Copyright © 2017 Flatiron School. All rights reserved.
//

import UIKit

class MeetupEventsTableViewController: UITableViewController {
    
    var meetupEventZipcode: String?
    var meetupEventTopic: String?
    let store = MeetupEventsDataStore.sharedInstance

    override func viewDidLoad() {
        super.viewDidLoad()

        guard
            let unwrappedMeetupEventZipcode = self.meetupEventZipcode,
            let unwrappedEventTopic = self.meetupEventTopic
            else {
                print("zipcode did not unwrap"); return
        }

        self.store.getMeetupEvents(zipCode: unwrappedMeetupEventZipcode, topic: unwrappedEventTopic) { (meetupEventArray) in
            print("************************")
            print(meetupEventArray)
            print("************************")
            OperationQueue.main.addOperation {
                self.tableView.reloadData()
            }
        }
    
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.store.meetupEvents.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "meetupEventCell", for: indexPath) as! MeetupEventsDisplayTableViewCell
        
        if let nameOfEvent = self.store.meetupEvents[indexPath.row].eventName{
            cell.nameOfEventLabel.text = nameOfEvent
        }
        
        if let nameOfMeetupGroup = self.store.meetupEvents[indexPath.row].meetupGroupName{
            cell.nameOfMeetupGroup.text = nameOfMeetupGroup
        }
        
        if let eventTiming = self.store.meetupEvents[indexPath.row].eventDateAndTime{
            let date = NSDate(timeIntervalSince1970: eventTiming/1000)
            cell.eventTimeAndDateLabel.text = String(describing: date)
        }
        
        if let rsvpdAmount = self.store.meetupEvents[indexPath.row].rsvpdYes{
            cell.rsvpdLabel.text = String(rsvpdAmount)
        }
        return cell
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "meetupEventDetails"{
            if let destinationVC = segue.destination as? DetailMeetupEventViewController{
                let path = self.tableView.indexPath(for: sender as! UITableViewCell)
                destinationVC.singleMeetupEvent = self.store.meetupEvents[(path?.row)!]
            }
        }
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
