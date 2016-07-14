//
//  LoginViewController.swift
//  OncoManager
//
//  Created by Gabrielle Brandenburg dos Anjos on 7/13/16.
//  Copyright © 2016 Felipe Viberti. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

  
    @IBOutlet weak var signIn: OMButton!
    
    @IBOutlet weak var emailTxtField: OMTextField!
    @IBOutlet weak var senhaTxtField: OMTextField!
    
    @IBOutlet weak var novaConta: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func signInPressed(sender: AnyObject) {
        performSegueWithIdentifier("goToHome", sender: sender)
    }
    
    @IBAction func novaContaPressed(sender: AnyObject) {
        performSegueWithIdentifier("goToNewAdm", sender: sender)
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
