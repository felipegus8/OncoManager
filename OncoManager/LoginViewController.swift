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

    var i = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        let dataRealizado = formatter.dateFromString("2016/06/25 17:00")
        let dataMarcado = formatter.dateFromString("2016/06/19 15:00")
        
        let testeExame =  Exame(tipoProcedimento: "Consulta",cpf:16798089766,codigo: 5, nome: "TesteConsulta", medico: "TestandoConsulta", local: "Quinta",dataMarcado:dataMarcado! ,dataRealizado:dataRealizado!, aprovado: 0, realizado: 1)
      /*  let testePaciente = Paciente(cpf: 16798089766, nome: "Teste", bairro: "Magé", bairroPrefere: "Niteroi", dataNasc: "26-09-1962", email: "qualquer", telefoneFixo: 2345980135, celular: 346725789, peso: 78, altura: 1.70, alergia: 0, marcapasso: 0, clipesCirurgico: 0, operado: 0, tipoOperacao: nil, cadeirante: 0, diabetico: 1, hipertenso: 0, convenio: "Assim", tipoPlano: "Ruim", matriculaPlano: "12345",claustrofobico:0)
 */
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
    
    override func viewWillAppear(animated: Bool) {
        i=0
    }
    @IBAction func signInPressed(sender: AnyObject) {
        if ((emailTxtField.text?.isEmpty == true) || (senhaTxtField.text?.isEmpty == true))
        {
            let alert=UIAlertController(title:"Erro", message: "Todos os campos são obrigatórios", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title:"Ok",style: UIAlertActionStyle.Default,handler: nil))
            self.presentViewController(alert,animated: true, completion: nil)
        }
        else{
        if isValidEmail(emailTxtField.text!) == false{
            let alert=UIAlertController(title:"Erro", message: "Email Inválido", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title:"Ok",style: UIAlertActionStyle.Default,handler: nil))
            self.presentViewController(alert,animated: true, completion: nil)
        }
        else{
        if i==0
        {
        i+=1
        DaoCloudKit().fetchAdminByEmail(emailTxtField.text, senha: senhaTxtField.text)
        }
        }
        }
    }
    
    @IBAction func novaContaPressed(sender: AnyObject) {
        performSegueWithIdentifier("goToNewAdm", sender: sender)
    }
    func actOnNotificationSuccessLogin()
    {
        if i == 1
        {
        i+=1
        DaoCloudKit().fetchPacientes()
        }
        
    }
    func actOnNotificationSuccessPacientes()
    {
        if i==2
        {
        i+=1
        DaoCloudKit().fetchExames()
        }
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
