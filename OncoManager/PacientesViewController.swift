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
    
    var nomesPaciente = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadPacientesFromDAO()
        print(nomesPaciente.count)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nomesPaciente.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.listaPacientes.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! ListaPacienteCell
        
        cell.nomePaciente.text = nomesPaciente[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        <#code#>
    }
    
    func loadPacientesFromDAO(){
        
        for _ in 0...5{
        nomesPaciente.append("Maria Edileuza")
        }
        print("\(nomesPaciente.count)" + "lol")
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
