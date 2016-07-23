//
//  EditEventViewController.swift
//  OncoManager
//
//  Created by Gabrielle Brandenburg dos Anjos on 7/22/16.
//  Copyright © 2016 Felipe Viberti. All rights reserved.
//

import UIKit

class EditEventViewController: UIViewController /*, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate */{

    @IBOutlet weak var titulo: OMTextField!
    @IBOutlet weak var local: OMTextField!
    @IBOutlet weak var dataHoraRealizado: OMTextField!
    @IBOutlet weak var medico: OMTextField!
    @IBOutlet weak var dataMarcado: OMTextField!
    
    var index1 = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fillTextFields()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fillTextFields() {
        
        titulo.text = examesDoPaciente[index1].nome
        local.text = examesDoPaciente[index1].local
        dataHoraRealizado.text = (examesDoPaciente[index1].dataRealizado).convertNsDateToString()
        medico.text = examesDoPaciente[index1].medico
        dataMarcado.text = (examesDoPaciente[index1].dataMarcado).convertNsDateToStringWithoutHour()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func atualizarEventoPressed(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func closeModal(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
