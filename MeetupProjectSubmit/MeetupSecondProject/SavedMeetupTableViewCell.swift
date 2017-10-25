//
//  SavedMeetupTableViewCell.swift
//  MeetupSecondProject
//
//  Created by Flatiron School on 2/6/17.
//  Copyright © 2017 Flatiron School. All rights reserved.
//

import UIKit

class SavedMeetupTableViewCell: UITableViewCell {

    
    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var meetupGroupName: UILabel!
    @IBOutlet weak var eventDateAndTime: UILabel!
    @IBOutlet weak var rsvpdYes: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
