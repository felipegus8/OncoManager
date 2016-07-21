//
//  NovoExameViewController.swift
//  OncoManager
//
//  Created by Gabrielle Brandenburg dos Anjos on 7/21/16.
//  Copyright © 2016 Felipe Viberti. All rights reserved.
//

import UIKit

class NovoExameViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nomeExame: OMTextField!
    var nomeExameNovo:NomeExame!
    override func viewDidLoad() {
        super.viewDidLoad()

        nomeExame.delegate = self
          NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(NovoExameViewController.actOnNotificationSuccessAddExame), name: "notificationSuccessCadastroNovoExame", object: nil)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //MARK: funcoes para desligar o teclado-------------------
    //desliga pela tecla return
    func textFieldShouldReturn(textField: UITextField) -> Bool // called when 'return' key pressed. return NO to ignore.
    {
        self.view.endEditing(true)
        print(textField.placeholder)
        return false
    }
    //desliga ao tocar fora do textfield
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
    }
    // -------------------------------------------------------

    //fecha tela no 'x'
    @IBAction func closeModalPressed(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //MARK: armazenar dados no iCloud
    @IBAction func cadastrarPressed(sender: UIButton) {
        nomeExameNovo = NomeExame(nome: nomeExame.text!)
        DaoCloudKit().addNomeExame(nomeExameNovo)
       
    }
    func actOnNotificationSuccessAddExame()
    {
        nomeExames.append(nomeExameNovo)
        dispatch_async(dispatch_get_main_queue(),{
         self.dismissViewControllerAnimated(true, completion: nil)
        })
    }
}
