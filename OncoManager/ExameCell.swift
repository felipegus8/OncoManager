//
//  ExameCell.swift
//  OncoManager
//
//  Created by Gabrielle Brandenburg dos Anjos on 7/26/16.
//  Copyright © 2016 Felipe Viberti. All rights reserved.
//
import UIKit

class ExameCell: UITableViewCell {

    @IBOutlet weak var nome: UILabel!
    @IBOutlet weak var editar: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func editarPresed(sender: UIButton) {
        print("editar exame")
    }
}
