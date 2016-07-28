//
//  ExamesViewController.swift
//  OncoManager
//
//  Created by Gabrielle Brandenburg dos Anjos on 7/26/16.
//  Copyright © 2016 Felipe Viberti. All rights reserved.
//

import UIKit

class ExamesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,UISearchBarDelegate {
    var i = -1
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var searchActive : Bool = false
    var filtered:[String] = []
     var nomeExamesString:[String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
       
        searchBar.delegate = self
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
    //MARK:Search Bar Delegate
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        print("Entrou aqui")
        searchActive = false;
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        print("Entrou aqui")
        filtered = nomeExamesString.filter({ (text) -> Bool in
            let tmp: NSString = text
            let range = tmp.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
            return range.location != NSNotFound
        })
        print(filtered)
        if(filtered.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
        }
        print("Reload Data")
        self.tableView.reloadData()
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !searchActive
        {
        return nomeExames.count
        }
        else
        {
            return filtered.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("exameCell", forIndexPath: indexPath) as! ExameCell
        if !searchActive
        {
        cell.nome.text = nomeExames[indexPath.row].nome
        }
        else{
            cell.nome.text = filtered[indexPath.row]
        }
        cell.editar.addTarget(self, action: #selector(self.editarExamePressed(_:)), forControlEvents: .TouchUpInside)
        cell.editar.tag = indexPath.row + 1
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.stopEditing(_:)))
        cell.contentView.addGestureRecognizer(tap)
        return cell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if !searchActive
        {
        if editingStyle == .Delete {
            // Delete the row from the data source
            DaoCloudKit().deleteNomeExame(nomeExames[indexPath.row])
        }
        }
        else{
            
            if editingStyle == .Delete {
                for nome in nomeExames
                {
                    if nome.nome == filtered[indexPath.row]
                    {
                        print(nome.nome)
                        DaoCloudKit().deleteNomeExame(nome)
                        break
                    }
                }
                tableView.reloadData()
            }

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
            if searchActive
            {
                destinationVC.ArrayFiltrado = filtered
            }
            else{
                destinationVC.ArrayFiltrado = nil
            }
        }
    }
    
    func stopEditing(sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        nomeExamesString.removeAll()
        for valor in nomeExames{
            nomeExamesString.append(valor.nome)
        }
        self.tableView.reloadData()
    }

}
