//
//  eventTableViewCell.swift
//  doodlebluetask
//
//  Created by apple on 15/12/1942 Saka.
//

import UIKit

class eventTableViewCell: UITableViewCell {

    //MARK: OUTLET
    @IBOutlet weak var eventtime: UILabel!
    @IBOutlet weak var eventdate: UILabel!
    @IBOutlet weak var eventtitle: UILabel!



    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
