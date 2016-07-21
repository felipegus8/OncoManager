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
    
    //var selectedName = "" // nome do paciente selecionado
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       // self.navigationController?.navigationBarHidden = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Table View Data Source
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pacientes.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.listaPacientes.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! ListaPacienteCell
        
        cell.nomePaciente.text = pacientes[indexPath.row].nome
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        pacienteSelecionado = pacientes[indexPath.row]
        examesDoPacienteSelecionado(pacienteSelecionado.cpf,paciente:pacienteSelecionado)
        print(examesDoPaciente)
        dispatch_async(dispatch_get_main_queue(),{
            self.performSegueWithIdentifier("goToPaciente", sender: self)
        })
       // DaoCloudKit().fetchExamesFromPaciente(pacienteSelecionado)
        
    }
    
     func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            DaoCloudKit().deletePaciente(pacientes[indexPath.row])
            tableView.reloadData()
        }
    }
    @IBAction func novoPacientePressed(sender: AnyObject) {
        self.performSegueWithIdentifier("goToNovoPaciente", sender: sender)
    }
    
    //MARK: envia nome do paciente selecionado para o titulo da navigationBar na tela seguinte
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        switch segue.identifier{
        case "goToPaciente"?:
            let destinationVC = segue.destinationViewController as! PacienteViewController
            destinationVC.pacienteName = pacienteSelecionado.nome
        default:
            break
            
        }
        
    }
 
    
    //MARK: esconde a navigation Bar
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
        self.listaPacientes.reloadData()
        print("Entrou na view Will Appear doa pacientes")
        examesDoPaciente.removeAll()
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillDisappear(animated)
    }


}
func examesDoPacienteSelecionado(cpf:Double,paciente:Paciente)
{
    examesDoPaciente.removeAll()
    for exame in exames
    {
        if exame.cpf == paciente.cpf
        {
            examesDoPaciente.append(exame)
        }
    }
}
