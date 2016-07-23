//
//  NovoPacienteViewController.swift
//  OncoManager
//
//  Created by Gabrielle Brandenburg dos Anjos on 7/17/16.
//  Copyright © 2016 Felipe Viberti. All rights reserved.
//

import UIKit

//MARK: TEXTFIELD TAGS:
// nascimento.tag = 13
// convenio.tag = 14
//tipoPlano.tag = ?

public  var convenioData1: [String] = ["Allianz", "Amil", "Bradesco", "CarePlus", "Furnas", "Golden Cross", "Medial", "Mediservice", "Petrobrás", "Sul América", "Unimed", "Vale"]

class EditarPacienteViewController: UIViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var nome: OMTextField!
    @IBOutlet weak var cpf: OMTextField!
    @IBOutlet weak var nascimento: OMTextField!
    @IBOutlet weak var email: OMTextField!
    @IBOutlet weak var bairro: OMTextField!
    @IBOutlet weak var bairroPreferencia: OMTextField!
    @IBOutlet weak var telFixo: OMTextField!
    @IBOutlet weak var cel: OMTextField!
    @IBOutlet weak var convenio: OMTextField!
    @IBOutlet weak var tipoPlano: OMTextField!
    @IBOutlet weak var matricula: OMTextField!
    @IBOutlet weak var peso: OMTextField!
    @IBOutlet weak var altura: OMTextField!
    @IBOutlet weak var tipoOperacao: OMTextField!
    
    @IBOutlet weak var alergia: UISwitch!
    @IBOutlet weak var clipesCirurgico: UISwitch!
    @IBOutlet weak var marcapasso: UISwitch!
    @IBOutlet weak var hipertenso: UISwitch!
    @IBOutlet weak var diabetico: UISwitch!
    @IBOutlet weak var cadeirante: UISwitch!
    @IBOutlet weak var claustrofobico: UISwitch!
    @IBOutlet weak var operado: UISwitch!
    
    let datePicker = UIDatePicker()
    let pickerView = UIPickerView()
    var convenioData: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(EditarPacienteViewController.actOnNotificationSuccessSavePaciente), name: "notificationSuccessEditPaciente", object: nil)
        
        setupPickers()
        linkDelegate()
        setKeyboards()
        setTextFields()
        setSwitches()
        datePicker.addTarget(self, action: #selector(NovoPacienteViewController.changedTxtFieldDate), forControlEvents: UIControlEvents.ValueChanged)
    }
    func loadPickerData(){
        
        convenioData = ["Allianz", "Amil", "Bradesco", "CarePlus", "Furnas", "Golden Cross", "Medial", "Mediservice", "Petrobrás", "Sul América", "Unimed", "Vale"]
    }
    
    func setTextFields()
    {
        nome.text = pacienteSelecionado.nome
        cpf.text = String(pacienteSelecionado.cpf)
        nascimento.text = pacienteSelecionado.dataNasc
         email.text = pacienteSelecionado.email
         bairro.text = pacienteSelecionado.bairro
        telFixo.text = String(pacienteSelecionado.telefoneFixo)
        cel.text = String(pacienteSelecionado.celular)
         convenio.text = pacienteSelecionado.convenio
        tipoPlano.text = pacienteSelecionado.tipoPlano
         matricula.text = pacienteSelecionado.matriculaPlano
         peso.text = String(pacienteSelecionado.peso)
         altura.text = String(pacienteSelecionado.altura)
         tipoOperacao.text = pacienteSelecionado.tipoOperacao
        bairroPreferencia.text = pacienteSelecionado.bairroPrefere
    }
    func setSwitches()
    {
        clipesCirurgico.on = (pacienteSelecionado.clipesCirurgico == 1) ? true : false
        marcapasso.on = (pacienteSelecionado.marcapasso == 1) ? true : false
       hipertenso.on = (pacienteSelecionado.hipertenso == 1) ? true : false
        diabetico.on = (pacienteSelecionado.diabetico == 1) ? true : false
       cadeirante.on = (pacienteSelecionado.cadeirante == 1) ? true : false
        claustrofobico.on = (pacienteSelecionado.claustrofobico == 1) ? true : false
        operado.on = (pacienteSelecionado.operado == 1) ? true : false
        alergia.on = (pacienteSelecionado.alergia == 1) ? true : false
    }
    func setupPickers(){
        
        let loc = NSLocale(localeIdentifier: "pt_BR")
        datePicker.locale = loc
        datePicker.datePickerMode = UIDatePickerMode.Date
        datePicker.backgroundColor = UIColor.whiteColor()
        pickerView.backgroundColor = UIColor.whiteColor()
        pickerView.dataSource = self
        pickerView.delegate = self
        loadPickerData()
    }
    func setKeyboards()
    {
        cpf.keyboardType = .NumberPad
        telFixo.keyboardType = .NumberPad
        cel.keyboardType = .NumberPad
        matricula.keyboardType = .NumberPad
        peso.keyboardType = .DecimalPad
        altura.keyboardType = .DecimalPad
    }
    func changedTxtFieldDate() {
        //MARK: adicionar aqui a função de converter hora do DatePicker
        let date: String?
        date = datePicker.date.convertNsDateToStringWithoutHour()
        nascimento.text = date
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return convenioData.count;
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return convenioData[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        convenio.text = convenioData[row]
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        
        switch textField.tag{
        //MARK: aciona o datePicker
        case 13:
            textField.inputView = datePicker
        case 14:
            textField.inputView = pickerView
        default:
            break
        }
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool // called when 'return' key pressed. return NO to ignore.
    {
        //textField.resign
        self.view.endEditing(true)
        print(textField.placeholder)
        return false
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        let touch = touches.first!
        let vieW = touch.view
        
        print(vieW!.tag)
        //finaliza a edição quando o usuario toca fora da scrollView
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
        bairroPreferencia.delegate = self
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
    
    @IBAction func editarButton(sender: AnyObject) {
        let intMarcapasso = (marcapasso.on == true) ? 1 : 0
     let intClipes = (clipesCirurgico.on == true) ? 1 : 0
     let intHipertenso = (hipertenso.on == true) ? 1 : 0
       let intDiabetico = (diabetico.on == true) ? 1 : 0
       let intCadeirante = (cadeirante.on == true) ? 1 : 0
     let intClaustrofobico = (claustrofobico.on == true) ? 1 : 0
      let intOperado = (operado.on == true) ? 1 : 0
        let intAlergia = (alergia.on == true) ? 1 : 0

       pacienteSelecionado = Paciente(cpf: Double(cpf.text!)!, nome: nome.text!, bairro: bairro.text!, bairroPrefere:bairroPreferencia.text! , dataNasc: nascimento.text!, email: email.text!, telefoneFixo: Double(telFixo.text!)!, celular: Double(cel.text!)!, peso: Double(peso.text!)!, altura: Double(altura.text!)!, alergia: intAlergia, marcapasso: intMarcapasso, clipesCirurgico: intClipes, operado: intOperado, tipoOperacao: tipoOperacao.text, cadeirante: intCadeirante, diabetico: intDiabetico, hipertenso: intHipertenso, convenio: convenio.text!, tipoPlano: tipoPlano.text!, matriculaPlano: matricula.text!, claustrofobico: intClaustrofobico)
     
        DaoCloudKit().editPaciente(pacienteSelecionado)
    }
    
    func actOnNotificationSuccessSavePaciente()
    {
        index = 0
        dispatch_async(dispatch_get_main_queue(),{
        self.dismissViewControllerAnimated(true, completion: nil)
        })
    }
    
    @IBAction func closePressed(sender: UIButton) {
        index = 0
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidAppear(animated: Bool) {
        view.bringSubviewToFront(datePicker)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
