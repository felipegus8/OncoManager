//
//  NovoPacienteViewController.swift
//  OncoManager
//
//  Created by Gabrielle Brandenburg dos Anjos on 7/17/16.
//  Copyright © 2016 Felipe Viberti. All rights reserved.
//

import UIKit

class NovoPacienteViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var nome: OMTextField!
    @IBOutlet weak var cpf: OMTextField!
    @IBOutlet weak var nascimento: OMTextField!
    @IBOutlet weak var email: OMTextField!
    @IBOutlet weak var bairro: OMTextField!
    @IBOutlet weak var telFixo: OMTextField!
    @IBOutlet weak var cel: OMTextField!
    @IBOutlet weak var convenio: OMTextField!
    @IBOutlet weak var tipoPlano: OMTextField!
    @IBOutlet weak var matricula: OMTextField!
    @IBOutlet weak var peso: OMTextField!
    @IBOutlet weak var altura: OMTextField!
    @IBOutlet weak var tipoOperacao: OMTextField!
    
    @IBOutlet weak var clipesCirurgico: UISwitch!
    @IBOutlet weak var marcapasso: UISwitch!
    @IBOutlet weak var hipertenso: UISwitch!
    @IBOutlet weak var diabetico: UISwitch!
    @IBOutlet weak var cadeirante: UISwitch!
    @IBOutlet weak var claustrofobico: UISwitch!
    @IBOutlet weak var operado: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()
         NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(NovoPacienteViewController.actOnNotificationSuccessSavePaciente), name: "notificationSaveSuccessPaciente", object: nil)
        offSwitches()
       // scrollView.contentSize.height = 1400
        linkDelegate()
       // scrollView.contentSize.width = self.view.frame.width
        //peso.frame.size.width = 0.45*matricula.frame.width
        //altura.frame.size.width = 0.45*matricula.frame.width

        // Do any additional setup after loading the view.
    }
    func offSwitches()
    {
        clipesCirurgico.on = false
        marcapasso.on = false
        hipertenso.on = false
        diabetico.on = false
        cadeirante.on = false
        claustrofobico.on = false
        operado.on = false
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        //scrollView.scrollEnabled = false
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
       // scrollView.scrollEnabled = true
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool // called when 'return' key pressed. return NO to ignore.
    {
        //textField.resign
        self.view.endEditing(true)
        return false
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //super.touchesBegan(touches, withEvent: event)
        let touch = touches.first!
        let vieW = touch.view
        
        print(vieW!.tag)
        
        if(vieW?.tag != 8){
            scrollView.endEditing(true)
            view.endEditing(true)
        }
    }
    
    func linkDelegate() {
        nome.delegate = self
        cpf.delegate = self
        nascimento.delegate = self
        email.delegate = self
        bairro.delegate = self
        telFixo.delegate = self
        cel.delegate = self
        convenio.delegate = self
        tipoPlano.delegate = self
        matricula.delegate = self
        //peso.delegate = self
        //altura.delegate = self
        //tipoOperacao.delegate = self
    }
    
    @IBAction func stopEditing(sender: UITapGestureRecognizer) {
        
        self.view.endEditing(true)
        //print(sender.description)
    }
    @IBAction func cadastrarPressed(sender: UIButton) {
        let intMarcapasso = (marcapasso.on == true) ? 1 : 0
        let intClipes = (clipesCirurgico.on == true) ? 1 : 0
        let intHipertenso = (hipertenso.on == true) ? 1 : 0
        let intDiabetico = (diabetico.on == true) ? 1 : 0
        let intCadeirante = (cadeirante.on == true) ? 1 : 0
        let intClaustrofobico = (claustrofobico.on == true) ? 1 : 0
        let intOperado = (operado.on == true) ? 1 : 0
        // Tem que colocar o BairroPrefere,a DataNasc como DatePicker e o switch de alergia
        DaoCloudKit().addPaciente(Paciente(cpf: Double(cpf.text!)!, nome: nome.text!, bairro: bairro.text!, bairroPrefere:"Tem que ver" , dataNasc: nascimento.text!, email: email.text!, telefoneFixo: Double(telFixo.text!)!, celular: Double(cel.text!)!, peso: Double(peso.text!)!, altura: Double(altura.text!)!, alergia: 1, marcapasso: intMarcapasso, clipesCirurgico: intClipes, operado: intOperado, tipoOperacao: nil, cadeirante: intCadeirante, diabetico: intDiabetico, hipertenso: intHipertenso, convenio: convenio.text!, tipoPlano: tipoPlano.text!, matriculaPlano: matricula.text!, claustrofobico: intClaustrofobico))
    }
    func actOnNotificationSuccessSavePaciente()
    {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func closePressed(sender: UIButton) {
         self.dismissViewControllerAnimated(true, completion: nil)
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
