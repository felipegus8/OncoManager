//
//  ExamesViewController.swift
//  OncoManager
//
//  Created by Gabrielle Brandenburg dos Anjos on 7/26/16.
//  Copyright © 2016 Felipe Viberti. All rights reserved.
//

import UIKit

class ExamesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var i = -1
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()


        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = false
         NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ExamesViewController.actOnNotificationSuccessDeleteNomeExame), name: "notificationSucessDeleteNomeExame", object: nil)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nomeExames.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("exameCell", forIndexPath: indexPath) as! ExameCell
        
        cell.nome.text = nomeExames[indexPath.row].nome
        cell.editar.addTarget(self, action: #selector(self.editarExamePressed(_:)), forControlEvents: .TouchUpInside)
        cell.editar.tag = indexPath.row + 1
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.stopEditing(_:)))
        cell.contentView.addGestureRecognizer(tap)
        
        
        return cell
    }
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            DaoCloudKit().deleteNomeExame(nomeExames[indexPath.row])
        }
    }
    func actOnNotificationSuccessDeleteNomeExame()
    {
        dispatch_async(dispatch_get_main_queue(),{
            self.tableView.reloadData()
        })
    }
    
    @IBAction func addExamePressed(sender: UIBarButtonItem) {
        performSegueWithIdentifier("goToAddExame", sender: self)
    }
    
    func editarExamePressed(sender: UIButton){
        i = sender.tag - 1
        print("sender tag ===== \(i)")
        performSegueWithIdentifier("goToAddExame", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "goToAddExame" && i >= 0 {
            let destinationVC = segue.destinationViewController as! NovoExameViewController
            destinationVC.edit = true
            destinationVC.i = i
        }
    }
    
    func stopEditing(sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }

}
