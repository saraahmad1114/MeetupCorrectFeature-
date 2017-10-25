//
//  SearchViewController.swift
//  MeetupSecondProject
//
//  Created by Flatiron School on 2/2/17.
//  Copyright © 2017 Flatiron School. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    var zipCodeTextField: UITextField!
    var topicTextField: UITextField!

    @IBOutlet weak var findMeetupEventsButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.topItem?.title = "FIND NEARBY MEETUP EVENTS"
        self.navigationController?.navigationBar.barTintColor = UIColor.red
        
        //zipCodeTextField
        self.zipCodeTextField = UITextField(frame: CGRect(x: 100.00, y: 100.00, width: 500.00, height: 30.00))
        self.zipCodeTextField.textColor = UIColor.black
        self.zipCodeTextField.center = self.view.center
        self.zipCodeTextField.placeholder = "ENTER ZIPCODE"
        self.zipCodeTextField.backgroundColor = UIColor.red
        self.zipCodeTextField.borderStyle = UITextBorderStyle.roundedRect
        self.zipCodeTextField.clearsOnBeginEditing = true
        self.view.addSubview(self.zipCodeTextField)
        
        //constraints for zipCodeTextField
        self.zipCodeTextField.translatesAutoresizingMaskIntoConstraints = false
        self.zipCodeTextField.topAnchor.constraint(equalTo: self.view.topAnchor, constant: UIScreen.main.bounds.height * 0.20).isActive = true
        self.zipCodeTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        //creation of a button
        let zipButton: UIButton = UIButton(frame: CGRect(x: 100.00, y: 100.00, width: 300.00, height: 30.00))
        zipButton.backgroundColor = UIColor.red
        zipButton.setTitle("FIND EVENTS WITH ZIPCODE", for: UIControlState.normal)
        zipButton.addTarget(self, action: #selector(validZipcode(sender:)), for: UIControlEvents.touchUpInside)
        self.view.addSubview(zipButton)
        
        //constraints on the button
        zipButton.translatesAutoresizingMaskIntoConstraints = false
        zipButton.topAnchor.constraint(equalTo: self.zipCodeTextField.bottomAnchor, constant: UIScreen.main.bounds.height * 0.04).isActive = true
        zipButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        self.topicTextField = UITextField(frame: CGRect(x: 100.00, y: 100.00, width: 500.00, height: 30.00))
        self.topicTextField.textColor = UIColor.black
        self.topicTextField.center = self.view.center
        self.topicTextField.placeholder = "ENTER MEETUP TOPIC"
        self.topicTextField.backgroundColor = UIColor.red
        self.topicTextField.borderStyle = UITextBorderStyle.roundedRect
        self.topicTextField.clearsOnBeginEditing = true
        self.view.addSubview(self.topicTextField)
        
        self.topicTextField.translatesAutoresizingMaskIntoConstraints = false
        self.topicTextField.topAnchor.constraint(equalTo: zipButton.bottomAnchor, constant: UIScreen.main.bounds.height * 0.04).isActive = true
        self.topicTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        self.findMeetupEventsButton.backgroundColor = UIColor.red
        
        
        self.findMeetupEventsButton.translatesAutoresizingMaskIntoConstraints = false
        self.findMeetupEventsButton.topAnchor.constraint(equalTo: self.topicTextField.bottomAnchor, constant: UIScreen.main.bounds.height * 0.05).isActive = true
        self.findMeetupEventsButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
      
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func validZipcode(sender: UIButton!) {
        //zipcode Button stuff
        if let zipcodeText = self.zipCodeTextField.text {
            if isZipCodeValid(text: zipcodeText) == true {
                print("Entered valid zipcode")
            }
            else{
                //create the alert
                let alert = UIAlertController(title: "Invalid Zipcode", message: "Enter Valid Zipcode", preferredStyle: UIAlertControllerStyle.alert)
                //add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                //show the alert
                self.present(alert, animated: true, completion: nil)
            }
            
        }
    }

    func isZipCodeValid(text: String) -> Bool {
        let zipCodeTestPredicate = NSPredicate (format:"SELF MATCHES %@","(^[0-9]{5}(-[0-9]{4})?$)")
        return zipCodeTestPredicate.evaluate(with: zipCodeTextField.text)
    }
    
    @IBAction func findMeetupButtonTapped(_ sender: Any) {
        
        print("going to display Tableview or search results")
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "searchEventsSegue" {
            if let destinationVC = segue.destination as? MeetupEventsTableViewController {
                if let zipcodeTextFieldContent = self.zipCodeTextField.text{
                destinationVC.meetupEventZipcode = zipcodeTextFieldContent
                    print("zipcode passed")
                }
                if let topicTextFieldContent = self.topicTextField.text{
                    destinationVC.meetupEventTopic = topicTextFieldContent
                    print("topic passed")
                }
            }
        }
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
