//
//  AddEventViewController.swift
//  OncoManager
//
//  Created by Gabrielle Brandenburg dos Anjos on 7/15/16.
//  Copyright © 2016 Felipe Viberti. All rights reserved.
//

import UIKit

enum Evento: Int {
    case Exame = 0
    case Consulta = 1
    case Cirurgia = 2
}

class AddEventViewController: UIViewController {

    @IBOutlet weak var tituloLabel: UILabel!
    @IBOutlet weak var titulo: OMTextField!
    @IBOutlet weak var local: OMTextField!
    @IBOutlet weak var dataHoraRealizado: OMTextField!
    @IBOutlet weak var medico: OMTextField!
    @IBOutlet weak var dataMarcado: OMTextField!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var eventoArray = ["Exame","Consulta","Cirurgia"]
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.scrollEnabled = false
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func closeEvent(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func nextPressed(sender: UIButton) {
        if index < 2 {
        index += 1
        tituloLabel.text = eventoArray[index]
        print(eventoArray[index])
        }
    }
    
    @IBAction func backPressed(sender: UIButton) {
        if index > 0 {
        index -= 1
        tituloLabel.text = eventoArray[index]
        print(eventoArray[index])
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
               /* DaoCloudKit().addExame(Exame(tipoProcedimento: tituloLabel.text, cpf: pacienteSelecionado.cpf, codigo: 90, nome: nome.text, medico: medico.text, local: local.text, dataMarcado: <#T##NSDate#>, dataRealizado: <#T##NSDate#>, realizado: <#T##Int#>)
                 
 */
                
            }
        }
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
