//
//  MeetupEventsDisplayTableViewCell.swift
//  MeetupSecondProject
//
//  Created by Flatiron School on 2/2/17.
//  Copyright © 2017 Flatiron School. All rights reserved.
//

import UIKit

class MeetupEventsDisplayTableViewCell: UITableViewCell {

    @IBOutlet weak var nameOfEventLabel: UILabel!
    @IBOutlet weak var eventTimeAndDateLabel: UILabel!
    @IBOutlet weak var nameOfMeetupGroup: UILabel!
    @IBOutlet weak var rsvpdLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
