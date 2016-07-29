//
//  NovoExameViewController.swift
//  OncoManager
//
//  Created by Gabrielle Brandenburg dos Anjos on 7/21/16.
//  Copyright © 2016 Felipe Viberti. All rights reserved.
//

import UIKit

class NovoExameViewController: UIViewController, UITextFieldDelegate {
    
    var edit = false
    var i = 0

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nomeExame: OMTextField!
    @IBOutlet weak var cadastrarButton: OMButton!
    var nomeExameNovo:NomeExame!
    var exameEditado:NomeExame!
    var ArrayFiltrado:[String]?
    var exameFiltrado:NomeExame!
   //  var activity = UIActivityIndicatorView()
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        activity = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
        activity.frame = CGRect(x: 140, y: 110, width: 50, height: 50)
        activity.hidesWhenStopped = true
        activity.activityIndicatorViewStyle = .WhiteLarge
        activity.color = UIColor.greenOM()
 */
        nomeExame.delegate = self
          NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(NovoExameViewController.actOnNotificationSuccessAddExame), name: "notificationSuccessCadastroNovoExame", object: nil)
         NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(NovoExameViewController.actOnNotificationErrorAddExame), name: "notificationErrorCadastroNovoExame", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(NovoExameViewController.actOnNotificationSuccessEditExame), name: "notificationSuccessEditNomeExame", object: nil)
       // view.addSubview(activity)
        configEditVC()
        print(titleLabel.text)
        // Do any additional setup after loading the view.
    }
    
    func configEditVC() {
        if edit {
            titleLabel.text = "EDITAR EXAME"
            if ArrayFiltrado == nil
            {
            nomeExame.text = nomeExames[i].nome
            }
            else{
                nomeExame.text = ArrayFiltrado![i]
            }
            cadastrarButton.setTitle("Alterar", forState: .Normal)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //MARK: funcoes para desligar o teclado-------------------
    //desliga pela tecla return
    func textFieldShouldReturn(textField: UITextField) -> Bool // called when 'return' key pressed. return NO to ignore.
    {
        self.view.endEditing(true)
        print(textField.placeholder)
        return false
    }
    //desliga ao tocar fora do textfield
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
    }
    // -------------------------------------------------------

    //fecha tela no 'x'
    @IBAction func closeModalPressed(sender: UIButton) {
        index = 2
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //MARK: armazenar dados no iCloud
    @IBAction func cadastrarPressed(sender: UIButton) {
        index = 2
       // activity.startAnimating()
        if nomeExame.text!.isEmpty == false
        {
        if !edit
        {
        nomeExameNovo = NomeExame(nome: nomeExame.text!)
        DaoCloudKit().addNomeExame(nomeExameNovo)
        }
        else{
        exameEditado = NomeExame(nome:nomeExame.text!)
            print(exameEditado.nome)
        if ArrayFiltrado != nil
        {
            for valor in nomeExames
            {
                if valor.nome == ArrayFiltrado![i]
                {
                    exameFiltrado = valor
                    break
                }
            }
            DaoCloudKit().editNomeExame(exameFiltrado, nameNew: exameEditado)
        }
        else
        {
        DaoCloudKit().editNomeExame(nomeExames[i], nameNew: exameEditado)
        }
        }
        }
       else
        {
            let alert=UIAlertController(title:"Erro", message: "O nome do exame é obrigatório", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title:"Ok",style: UIAlertActionStyle.Default,handler: nil))
            self.presentViewController(alert,animated: true, completion: nil)
        }
    }
    func actOnNotificationSuccessAddExame()
    {
      //  activity.stopAnimating()
        nomeExames.append(nomeExameNovo)
        dispatch_async(dispatch_get_main_queue(),{
         self.dismissViewControllerAnimated(true, completion: nil)
        })
    }
    func actOnNotificationErrorAddExame()
    {
       // activity.stopAnimating()
       // activity.hidden = true
        let alert=UIAlertController(title:"Erro", message: "Exame já existe", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title:"Ok",style: UIAlertActionStyle.Default,handler: nil))
        dispatch_async(dispatch_get_main_queue(),{
        self.presentViewController(alert,animated: true, completion: nil)
        })
    }
    func actOnNotificationSuccessEditExame()
    {
       // activity.stopAnimating()
        dispatch_async(dispatch_get_main_queue(),{
        self.dismissViewControllerAnimated(true, completion: nil)
        })

    }
}
