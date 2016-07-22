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
    var selectedBut = 0
    var buttonTag = 0
    
    var pacienteName = pacienteSelecionado.nome

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = pacienteName // recebe o nome da tableView pelo segue
        timeView.layer.shadowOpacity = 0.2
        timeView.layer.shadowRadius = 0.2
        timeView.layer.shadowOffset = CGSize(width: 0.0,height: 1.0)
        
        dadosTableView = DadosPacienteTableView()
        
    
        dadosTableView.view.frame = contentView.frame
        contentView.addSubview(dadosTableView.tableView)
        
        historicoTableView = HistoricoPacienteTableView()
        historicoTableView.parent = self
        
        historicoTableView.view.frame = contentView.frame
        contentView.addSubview(historicoTableView.tableView)
        
        
        dadosTableView.view.hidden = true
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(animated: Bool) {
        print("Entrou na view Will Appear do paciente unico")
        if examesDoPaciente.count > 0
        {
            menorData = examesDoPaciente[0].dataMarcado
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
            print(menorData)
            print("Conta aí")
            print(examesDoPaciente.count)
            let dataAtual = NSDate()
            let calendar = NSCalendar.currentCalendar()
            print(dataAtual)
            let date1 = calendar.startOfDayForDate(menorData)
            let date2 = calendar.startOfDayForDate(dataAtual)
            
            let flags = NSCalendarUnit.Day
            let components = calendar.components(flags, fromDate: date1, toDate: date2, options: [])
            
            diasTratamento.text = String(components.day) + " " + "dias"// This will return the number of day(s) between dates
        }

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func segmentedControlChanged(sender: UISegmentedControl) {
        let segment = Segment(rawValue: segmentedControl.selectedSegmentIndex)!
        
        switch segment {
        case .DadosPaciente:
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Edit, target: self, action: #selector(self.goToEditPaciente))
            selectedBut = 1
            self.navigationItem.rightBarButtonItem?.tintColor = UIColor.greenOM()
            historicoTableView.view.hidden = true
            dadosTableView.view.hidden = false
            print("selectedBut: \(selectedBut)")
            
        case .Historico:
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: #selector(self.navButtonPressed(_:)))
            selectedBut = 0
            self.navigationItem.rightBarButtonItem?.tintColor = UIColor.greenOM()
            historicoTableView.view.hidden = false
            dadosTableView.view.hidden = true
            print("selectedBut: \(selectedBut)")

        }
        
        
        
    }
    
    func goToEditEvent (sender: UIButton) {
        buttonTag = sender.tag
        performSegueWithIdentifier("goToEditEvent", sender: self)
    }
    
    func goToEditPaciente() {
        performSegueWithIdentifier("goToEditPaciente", sender: self)
    }
    
    func goToAddPaciente() {
        performSegueWithIdentifier("goToAddEvent", sender: self)
    }
    
    @IBAction func navButtonPressed(sender: UIBarButtonItem) {
        print("===========entrou na funcao")

            performSegueWithIdentifier("goToAddEvent", sender: self)
    }
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "goToEditEvent" {
            let destinationVC = segue.destinationViewController as! EditEventViewController
            destinationVC.index = buttonTag
        }
    }
 

}
