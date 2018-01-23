//
//  DoctorTableViewCell.swift
//  TASK2
//
//  Created by Macbook on 1/20/18.
//  Copyright © 2018 Macbook. All rights reserved.
//

import UIKit

class DoctorTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet var imageViewDoctor: UIImageView!
    @IBOutlet var doctorAdressLbl: UILabel!
    @IBOutlet var nameLbl: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
