//
//  LoginViewController.swift
//  OncoManager
//
//  Created by Gabrielle Brandenburg dos Anjos on 7/13/16.
//  Copyright © 2016 Felipe Viberti. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var activity: UIActivityIndicatorView!
    @IBOutlet weak var signIn: OMButton!
    @IBOutlet weak var emailTxtField: OMTextField!
    @IBOutlet weak var senhaTxtField: OMTextField!
    @IBOutlet weak var novaConta: UIButton!

    var i = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "dd-MM-yyyy HH:mm"
        formatter.locale =  NSLocale(localeIdentifier: "pt_BR")
     //  let dataRealizado = formatter.dateFromString("01-03-2016 17:00")
       // let dataMarcado = formatter.dateFromString("01-02-2016 15:00")
        
     /*   let testeExame =  Exame(tipoProcedimento: "Exame",cpf:16798089766,codigo: 700, nome: "Raio X", medico: "TestandoExame", local: "Copa", dataMarcado:dataMarcado! ,dataRealizado:dataRealizado!, realizado: 1)
        let testePaciente = Paciente(cpf: 1893607393, nome: "Teste", bairro: "Magé", bairroPrefere: "Niteroi", dataNasc: "26-09-1962", email: "qualquer", telefoneFixo: 2345980135, celular: 346725789, peso: 78, altura: 1.70, alergia: 0, marcapasso: 0, clipesCirurgico: 0, operado: 0, tipoOperacao: nil, cadeirante: 0, diabetico: 1, hipertenso: 0, convenio: "Assim", tipoPlano: "Ruim", matriculaPlano: "12345",claustrofobico:0)
 */
        senhaTxtField.secureTextEntry = true
        addObservers()
        emailTxtField.delegate = self
        senhaTxtField.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func addObservers()
    {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(LoginViewController.actOnNotificationSuccessLogin), name: "notificationSuccessLogin", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(LoginViewController.actOnNotificationSuccessPacientes), name: "notificationSuccessPacientes", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(LoginViewController.actOnNotificationSuccessExames), name: "notificationSuccessExames", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(LoginViewController.actOnNotificationErrorEmail), name:
            "notificationErrorEmail", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(LoginViewController.actOnNotificationErrorSenha), name:
            "notificationErrorPassword", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(LoginViewController.actOnNotificationSuccessNomeExames), name: "notificationSuccessNomeExames", object: nil)

        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(LoginViewController.actOnNotificationSuccessMedicos), name: "notificationSuccessMedicos", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(LoginViewController.actOnNotificationErrorInternet), name:
            "notificationErrorInternet", object: nil)
        


    }
    func textFieldShouldReturn(textField: UITextField) -> Bool // called when 'return' key pressed. return NO to ignore.
    {
        self.view.endEditing(true)
        print(textField.placeholder)
        return false
    }

    override func viewWillAppear(animated: Bool) {
        i=0
    }
    @IBAction func signInPressed(sender: AnyObject) {
        activity.startAnimating()
        if DaoCloudKit().cloudAvailable() == true
        {
            if ((emailTxtField.text?.isEmpty == true) || (senhaTxtField.text?.isEmpty == true))
            {
                i = 0
                let alert=UIAlertController(title:"Erro", message: "Todos os campos são obrigatórios", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title:"Ok",style: UIAlertActionStyle.Default,handler: nil))
                self.presentViewController(alert,animated: true, completion: nil)
            }
            else{
                if isValidEmail(emailTxtField.text!) == false{
                    i = 0
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
        else{
            let alert=UIAlertController(title:"Erro", message: "Você não está logado no iCloud", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title:"Ok",style: UIAlertActionStyle.Default,handler: nil))
            self.presentViewController(alert,animated: true, completion: nil)
        }
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
        DaoCloudKit().fetchNomeExames()
        
    }
    func actOnNotificationSuccessNomeExames()
    {
         DaoCloudKit().fetchMedicos()
    }
    func actOnNotificationSuccessMedicos()
    {
        activity.stopAnimating()
        dispatch_async(dispatch_get_main_queue(),{
            self.performSegueWithIdentifier("goToHome", sender: self)
        })
    }
    func actOnNotificationErrorEmail()
    {
        i = 0
        print("Entrou na funcao")
        let alert=UIAlertController(title:"Erro", message: "Email não cadastrado", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title:"Ok",style: UIAlertActionStyle.Default,handler: nil))
        dispatch_async(dispatch_get_main_queue(),{
        self.presentViewController(alert,animated: true, completion: nil)
        })
    }
    
    func actOnNotificationErrorSenha()
    {
        i = 0
        let alert=UIAlertController(title:"Erro", message: "Senha Incorreta", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title:"Ok",style: UIAlertActionStyle.Default,handler: nil))
        dispatch_async(dispatch_get_main_queue(),{
        self.presentViewController(alert,animated: true, completion: nil)
        })
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //super.touchesBegan(touches, withEvent: event)
        
        view.endEditing(true)
    }
    
    func actOnNotificationErrorInternet()
    {
        activity.stopAnimating()
        let alert=UIAlertController(title:"Erro", message: "Você não está conectado à internet", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title:"Ok",style: UIAlertActionStyle.Default,handler: nil))
        dispatch_async(dispatch_get_main_queue(),{
        self.presentViewController(alert,animated: true, completion: nil)
        })
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
