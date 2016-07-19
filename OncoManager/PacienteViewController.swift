//
//  PacienteViewController.swift
//  OncoManager
//
//  Created by Gabrielle Brandenburg dos Anjos on 7/13/16.
//  Copyright © 2016 Felipe Viberti. All rights reserved.
//

enum Segment: Int {
    case Historico = 0, DadosPaciente
}

import UIKit

class PacienteViewController: UIViewController {
    
    @IBOutlet weak var timeView: UIView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var diasTratamento: UILabel!
    
    @IBOutlet weak var contentView: UIView! //content para troca de tableView
    
    var dadosTableView: DadosPacienteTableView!
    var historicoTableView: HistoricoPacienteTableView!
    
    var pacienteName = "Paciente"
    

    override func viewDidLoad() {
        super.viewDidLoad()
        for exame in examesDoPaciente
        {
            if  let order = menorData
            {
                if order.compare((exame.dataMarcado)!) ==  NSComparisonResult.OrderedDescending
                {
                    menorData = exame.dataMarcado
                }
            }
            else{
                menorData = exame.dataMarcado
            }

        }
        if examesDoPaciente.count > 0
        {
        print(menorData)
        let dataAtual = NSDate()
        let calendar = NSCalendar.currentCalendar()
        //calendar.components([.Day , .Month , .Year], fromDate: dataAtual)
        print(dataAtual)
        let date1 = calendar.startOfDayForDate(menorData)
        let date2 = calendar.startOfDayForDate(dataAtual)
        
        let flags = NSCalendarUnit.Day
        let components = calendar.components(flags, fromDate: date1, toDate: date2, options: [])
        
        diasTratamento.text = String(components.day) + " " + "dias"// This will return the number of day(s) between dates
        }
        self.navigationItem.title = pacienteName // recebe o nome da tableView pelo segue
        timeView.layer.shadowOpacity = 0.2
        timeView.layer.shadowRadius = 0.2
        timeView.layer.shadowOffset = CGSize(width: 0.0,height: 1.0)
        
        dadosTableView = DadosPacienteTableView()
    
        dadosTableView.view.frame = contentView.frame
        contentView.addSubview(dadosTableView.tableView)
        
        historicoTableView = HistoricoPacienteTableView()
        
        historicoTableView.view.frame = contentView.frame
        contentView.addSubview(historicoTableView.tableView)
        
        
        dadosTableView.view.hidden = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func segmentedControlChanged(sender: UISegmentedControl) {
        let segment = Segment(rawValue: segmentedControl.selectedSegmentIndex)!
        
        switch segment {
        case .DadosPaciente:
            historicoTableView.view.hidden = true
            dadosTableView.view.hidden = false
            break
        default:
            historicoTableView.view.hidden = false
            dadosTableView.view.hidden = true
            break
        }
        
    }
    
    @IBAction func addEventPressed(sender: AnyObject) {
        performSegueWithIdentifier("goToAddEvent", sender: sender)
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
