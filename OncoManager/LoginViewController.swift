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
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        let dataRealizado = formatter.dateFromString("2016/06/23 17:00")
        let dataMarcado = formatter.dateFromString("2016/06/20 15:00")
        
        let testeExame =  Exame(cpf:16798089766,codigo: 8, nome: "TesteExame", medico: "Testando", local: "Copa",dataMarcado:dataMarcado! ,dataRealizado:dataRealizado!, aprovado: 0, realizado: 1)
        let testePaciente = Paciente(cpf: 16798089766, nome: "Teste", bairro: "Magé", bairroPrefere: "Niteroi", dataNasc: "26-09-1962", email: "qualquer", telefoneFixo: 2345980135, celular: 346725789, peso: 78, altura: 1.70, alergia: 0, marcapasso: 0, clipesCirurgico: 0, operado: 0, tipoOperacao: nil, cadeirante: 0, diabetico: 1, hipertenso: 0, convenio: "Assim", tipoPlano: "Ruim", matriculaPlano: "12345",claustrofobico:0)
        senhaTxtField.secureTextEntry = true
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(LoginViewController.actOnNotificationSuccessLogin), name: "notificationSuccessLogin", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(LoginViewController.actOnNotificationSuccessPacientes), name: "notificationSuccessPacientes", object: nil)
         NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(LoginViewController.actOnNotificationSuccessExames), name: "notificationSuccessExames", object: nil)
        DaoCloudKit().addExame(testeExame)
               // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func signInPressed(sender: AnyObject) {
        
        DaoCloudKit().fetchAdminByEmail(emailTxtField.text, senha: senhaTxtField.text)
    }
    
    @IBAction func novaContaPressed(sender: AnyObject) {
        performSegueWithIdentifier("goToNewAdm", sender: sender)
    }
    func actOnNotificationSuccessLogin()
    {
        DaoCloudKit().fetchPacientes()
        
    }
    func actOnNotificationSuccessPacientes()
    {
        DaoCloudKit().fetchExames()
    }
    func actOnNotificationSuccessExames()
    {
        dispatch_async(dispatch_get_main_queue(),{
            self.performSegueWithIdentifier("goToHome", sender: self)
        })
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //super.touchesBegan(touches, withEvent: event)
        
        view.endEditing(true)
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
