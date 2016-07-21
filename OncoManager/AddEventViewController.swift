//
//  AddEventViewController.swift
//  OncoManager
//
//  Created by Gabrielle Brandenburg dos Anjos on 7/15/16.
//  Copyright © 2016 Felipe Viberti. All rights reserved.
//

import UIKit

//MARK: TEXTFIELD TAGS:
//dataHoraRealizado.tag = 10
//dataMarcado.tag = 11
//titulo.tag = 12
//medico.tag = 13

class AddEventViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var tituloLabel: UILabel!
    @IBOutlet weak var titulo: OMTextField!
    @IBOutlet weak var local: OMTextField!
    @IBOutlet weak var dataHoraRealizado: OMTextField!
    @IBOutlet weak var medico: OMTextField!
    @IBOutlet weak var dataMarcado: OMTextField!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    var datePickerHour = UIDatePicker()
    var datePicker = UIDatePicker()
    var pickerView = UIPickerView()
    var medicoData: [String]!
    var exameData: [String]!
    var pickerData: [String]!
    var tag = 0
    var eventoArray = ["Exame","Consulta","Cirurgia"]
    var currentEvent: String!

    struct EventoPlaceholder {
        var titulo: String!
        var local: String!
        var dataHoraRealizado: String!
        var medico: String!
        var dataMarcado: String!
    }
    
    var eventoPlArray: [Int:EventoPlaceholder]!
    
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.scrollEnabled = false
        setupPickers()
        setupPlaceholderData()
        linkDelegate()
        
        backButton.alpha = 0.25
        
        datePicker.addTarget(self, action: #selector(AddEventViewController.changedTxtFieldDate), forControlEvents: UIControlEvents.ValueChanged)
        datePickerHour.addTarget(self, action: #selector(AddEventViewController.changedTxtFieldDateHour), forControlEvents: UIControlEvents.ValueChanged)
        
         NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(AddEventViewController.actOnNotificationSuccessAddEvento), name: "notificationSuccessCadastroExame", object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func closeEvent(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //Configura o nome dos placeholders para cada tipo de evento
    func setupPlaceholderData(){
        let exame = EventoPlaceholder(titulo: "Tipo de exame", local: "Local", dataHoraRealizado: "Data do exame", medico: "Médico solicitante", dataMarcado: "Data de agendamento")
        let consulta = EventoPlaceholder(titulo: "Tipo de consulta", local: "Local", dataHoraRealizado: "Data da consulta", medico: "Médico", dataMarcado: "Data de agendamento")
        let cirurgia = EventoPlaceholder(titulo: "Tipo de cirurgia", local: "Local", dataHoraRealizado: "Data da cirurgia", medico: "Médico responsável", dataMarcado: "Data de agendamento")
        
        eventoPlArray = [0:exame, 1:consulta, 2: cirurgia]
    }
    

    
    func linkDelegate() {
        dataHoraRealizado.delegate = self
        dataMarcado.delegate = self
        titulo.delegate = self
        medico.delegate = self
    }
    
    func setupPickers(){
        
      //  let loc = NSLocale(localeIdentifier: "pt_BR")
        //datePicker.locale = loc
        //datePicker.timeZone = NSTimeZone(forSecondsFromGMT: -10800)
        datePicker.datePickerMode = UIDatePickerMode.Date
        datePicker.backgroundColor = UIColor.whiteColor()
        datePicker.frame.size.height = 0.23*self.view.frame.height
        
      //  datePickerHour.locale = loc
       // datePickerHour.timeZone = NSTimeZone(forSecondsFromGMT: -10800)
        datePickerHour.backgroundColor = UIColor.whiteColor()
        
        pickerView.backgroundColor = UIColor.whiteColor()
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.frame.size.height = self.view.frame.height*0.35
        loadPickerData()
    }
    
    //MARK: carregar aqui a lista de exames e médicos
    func loadPickerData() {
        medicoData = ["Dra. Claudia","Dr. Eduardo","Dra. Lúcia","Dr. Pedro"]
        exameData = ["Biopsia","Endoscopia","Ressonância","Tomografia Computadorizada","Ultrassonografia"]
        
    }
    
    //MARK: converte a Data para String e altera o texto do textfield
    func changedTxtFieldDate() {
        let date: String?
        print(datePicker.date)
        date = datePicker.date.convertNsDateToStringWithoutHour()
        dataMarcado.text = date
    }
    
    func changedTxtFieldDateHour() {
        let date: String?
        print(datePickerHour.date)
        date = datePickerHour.date.convertNsDateToString()
        dataHoraRealizado.text = date
    }
    
    //MARK: PickerView dataSource
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count;
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        switch tag {
        case 12:
            titulo.text = pickerData[row]
        case 13:
            medico.text = pickerData[row]
        default:
            break
        }
        
    }
    
    //MARK: delegate do text field -> aciona o pickerView
    func textFieldDidBeginEditing(textField: UITextField) {
        tag = textField.tag
        
        switch textField.tag{
            
        //MARK: aciona o datePicker
        case 10:
            textField.inputView = datePickerHour
        case 11:
            textField.inputView = datePicker
        case 12:
            if (textField.placeholder == "Tipo de exame"){
            pickerData = exameData
            textField.inputView = pickerView
            }
        case 13:
            pickerData = medicoData
            textField.inputView = pickerView
            
        default:
            break
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool // called when 'return' key pressed. return NO to ignore.
    {
        //textField.resign
        self.view.endEditing(true)
        return false
    }
    
    func changePlaceholders(index: Int){
        
        titulo.placeholder = eventoPlArray[index]?.titulo
        local.placeholder = eventoPlArray[index]?.local
        dataHoraRealizado.placeholder = eventoPlArray[index]?.dataHoraRealizado
        medico.placeholder = eventoPlArray[index]?.medico
        dataMarcado.placeholder = eventoPlArray[index]?.dataMarcado
        
    }

    @IBAction func nextPressed(sender: UIButton) {
       
        if index < 2 {
        index += 1
        tituloLabel.text = eventoArray[index]
        changePlaceholders(index)
            if backButton.alpha == 0.25 {
                backButton.alpha = 1
            }
            if index == 2 {
                nextButton.alpha = 0.25
            }
        print(eventoArray[index])
        }
    }
    
    @IBAction func backPressed(sender: UIButton) {
        
        if index > 0 {
        index -= 1
        tituloLabel.text = eventoArray[index]
        changePlaceholders(index)
            if nextButton.alpha == 0.25 {
                nextButton.alpha = 1
            }
            if index == 0 {
                backButton.alpha = 0.25
            }
        print(eventoArray[index])
        }
        
    }
    
    //fecha a inputView (picker ou teclado) com UIGesture
    @IBAction func stopEditing(sender: UITapGestureRecognizer) {
        
        self.view.endEditing(true)
        //print(sender.description)
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
    
    @IBAction func cadastro(sender: AnyObject) {
        if DaoCloudKit().cloudAvailable() == true{
            if ((titulo.text?.isEmpty == true) || (local.text?.isEmpty == true) || (dataHoraRealizado.text?.isEmpty == true) || (medico.text?.isEmpty == true) || (dataMarcado.text?.isEmpty == true))
            {
                let alert=UIAlertController(title:"Erro", message: "Todos os campos são obrigatórios", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title:"Ok",style: UIAlertActionStyle.Default,handler: nil))
                self.presentViewController(alert,animated: true, completion: nil)

            }
            else{
                if let codigo =  defaults.objectForKey("codigo")
                {
                    var codigoVar = codigo as! Int + 1
                    defaults.setObject(codigoVar, forKey: "codigo")
                }
                else{
                    defaults.setObject(0, forKey: "codigo")
                }
                print("Chamou o cloud")
                DaoCloudKit().addExame(Exame(tipoProcedimento: tituloLabel.text!, cpf: pacienteSelecionado.cpf, codigo: defaults.objectForKey("codigo") as! Int, nome: titulo.text!, medico: medico.text!, local: local.text!, dataMarcado: datePicker.date, dataRealizado: datePickerHour.date, realizado: 0))
            
                
            }
        }
    }
    func actOnNotificationSuccessAddEvento()
    {
         dispatch_async(dispatch_get_main_queue(),{
            self.dismissViewControllerAnimated(true, completion: nil)
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
