//
//  MedicoCell.swift
//  OncoManager
//
//  Created by Gabrielle Brandenburg dos Anjos on 7/26/16.
//  Copyright © 2016 Felipe Viberti. All rights reserved.
//

import UIKit

class MedicoCell: UITableViewCell {

    @IBOutlet weak var nomeMedico: UILabel!
    @IBOutlet weak var especialidade: UILabel!
    @IBOutlet weak var email: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func editarPressed(sender: UIButton) {
        
    }

}