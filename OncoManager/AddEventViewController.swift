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
    var instanciaExame:Exame!
    var datePickerHour = UIDatePicker()
    var datePicker = UIDatePicker()
    var pickerView = UIPickerView()
    var medicoData: [String] = []
    var exameData: [String] = []
    var pickerData: [String]!
    var tag = 0
    var eventoArray = ["Exame","Consulta","Cirurgia"]
    var currentEvent: String!
    var i = 0
    var parent: PacienteViewController?
    var saveTheDate = NSDate()
    
    
    struct EventoPlaceholder {
        var titulo: String!
        var local: String!
        var dataHoraRealizado: String!
        var medico: String!
        var dataMarcado: String!
    }
    
    var eventoPlArray: [Int:EventoPlaceholder]!
    
   // var index = 0
    var date1:NSDate!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.scrollEnabled = false
        setupPickers()
        setupPlaceholderData()
        linkDelegate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "dd/MM/yyyy - HH:mm"
        // formatter.locale =  NSLocale(localeIdentifier: "pt_BR")
        formatter.timeZone = NSTimeZone(forSecondsFromGMT: 10800)
        
        dataMarcado.text = NSDate().convertNsDateToStringWithoutHour()
        backButton.alpha = 0.25
        
        datePicker.addTarget(self, action: #selector(AddEventViewController.changedTxtFieldDate), forControlEvents: UIControlEvents.ValueChanged)
        datePickerHour.addTarget(self, action: #selector(AddEventViewController.changedTxtFieldDateHour), forControlEvents: UIControlEvents.ValueChanged)
        
         NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(AddEventViewController.actOnNotificationSuccessAddEvento), name: "notificationSuccessCadastroExame", object: nil)
         NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(AddEventViewController.actOnNotificationErrorAddEvento), name: "notificationErrorCadastroExame", object: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func closeEvent(sender: AnyObject) {
        index = 0
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //Configura o nome dos placeholders para cada tipo de evento
    func setupPlaceholderData(){
        let exame = EventoPlaceholder(titulo: "Tipo de exame", local: "Local", dataHoraRealizado: "Data do exame", medico: "Médico requerente", dataMarcado: "Data de agendamento")
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
        
        let loc = NSLocale(localeIdentifier: "pt_BR")
        datePicker.locale = loc
        datePicker.datePickerMode = UIDatePickerMode.Date
        datePicker.backgroundColor = UIColor.whiteColor()
        datePicker.frame.size.height = 0.23*self.view.frame.height
        datePickerHour.locale = loc
        datePickerHour.datePickerMode = UIDatePickerMode.DateAndTime
       // datePickerHour.timeZone = NS
        datePickerHour.backgroundColor = UIColor.whiteColor()
        pickerView.backgroundColor = UIColor.whiteColor()
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.frame.size.height = self.view.frame.height*0.35
        loadPickerData()
    }
    
    //MARK: carregar aqui a lista de exames e médicos
    func loadPickerData() {
       for medico in medicos
       {
        medicoData.append(medico.nome)
        }
        for exame in nomeExames
        {
            exameData.append(exame.nome)
        }
        
    }
    
    //MARK: converte a Data para String e altera o texto do textfield
    func changedTxtFieldDate() {
        let date: String?
        print(datePicker.date)
        saveTheDate = datePicker.date
        date = datePicker.date.convertNsDateToStringWithoutHour()
        dataMarcado.text = date
    }
    
    func changedTxtFieldDateHour() {
        let date: String?
        print(datePickerHour.date.localTime)
        date = datePickerHour.date.convertNsDateToString()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "dd/MM/yyyy - HH:mm"
        //formatter.dateStyle = NSDateFormatterStyle.ShortStyle
        // formatter.locale =  NSLocale(localeIdentifier: "pt_BR")
        formatter.timeZone = NSTimeZone(forSecondsFromGMT: 10800)
        
        date1=formatter.dateFromString(date!)
        let dateFinal = date1?.convertNsDateToString()
        dataHoraRealizado.text = dateFinal
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
    
    func linkTargetsToTextField() {
        titulo.addTarget(titulo, action: #selector(self.reloadPicker), forControlEvents: .AllTouchEvents)
        medico.addTarget(medico, action: #selector(self.reloadPicker), forControlEvents: .AllTouchEvents)
    }
    
    func reloadPicker(sender: UITextField){
        if sender.placeholder == "Tipo de exame"{
        pickerData = exameData
        sender.inputView = pickerView
        } else if sender.tag == 13{
            pickerData = medicoData
            sender.inputView = pickerView
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
                if pickerData != nil{
            pickerData.removeAll()
                }
            pickerData = exameData
            pickerView.dataSource = self
            textField.inputView = pickerView
            } else {
                textField.inputView = nil
            }
        case 13:
            if pickerData != nil
            {
            pickerData.removeAll()
            }
            pickerData = medicoData
            pickerView.dataSource = self
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
        zeraTextField(titulo, local: local, dataHoraRealizado: dataHoraRealizado, medico: medico, dataMarcado: dataMarcado)
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
        zeraTextField(titulo, local: local, dataHoraRealizado: dataHoraRealizado, medico: medico, dataMarcado: dataMarcado)
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
        if i == 0
        {
            i+=1
        if DaoCloudKit().cloudAvailable() == true{
            if ((titulo.text?.isEmpty == true) || (local.text?.isEmpty == true) || (dataHoraRealizado.text?.isEmpty == true) || (medico.text?.isEmpty == true) || (dataMarcado.text?.isEmpty == true))
            {
                i = 0
                let alert=UIAlertController(title:"Erro", message: "Todos os campos são obrigatórios", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title:"Ok",style: UIAlertActionStyle.Default,handler: nil))
                self.presentViewController(alert,animated: true, completion: nil)

            }
            else{
                print("Chamou o cloud")
                instanciaExame = Exame(tipoProcedimento: tituloLabel.text!, cpf: pacienteSelecionado.cpf,nome: titulo.text!, medico: medico.text!, local: local.text!, dataMarcado: datePicker.date, dataRealizado: date1, realizado: 0)
                DaoCloudKit().addExame(instanciaExame)
            }
        }
        }
    }
    func actOnNotificationSuccessAddEvento()
    {
        exames.append(instanciaExame)
        examesDoPaciente.append(instanciaExame)
        index = 0
         dispatch_async(dispatch_get_main_queue(),{
            self.performSegueWithIdentifier("unwindToPaciente", sender: self)
            //self.dismissViewControllerAnimated(true, completion: nil)
        })
    }
     func actOnNotificationErrorAddEvento()
     {
        i=0
        let alert=UIAlertController(title:"Erro", message: "Não foi possivel adicionar o procedimento", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title:"Ok",style: UIAlertActionStyle.Default,handler: nil))
        dispatch_async(dispatch_get_main_queue(),{
        self.presentViewController(alert,animated: true, completion: nil)
        })
    }

    func zeraTextField(titulo: OMTextField, local: OMTextField, dataHoraRealizado: OMTextField, medico: OMTextField, dataMarcado: OMTextField){
        titulo.text = ""
        local.text = ""
        dataHoraRealizado.text = ""
        medico.text = ""
        dataMarcado.text = ""
    }
    
   @IBAction override func unwindForSegue(unwindSegue: UIStoryboardSegue, towardsViewController subsequentVC: UIViewController) {
        if unwindSegue.identifier == "unwindToPaciente" {
            let sourceVC = unwindSegue.sourceViewController as? PacienteViewController
            
            print("UNWIND")
            if examesDoPaciente.count == 1
            {
                
                print("IF UNWIND")
                print("QTD DE EXAMES: " + "\(examesDoPaciente.count)")
                let dataAtual = NSDate()
                let calendar = NSCalendar.currentCalendar()
                print(dataAtual)
                let date1 = calendar.startOfDayForDate(saveTheDate)
                let date2 = calendar.startOfDayForDate(dataAtual)
                
                let flags = NSCalendarUnit.Day
                let components = calendar.components(flags, fromDate: date1, toDate: date2, options: [])
                
                sourceVC?.diasTratamento.text = String(components.day) + " " + "dias"
            }
        }
    }

}
