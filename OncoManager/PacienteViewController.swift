//
//  PacienteViewController.swift
//  OncoManager
//
//  Created by Gabrielle Brandenburg dos Anjos on 7/13/16.
//  Copyright © 2016 Felipe Viberti. All rights reserved.
//

import UIKit

class PacienteViewController: UIViewController {
    
    @IBOutlet weak var timeView: UIView!
    
    var pacienteName = "Paciente"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = pacienteName // recebe o nome da tableView pelo segue
        timeView.layer.shadowOpacity = 0.2
        timeView.layer.shadowRadius = 0.2
        timeView.layer.shadowOffset = CGSize(width: 0.0,height: 1.0)
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
