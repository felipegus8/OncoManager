//
//  DadosPacienteTableView.swift
//  OncoManager
//
//  Created by Gabrielle Brandenburg dos Anjos on 7/14/16.
//  Copyright © 2016 Felipe Viberti. All rights reserved.
//

import UIKit

class DadosPacienteCell: UITableViewCell {
    
    var category = UILabel()
    var answer = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setupViews(){
        category.text = "Category:"
        category.translatesAutoresizingMaskIntoConstraints = false
        category.textColor = UIColor(red:0.00, green:0.47, blue:0.24, alpha:1.0)
        addSubview(category)

        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : category]))
        
        answer.text = "Answer"
        answer.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(answer)
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : answer]))
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-16-[v0]-8-[v1]-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : category, "v1": answer]))
        
    }
    
}


class DadosPacienteTableView: UITableViewController {
    
    let categories = ["CPF:", "Nascimento:", "E-mail:", "Bairro:", "Tel:", "Cel:", "Convênio:", "Tipo de Plano:", "Matrícula Plano:", "Peso:", "Altura:", "Marca-passo:", "Clipes Cirúrgicos:", "Operado:", "Operação:", "Claustrofóbico:", "Cadeirante:", "Diabético:", "Hipertenso:"]

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.registerClass(DadosPacienteCell.self, forCellReuseIdentifier: "DadoCell")
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categories.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("DadoCell", forIndexPath: indexPath) as! DadosPacienteCell
        
        cell.category.text = categories[indexPath.row]
        switch indexPath.row {
        case 0:
            cell.answer.text = String(pacienteSelecionado.cpf)
        case 1:
            cell.answer.text = pacienteSelecionado.dataNasc
        case 2:
            cell.answer.text = pacienteSelecionado.email
        case 3:
            cell.answer.text = pacienteSelecionado.bairro
        case 4:
            cell.answer.text = String(pacienteSelecionado.telefoneFixo)
        case 5:
            cell.answer.text = String(pacienteSelecionado.celular)
        case 6:
            cell.answer.text = pacienteSelecionado.convenio
        case 7:
            cell.answer.text = pacienteSelecionado.tipoPlano
        case 8:
            cell.answer.text = pacienteSelecionado.matriculaPlano
        case 9:
            cell.answer.text = String(pacienteSelecionado.peso)
        case 10:
            cell.answer.text = String(pacienteSelecionado.altura)
        case 11:
//            if pacienteSelecionado.marcapasso == 0
//            {
//                cell.answer.text = "Não"
//            }
//            else
//            {
//                cell.answer.text = "Sim"
//            }
            cell.answer.text = (pacienteSelecionado.marcapasso == 1) ? "Sim" : "Não"
            
        case 12:
            cell.answer.text = (pacienteSelecionado.clipesCirurgico == 1) ? "Sim" : "Não"
            
        case 13:
            cell.answer.text = (pacienteSelecionado.operado == 1) ? "Sim" : "Não"
            
        case 14:
            cell.answer.text = (pacienteSelecionado.operado == 1) ? pacienteSelecionado.tipoOperacao : "-"
            
        case 15:
            cell.answer.text = (pacienteSelecionado.claustrofobico == 1) ? "Sim" : "Não"
            
        case 16:
           cell.answer.text = (pacienteSelecionado.cadeirante == 1) ? "Sim" : "Não"
            
        case 17:
           cell.answer.text = (pacienteSelecionado.diabetico == 1) ? "Sim" : "Não"
            
        case 18:
            cell.answer.text = (pacienteSelecionado.hipertenso == 1) ? "Sim" : "Não"
            
        default:
            cell.answer.text = "Oi"
            
        }
        // Configure the cell...

        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
