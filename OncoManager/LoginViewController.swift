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
    
    let testeExame =  Exame(codigo: 8, nome: "TesteExame", medico: "Testando", local: "Copa", data: "23-08-2016", hora: "17:00", aprovado: 0, realizado: 1)
    let testePaciente = Paciente(cpf: 16798089766, nome: "Teste", bairro: "Magé", bairroPrefere: "Niteroi", dataNasc: "26-09-1962", email: "qualquer", telefoneFixo: 2345980135, celular: 346725789, peso: 78, altura: 1.70, alergia: 0, marcapasso: 0, clipesCirurgico: 0, operado: 0, tipoOperacao: nil, cadeirante: 0, diabetico: 1, hipertenso: 0, convenio: "Assim", tipoPlano: "Ruim", matriculaPlano: "12345",claustrofobico:0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(LoginViewController.actOnNotificationSuccessLoadPaciente), name: "notificationSuccessLoadPaciente", object: nil)
       //DaoCloudKit().addPaciente(testePaciente)
       // testePaciente.arrayExames.removeAll()
       // testePaciente.exames.removeAll()
       // DaoCloudKit().addExameToPaciente(testeExame, paciente: testePaciente)
        DaoCloudKit().fetchExamesFromPaciente(testePaciente)
        
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
    func actOnNotificationSuccessLoadPaciente()
    {
        print(testePaciente.exames[0].nome)
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
