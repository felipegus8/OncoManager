//
//  NovoMedicoViewController.swift
//  OncoManager
//
//  Created by Gabrielle Brandenburg dos Anjos on 7/21/16.
//  Copyright © 2016 Felipe Viberti. All rights reserved.
//

import UIKit

class NovoMedicoViewController: UIViewController, UITextFieldDelegate {
    
    var edit = false
    var i = 0

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var cadastrar: OMButton!
    @IBOutlet weak var nome: OMTextField!
    @IBOutlet weak var email: OMTextField!
    @IBOutlet weak var telefone: OMTextField!
    @IBOutlet weak var especialidade: OMTextField!
    @IBOutlet weak var crm: OMTextField!
    
    var medicoTeste:Medico!
    var medicoEditado:Medico!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var lastScrollViewOffset = CGPoint()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("did load")
        linkDelegate()
        configEditVC()
        crm.keyboardType = .NumberPad
        telefone.keyboardType = .NumberPad
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(NovoMedicoViewController.actOnNotificationSuccessAddMedico), name: "notificationSuccessCadastroMedico", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(NovoMedicoViewController.actOnNotificationErrorAddMedico), name: "notificationErrorCadastroMedico", object: nil)
         NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(NovoMedicoViewController.actOnNotificationSuccessEditMedico), name: "notificationSuccessEditMedico", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(NovoPacienteViewController.keyboardWillShow(_:)), name:UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(NovoPacienteViewController.keyboardWillHide(_:)), name:UIKeyboardWillHideNotification, object: nil);
 
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func keyboardWillShow(notification: NSNotification) {
        lastScrollViewOffset = scrollView.contentOffset
        
        let userInfo: NSDictionary = notification.userInfo!
        let keyboardSize = userInfo.objectForKey(UIKeyboardFrameBeginUserInfoKey)!.CGRectValue.size
        let keyboardFrame = userInfo.objectForKey(UIKeyboardFrameBeginUserInfoKey)!.CGRectValue
        let contentInsets = UIEdgeInsetsMake(0, 0, keyboardSize.height, 0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
        
        let viewRect = keyboardFrame
        
        let textField = self.view.currentFirstResponder()
        let responderRect = textField?.convertRectCorrectly(textField!.frame, toView: self.view)
        
        //viewRect.size.height -= keyboardSize.height
        
        if CGRectContainsPoint(viewRect, responderRect!.origin) {
            print(responderRect!.origin.y)
            print(keyboardSize.height)
            let scrollPoint = CGPointMake(0, responderRect!.origin.y - keyboardSize.height)
            scrollView.setContentOffset(scrollPoint, animated: true)
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        scrollView.contentOffset = lastScrollViewOffset
        scrollView.contentInset = UIEdgeInsetsZero
        scrollView.scrollIndicatorInsets = UIEdgeInsetsZero
    }
    
    func configEditVC() {
        if edit {
            titleLabel.text = "EDITAR MÉDICO"
            cadastrar.setTitle("Alterar", forState: .Normal)
            
            nome.text = medicos[i].nome
            email.text = medicos[i].email
            especialidade.text = medicos[i].especialidade
            crm.text = String(Int(medicos[i].crm))
            
            if let tel = medicos[i].telefone {
            telefone.text = String(Int(tel))
            } else {
            telefone.text = ""
            }
        }
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
        index = 2
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //MARK: armazenar dados no iCloud
    @IBAction func cadastrarPressed(sender: UIButton) {
        index = 2
        if !edit{
        medicoTeste = Medico(nome: nome.text!, email: email.text!, crm: Double(crm.text!)!, especialidade: especialidade.text!, telefone: Double(telefone.text!))
        DaoCloudKit().addMedico(medicoTeste)
        }
        else{
            medicoEditado = Medico(nome: nome.text!, email: email.text!, crm: Double(crm.text!)!, especialidade: especialidade.text!, telefone: Double(telefone.text!))
            DaoCloudKit().editMedico(medicos[i], medicoNew: medicoEditado)
        }
    }
    
    func actOnNotificationSuccessAddMedico()
    {
        medicos.append(medicoTeste)
         dispatch_async(dispatch_get_main_queue(),{
        self.dismissViewControllerAnimated(true, completion: nil)
        })
    }
    func actOnNotificationErrorAddMedico()
    {
        let alert=UIAlertController(title:"Acabou", message: "Fim da edição", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title:"Ok",style: UIAlertActionStyle.Default,handler: nil))
        dispatch_async(dispatch_get_main_queue(),{
        self.presentViewController(alert,animated: true, completion: nil)
        })
    }
    func actOnNotificationSuccessEditMedico()
    {
        dispatch_async(dispatch_get_main_queue(),{
            self.dismissViewControllerAnimated(true, completion: nil)
        })

    }
    
    override func viewWillDisappear(animated: Bool) {
        edit = false
        print(edit)
    }
}
