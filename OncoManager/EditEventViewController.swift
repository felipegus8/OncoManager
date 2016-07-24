//
//  EditEventViewController.swift
//  OncoManager
//
//  Created by Gabrielle Brandenburg dos Anjos on 7/22/16.
//  Copyright © 2016 Felipe Viberti. All rights reserved.
//

import UIKit

class EditEventViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var titulo: OMTextField!
    @IBOutlet weak var local: OMTextField!
    @IBOutlet weak var dataHoraRealizado: OMTextField!
    @IBOutlet weak var medico: OMTextField!
    @IBOutlet weak var dataMarcado: OMTextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var datePickerHour = UIDatePicker()
    var datePicker = UIDatePicker()
    var pickerView = UIPickerView()
    
    var medicoData: [String] = []
    var exameData: [String] = []
    var pickerData: [String]!
    
    var index = 0
    var tag = 0
    var date1:NSDate!
    var index1 = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(EditEventViewController.actOnNotificationSuccessEditExame), name: "notificationSuccessEditExame", object: nil)

        fillTextFields()
        linkDelegate()
        setupPickers()
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "dd/MM/yyyy - HH:mm"
        // formatter.locale =  NSLocale(localeIdentifier: "pt_BR")
        formatter.timeZone = NSTimeZone(forSecondsFromGMT: 10800)
        
        datePicker.addTarget(self, action: #selector(AddEventViewController.changedTxtFieldDate), forControlEvents: UIControlEvents.ValueChanged)
        datePickerHour.addTarget(self, action: #selector(AddEventViewController.changedTxtFieldDateHour), forControlEvents: UIControlEvents.ValueChanged)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func linkDelegate() {
        dataHoraRealizado.delegate = self
        dataMarcado.delegate = self
        titulo.delegate = self
        medico.delegate = self
    }
    
    func fillTextFields() {
        
        titulo.text = examesDoPaciente[index1].nome
        local.text = examesDoPaciente[index1].local
        dataHoraRealizado.text = (examesDoPaciente[index1].dataRealizado).convertNsDateToString()
        medico.text = examesDoPaciente[index1].medico
        dataMarcado.text = (examesDoPaciente[index1].dataMarcado).convertNsDateToStringWithoutHour()
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
    
    func changedTxtFieldDate() {
        let date: String?
        print(datePicker.date)
        date = datePicker.date.convertNsDateToStringWithoutHour()
        dataMarcado.text = date
    }
    
    //MARK: converte a Data para String e altera o texto do textfield
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

    @IBAction func atualizarEventoPressed(sender: UIButton) {
      /*  let exameEditado = Exame(tipoProcedimento: examesDoPaciente[index1].tipoProcedimento, cpf: examesDoPaciente[index1].cpf, nome: titulo.text!, medico: medico.text!, local: local.text!, dataMarcado: <#T##NSDate#>, dataRealizado: <#T##NSDate#>, realizado: 1)
         DaoCloudKit().editExame(exameEditado)
 */
    }
    func actOnNotificationSuccessEditExame()
    {
        dispatch_async(dispatch_get_main_queue(),{
        self.dismissViewControllerAnimated(true, completion: nil)
        })

    }
    @IBAction func closeModal(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
