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

        linkDelegate()
        crm.keyboardType = .NumberPad
        telefone.keyboardType = .NumberPad
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(NovoMedicoViewController.actOnNotificationSuccessAddMedico), name: "notificationSuccessCadastroMedico", object: nil)
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
    
    //MARK: funcoes para desligar o teclado-------------------
    //desliga pela tecla return
    func textFieldShouldReturn(textField: UITextField) -> Bool // called when 'return' key pressed. return NO to ignore.
    {
        self.view.endEditing(true)
        print(textField.placeholder)
        return false
    }
    //desliga ao tocar fora da scroll view
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
            scrollView.endEditing(true)
            view.endEditing(true)
    }
    //desliga ao tocar na scroll view
    @IBAction func stopEditing(sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    // -------------------------------------------------------
    
    //fecha tela no 'x'
    @IBAction func closeModalPressed(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //MARK: armazenar dados no iCloud
    @IBAction func cadastrarPressed(sender: UIButton) {
        DaoCloudKit().addMedico(Medico(nome: nome.text!, email: email.text!, crm: Double(crm.text!)!, especialidade: especialidade.text!, telefone: Double(telefone.text!)))
    }
    
    func actOnNotificationSuccessAddMedico()
    {
         dispatch_async(dispatch_get_main_queue(),{
        self.dismissViewControllerAnimated(true, completion: nil)
        })
    }
}
