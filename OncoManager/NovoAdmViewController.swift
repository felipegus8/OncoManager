//
//  NovoAdmViewController.swift
//  OncoManager
//
//  Created by Gabrielle Brandenburg dos Anjos on 7/13/16.
//  Copyright © 2016 Felipe Viberti. All rights reserved.
//

import UIKit

class NovoAdmViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var nome: OMTextField!
    @IBOutlet weak var email: OMTextField!
    @IBOutlet weak var senha: OMTextField!
    @IBOutlet weak var confirmaSenha: OMTextField!
    var i = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        senha.secureTextEntry = true
        nome.delegate = self
        email.delegate = self
        senha.delegate = self
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(NovoAdmViewController.actOnNotificationSuccessCadastroAdmin), name: "notificationSuccessCadastroAdmin", object: nil)
         NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(NovoAdmViewController.actOnNotificationErrorCadastroAdmin), name: "notificationErrorCadastroAdmin", object: nil)
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closeModalPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool // called when 'return' key pressed. return NO to ignore.
    {
        self.view.endEditing(true)
        print(textField.placeholder)
        return false
    }

    @IBAction func cadastro(sender: OMButton) {
        if ((nome.text?.isEmpty == true) || (email.text?.isEmpty == true) || (senha.text?.isEmpty == true))
        {
            let alert=UIAlertController(title:"Erro", message: "Todos os campos são obrigatórios", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title:"Ok",style: UIAlertActionStyle.Default,handler: nil))
            self.presentViewController(alert,animated: true, completion: nil)
            i = 0

        }
        else{
            if nome.text?.isValidName == false
            {
                i=0
                let alert=UIAlertController(title:"Erro", message: "O nome tem que ter pelo menos 4 caracteres", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title:"Ok",style: UIAlertActionStyle.Default,handler: nil))
                self.presentViewController(alert,animated: true, completion: nil)
            }
            else
            {
            if isValidEmail(email.text!) == false{
                let alert=UIAlertController(title:"Erro", message: "Email Inválido", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title:"Ok",style: UIAlertActionStyle.Default,handler: nil))
                self.presentViewController(alert,animated: true, completion: nil)
                i = 0
            }
            else{
                if senha.text!.isValidPassword == false
                {
                    i = 0
                    let alert=UIAlertController(title:"Erro", message: "A senha tem que ter no mínimo 8 caracteres", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title:"Ok",style: UIAlertActionStyle.Default,handler: nil))
                    self.presentViewController(alert,animated: true, completion: nil)
                }
                else
                {
                if senha.text != confirmaSenha.text
                {
                    i = 0
                    let alert=UIAlertController(title:"Erro", message: "As senhas são diferentes", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title:"Ok",style: UIAlertActionStyle.Default,handler: nil))
                    self.presentViewController(alert,animated: true, completion: nil)
                }
                else{
                    
                    if i == 0
                    {
                        DaoCloudKit().addAdmin(Admin(email: email.text!, senha: senha.text!, nome: nome.text!))
                        i+=1
                    }
                }
                }
        }
        }
        }
    }
    override func viewWillAppear(animated: Bool) {
        i=0
    }
    func  actOnNotificationSuccessCadastroAdmin()
    {
        dispatch_async(dispatch_get_main_queue(),{
            self.dismissViewControllerAnimated(true, completion: nil)
        })
    }
    func actOnNotificationErrorCadastroAdmin()
    {
        i = 0
        let alert=UIAlertController(title:"Erro", message: "Email já está cadastrado", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title:"Ok",style: UIAlertActionStyle.Default,handler: nil))
        dispatch_async(dispatch_get_main_queue(),{
            self.presentViewController(alert,animated: true, completion: nil)
        })

    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
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
