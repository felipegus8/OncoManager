//
//  MedicosViewController.swift
//  OncoManager
//
//  Created by Gabrielle Brandenburg dos Anjos on 7/26/16.
//  Copyright © 2016 Felipe Viberti. All rights reserved.
//

import UIKit

class MedicosViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var medTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        medTableView.delegate = self
        medTableView.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return medicos.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.medTableView.dequeueReusableCellWithIdentifier("medCell", forIndexPath: indexPath) as! MedicoCell
        cell.nomeMedico.text = medicos[indexPath.row].nome
        cell.email.text = medicos[indexPath.row].email
        cell.especialidade.text = medicos[indexPath.row].especialidade
        
        return cell
    }
    
    
    @IBAction func addMedicoPressed(sender: UIBarButtonItem) {
        performSegueWithIdentifier("goToAddMedico", sender: self)
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
