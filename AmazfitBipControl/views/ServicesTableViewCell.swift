//
//  ServicesTableViewCell.swift
//  AmazfitBipControl
//
//  Created by Круцких Олег on 18.12.2017.
//  Copyright © 2017 Круцких Олег. All rights reserved.
//

import UIKit
import CoreBluetooth

class ServicesTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var uuid: UILabel!
    @IBOutlet weak var isActive: UISwitch!
    var service: CBService?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        isActive.isEnabled = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        //self.isActive.setOn(!self.isActive.isOn, animated: true)
    }

}
