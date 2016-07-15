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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // self.navigationController?.navigationBarHidden = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: protocolo da Table View
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pacientes.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.listaPacientes.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! ListaPacienteCell
        
        cell.nomePaciente.text = pacientes[indexPath.row].nome
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
       // selectedName = pacienteLista[indexPath.row]
    
        performSegueWithIdentifier("goToPaciente", sender: self)
        
        
    }
    func actOnNotificationSuccessPacientes()
    {
        
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
