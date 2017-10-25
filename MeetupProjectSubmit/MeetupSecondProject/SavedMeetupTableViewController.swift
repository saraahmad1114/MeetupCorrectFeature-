//
//  SavedMeetupTableViewController.swift
//  MeetupSecondProject
//
//  Created by Flatiron School on 2/6/17.
//  Copyright © 2017 Flatiron School. All rights reserved.
//

import UIKit

class SavedMeetupTableViewController: UITableViewController {
    
    let store = MeetupEventsDataStore.sharedInstance

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.store.fetchCoreData()
        OperationQueue.main.addOperation {
            self.tableView.reloadData()
        }
        
        print("************************************")
        print(self.store.favoriteMeetupEvents)
        print("************************************")
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
        return self.store.favoriteMeetupEvents.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "savedCell", for: indexPath) as! SavedMeetupTableViewCell

        if let nameOfEvent = self.store.favoriteMeetupEvents[indexPath.row].savedEventName{
            cell.eventName.text = nameOfEvent
        }
        
        if let nameOfMeetupGroup = self.store.favoriteMeetupEvents[indexPath.row].savedMeetupGroupName{
            cell.meetupGroupName.text = nameOfMeetupGroup
        }
        
        cell.eventDateAndTime.text = String(self.store.favoriteMeetupEvents[indexPath.row].savedEventDateAndTime)
        
        cell.rsvpdYes.text = String(self.store.favoriteMeetupEvents[indexPath.row].savedRsvpdYes)
       
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        let alert = UIAlertController(title: "DELETED MEETUP EVENT", message: "You have deleted this Meetup Event", preferredStyle: UIAlertControllerStyle.alert)
        //add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        //show the alert
        self.present(alert, animated: true, completion: nil)
        
        if editingStyle == UITableViewCellEditingStyle.delete
        {
            CoreDataStack.shared.context.delete(self.store.favoriteMeetupEvents[indexPath.row])
            self.store.fetchCoreData()
            CoreDataStack.shared.saveContext()
            self.tableView.reloadData()
            
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
