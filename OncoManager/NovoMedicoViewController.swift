//
//  NovoMedicoViewController.swift
//  OncoManager
//
//  Created by Gabrielle Brandenburg dos Anjos on 7/21/16.
//  Copyright © 2016 Felipe Viberti. All rights reserved.
//

import UIKit

class NovoMedicoViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nome: OMTextField!
    @IBOutlet weak var email: OMTextField!
    @IBOutlet weak var telefone: OMTextField!
    @IBOutlet weak var especialidade: OMTextField!
    @IBOutlet weak var crm: OMTextField!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func linkDelegate(){
        nome.delegate = self
        email.delegate = self
        telefone.delegate = self
        especialidade.delegate = self
        crm.delegate = self
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool // called when 'return' key pressed. return NO to ignore.
    {
        //textField.resign
        self.view.endEditing(true)
        return true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        let touch = touches.first!
        
//        let vieW = touch.view
//        print(vieW!.tag)
//        //finaliza a edição quando o usuario toca fora da scrollView
//        if(vieW?.tag != 8){
        
            scrollView.endEditing(true)
            view.endEditing(true)
    }
    
    @IBAction func stopEditing(sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }

    
    @IBAction func closeModalPressed(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //MARK: armazenar dados no iCloud
    @IBAction func cadastrarPressed(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}
