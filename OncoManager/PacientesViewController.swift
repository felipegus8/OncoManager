//
//  PacientesViewController.swift
//  OncoManager
//
//  Created by Gabrielle Brandenburg dos Anjos on 7/13/16.
//  Copyright © 2016 Felipe Viberti. All rights reserved.
//

import UIKit

class PacientesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var listaPacientes: UITableView!
    
    var selectedName = "" // nome do paciente selecionado
    
    var pacienteLista = [String]() // lista de pacientes na table view
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // self.navigationController?.navigationBarHidden = true
        
        loadPacientesFromDAO()
        print(pacienteLista.count)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: protocolo da Table View
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pacienteLista.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.listaPacientes.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! ListaPacienteCell
        
        cell.nomePaciente.text = pacienteLista[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        selectedName = pacienteLista[indexPath.row]
    
        performSegueWithIdentifier("goToPaciente", sender: self)
        
        
    }
    
    //MARK: carregar nesta função a lista de nomes dos pacientes
    func loadPacientesFromDAO(){
        
        for _ in 0...5{
        pacienteLista.append("Maria Edileuza")
        }
    }
    
    //MARK: envia dados pra a tela seguinte
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        switch segue.identifier{
        case "goToPaciente"?:
            let destinationVC = segue.destinationViewController as! PacienteViewController
            destinationVC.pacienteName = selectedName
        default:
            break
            
        }
    }
    
    //MARK: esconde a navigation Bar
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillDisappear(animated)
    }


}
