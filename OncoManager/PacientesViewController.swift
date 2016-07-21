//
//  PacientesViewController.swift
//  OncoManager
//
//  Created by Gabrielle Brandenburg dos Anjos on 7/13/16.
//  Copyright © 2016 Felipe Viberti. All rights reserved.
//

import UIKit

class PacientesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,UISearchBarDelegate
{
    
    @IBOutlet weak var listaPacientes: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    var searchActive : Bool = false
    var filtered:[String] = []
    var nomePacientes:[String] = []
    //var selectedName = "" // nome do paciente selecionado
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        for nome in pacientes
        {
            nomePacientes.append(nome.nome)
        }
        print(nomePacientes)
        listaPacientes.delegate = self
        listaPacientes.dataSource = self
        // self.navigationController?.navigationBarHidden = true
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
        filtered = nomePacientes.filter({ (text) -> Bool in
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
        self.listaPacientes.reloadData()
    }

    //MARK: Table View Data Source
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(searchActive)
        if(searchActive) {
            return filtered.count
        }
        return pacientes.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.listaPacientes.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! ListaPacienteCell
        print(searchActive)
        if(searchActive){
            cell.nomePaciente?.text = filtered[indexPath.row]
        } else {
            cell.nomePaciente?.text = pacientes[indexPath.row].nome
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if searchActive
        {
            for nome in pacientes
            {
                if nome.nome == filtered[indexPath.row]
                {
                    pacienteSelecionado = nome
                }
            }
            examesDoPacienteSelecionado(pacienteSelecionado.cpf,paciente:pacienteSelecionado)
        }
        else{
        pacienteSelecionado = pacientes[indexPath.row]
        examesDoPacienteSelecionado(pacienteSelecionado.cpf,paciente:pacienteSelecionado)
        print(examesDoPaciente)
        }
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
        filtered.removeAll()
        searchActive = false
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
    /*
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        self.arraybusca.removeAll(keepCapacity: false)
        let predicate=NSPredicate(format:"SELF CONTAINS[c] %@", searchController.searchBar.text!)
        let array=(self.apple as NSArray).filteredArrayUsingPredicate(predicate)
        self.arraybusca=array as! [String]
        self.tableView.reloadData()
        
    }

*/
    
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
