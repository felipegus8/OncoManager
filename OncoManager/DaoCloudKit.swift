//
//  DaoCloudKit.swift
//  OncoManager
//
//  Created by Felipe Viberti on 7/13/16.
//  Copyright © 2016 Felipe Viberti. All rights reserved.
//

import Foundation
import CloudKit
let defaults = NSUserDefaults.standardUserDefaults()
public class DaoCloudKit
{
    func cloudAvailable()->(Bool)
    {
        if NSFileManager.defaultManager().ubiquityIdentityToken != nil{
            return true
        }
        else{
            return false
        }
    }
    
    //MARK:Save Functions
    
    func addAdmin(admin:Admin)
    {
        let recordId = CKRecordID(recordName: admin.email)
        let record = CKRecord(recordType: "Admin", recordID: recordId)
        let container = CKContainer.defaultContainer()
        let publicDatabase = container.publicCloudDatabase
        
        publicDatabase.fetchRecordWithID(recordId) { (fetchedRecord,error) in
            
            if error == nil {
                
                print("Já existe esse admin")
                NSNotificationCenter.defaultCenter().postNotificationName("notificationErrorCadastroAdmin", object: nil)
                
            }
                
            else {
                
                if(fetchedRecord == nil) {
                    
                    print("primeira vez que ta criando o admin")
                    record.setObject(admin.email, forKey: "email")
                    record.setObject(admin.nome, forKey: "nome")
                    record.setObject(admin.senha, forKey: "senha")
    
                    publicDatabase.saveRecord(record, completionHandler: { (record, error) -> Void in
                        if (error != nil) {
                            print(error)
                        }
                        else{
                            NSNotificationCenter.defaultCenter().postNotificationName("notificationSuccessCadastroAdmin", object: nil)
                        }
                    })
                }
            }
        }
    }
    func addExame(exame:Exame)
    {
        let recordId = CKRecordID(recordName:String(exame.codigo))
        let record = CKRecord(recordType: "Exame", recordID: recordId)
        let container = CKContainer.defaultContainer()
        let publicDatabase = container.publicCloudDatabase
        
        publicDatabase.fetchRecordWithID(recordId) { (fetchedRecord,error) in
            
            if error == nil {
                
                print("Já existe esse exame")
                NSNotificationCenter.defaultCenter().postNotificationName("notificationErrorCadastroExame", object: nil)
                
            }
                
            else {
                
                if(fetchedRecord == nil) {
                    
                    print("primeira vez que ta criando o exame")
                    record.setObject(exame.tipoProcedimento, forKey: "tipo")
                    record.setObject(exame.cpf, forKey: "cpf")
                    record.setObject(exame.codigo, forKey: "codigo")
                    record.setObject(exame.dataRealizado, forKey: "dataRealizado")
                    record.setObject(exame.dataMarcado, forKey: "dataMarcado")
                    record.setObject(exame.nome, forKey: "nome")
                    record.setObject(exame.local, forKey: "local")
                    record.setObject(exame.medico, forKey: "medico")
                    record.setObject(exame.realizado, forKey: "realizado")
                    publicDatabase.saveRecord(record, completionHandler: { (record, error) -> Void in
                        if (error != nil) {
                            print(error)
                        }
                        else{
                        }
                    })
                }
            }
        }

    }

    func addNomeExame(nome:NomeExame)
    {
        let recordId = CKRecordID(recordName:nome.nome)
        let record = CKRecord(recordType: "NomeExame", recordID: recordId)
        let container = CKContainer.defaultContainer()
        let publicDatabase = container.publicCloudDatabase
        
        publicDatabase.fetchRecordWithID(recordId) { (fetchedRecord,error) in
            
            if error == nil {
                
                print("Já existe esse exame")
                NSNotificationCenter.defaultCenter().postNotificationName("notificationErrorCadastroExame", object: nil)
                
            }
                
            else {
                
                if(fetchedRecord == nil) {

                    print("primeira vez que ta criando o exame")
                    record.setObject(nome.nome, forKey: "nome")
                    
                    
                    publicDatabase.saveRecord(record, completionHandler: { (record, error) -> Void in
                        if (error != nil) {
                            print(error)
                        }
                    })
                }
            }
        }
    }
    func addMedico(medico:Medico)
    {
        let recordId = CKRecordID(recordName: medico.email)
        let record = CKRecord(recordType: "Medico", recordID: recordId)
        let container = CKContainer.defaultContainer()
        let publicDatabase = container.publicCloudDatabase
        
        publicDatabase.fetchRecordWithID(recordId) { (fetchedRecord,error) in
            
            if error == nil {
                
                print("Já existe esse médico")
                NSNotificationCenter.defaultCenter().postNotificationName("notificationErrorCadastroMedico", object: nil)
                
            }
                
            else {
                
                if(fetchedRecord == nil) {
                    
                    print("primeira vez que ta criando o médico")
                    record.setObject(medico.email, forKey: "email")
                    record.setObject(medico.crm, forKey: "crm")
                    record.setObject(medico.nome, forKey: "nome")
                    record.setObject(medico.telefone, forKey: "telefone")
                    
                    publicDatabase.saveRecord(record, completionHandler: { (record, error) -> Void in
                        if (error != nil) {
                            print(error)
                        }
                    })
                }
            }
        }
    }

    func addPaciente(paciente:Paciente)
    {

        let recordId = CKRecordID(recordName: String(paciente.cpf))
        let record = CKRecord(recordType: "Paciente", recordID: recordId)
        let container = CKContainer.defaultContainer()
        let publicDatabase = container.publicCloudDatabase
        
        publicDatabase.fetchRecordWithID(recordId) { (fetchedRecord,error) in
            
            if error == nil {
                
                print("Já existe esse paciente")
                NSNotificationCenter.defaultCenter().postNotificationName("notificationErrorCadastroPaciente", object: nil)
                
            }
                
            else {
                
                if(fetchedRecord == nil) {
                    
                    print("primeira vez que ta criando o paciente")
                    record.setObject(paciente.cpf, forKey: "cpf")
                    record.setObject(paciente.nome, forKey: "nome")
                    record.setObject(paciente.email, forKey: "email")
                    record.setObject(paciente.alergia, forKey: "alergia")
                    record.setObject(paciente.altura, forKey: "altura")
                    record.setObject(paciente.peso, forKey: "peso")
                    record.setObject(paciente.bairro, forKey: "bairro")
                    record.setObject(paciente.bairroPrefere, forKey: "bairroPrefere")
                    record.setObject(paciente.cadeirante, forKey: "cadeirante")
                    record.setObject(paciente.celular, forKey: "celular")
                    record.setObject(paciente.claustrofobico, forKey: "claustrofobico")
                    record.setObject(paciente.clipesCirurgico, forKey: "clipesCirurgico")
                    record.setObject(paciente.convenio, forKey: "convenio")
                    record.setObject(paciente.dataNasc, forKey: "dataNasc")
                    record.setObject(paciente.diabetico, forKey: "diabetico")
                    record.setObject(paciente.hipertenso, forKey: "hipertenso")
                    record.setObject(paciente.marcapasso, forKey: "marcapasso")
                    record.setObject(paciente.matriculaPlano, forKey: "matriculaPlano")
                    record.setObject(paciente.operado, forKey: "operado")
                    record.setObject(paciente.tipoOperacao, forKey: "tipoOperacao")
                    record.setObject(paciente.tipoPlano, forKey: "tipoPlano")
                    record.setObject(paciente.telefoneFixo, forKey: "telefoneFixo")
                    record.setObject(paciente.matriculaPlano, forKey: "matriculaPlano")
                    

                    
                    publicDatabase.saveRecord(record, completionHandler: { (record, error) -> Void in
                        if (error != nil) {
                            print(error)
                        }
                        else{
                            NSNotificationCenter.defaultCenter().postNotificationName("notificationSaveSuccessPaciente", object: nil)
                        }
                    })
                }
            }
        }
    }
 /*
    func addExameToPaciente(exame:Exame,paciente:Paciente)
    {
            let container = CKContainer.defaultContainer()
            let publicDatabase = container.publicCloudDatabase
            
            let record = CKRecord(recordType: "Exame")
            let recordId = CKRecordID(recordName: String(paciente.cpf))
            
            //record.setObject(exame.codigo, forKey: "codigo")
            record.setObject(exame.data, forKey: "data")
            record.setObject(exame.nome, forKey: "nome")
            record.setObject(exame.hora, forKey: "hora")
            record.setObject(exame.local, forKey: "local")
            record.setObject(exame.medico, forKey: "medico")
            record.setObject(exame.aprovado, forKey: "aprovado")
            record.setObject(exame.realizado, forKey: "realizado")
            
            let exameReference = CKReference(recordID: record.recordID, action: .None)
            
            print("---------------------- Referencia do exame: ", exameReference)
            paciente.arrayExames.append(exameReference)
            
            
            publicDatabase.saveRecord(record, completionHandler:
                ({returnRecord, error in
                    if error != nil {
                        print(error)
                        dispatch_async(dispatch_get_main_queue()) {
                            NSNotificationCenter.defaultCenter().postNotificationName("notificationSaveError", object: nil)
                        }
                        
                    } else {
                        dispatch_async(dispatch_get_main_queue()) {
                            NSNotificationCenter.defaultCenter().postNotificationName("notificationSaveSuccess", object: nil)
                        }
                        
                    }
                }))
            
            
            container.publicCloudDatabase.fetchRecordWithID(recordId) { (fetchedRecord,error) in
                
                print(fetchedRecord)
                
                if error == nil {
                    
                    print("Already exists user!!")
                    
                    print("---------------------- Referencia dos exames: ", paciente.arrayExames)
                    fetchedRecord!.setObject(paciente.arrayExames, forKey: "exames")
                    
                    container.publicCloudDatabase.saveRecord(fetchedRecord!, completionHandler: { (record, error) -> Void in
                        if (error != nil) {
                            print(error)
                        }
                    })
                }
        }
    }
    */
    //MARK:Fetch Functions
    
    func fetchAdminByEmail(email: String!,senha: String!) {
        
        let container = CKContainer.defaultContainer()
        let publicDatabase = container.publicCloudDatabase
        let predicate = NSPredicate(value: true)
        
        let query = CKQuery(recordType: "Admin", predicate: predicate)
        
        publicDatabase.performQuery(query, inZoneWithID: nil) { (results, error) -> Void in
            if error != nil {
                print(error)
                NSNotificationCenter.defaultCenter().postNotificationName("notificationErrorInternet", object: nil)
            }
            else {
                
                for result in results! {
                    if(result.valueForKey("email") as? String == email) {
                        
                        print("Admin existe!")
                        if (result.valueForKey("senha") as? String == senha)
                        {
                            
                            //Inicializa o user Logado
                            adminLogado = Admin(email: email, senha: senha, nome: result.valueForKey("nome") as! String)
                            NSNotificationCenter.defaultCenter().postNotificationName("notificationSuccessLogin", object: nil)
                            return
                        }
                        else {
                            NSNotificationCenter.defaultCenter().postNotificationName("notificationErrorPassword", object: nil)
                            return
                        }
                    }
                }
                NSNotificationCenter.defaultCenter().postNotificationName("notificationErrorEmail", object: nil)
            }
        }
    }
    /*
    func fetchExamesFromPaciente(paciente:Paciente)
    {
        let recordId = CKRecordID(recordName: String(paciente.cpf))
        let container = CKContainer.defaultContainer()
        let publicDatabase = container.publicCloudDatabase
        
        
        var examesRecordIds = [CKRecordID]()
        
        publicDatabase.fetchRecordWithID(recordId) { (fetchedRecord,error) in
            
            // print(fetchedRecord)
            
            if error == nil {
                
                if let teste = fetchedRecord!.objectForKey("exames") {
                    print("quantidade de exames registrados: ", (teste as! [CKRecordValue]).count)
                    
                    
                    for exameReference in fetchedRecord!.objectForKey("exames") as! [CKReference] {
                        examesRecordIds.append(exameReference.recordID)
                    }
                    
                    let fetchOperation = CKFetchRecordsOperation(recordIDs: examesRecordIds)
                    fetchOperation.fetchRecordsCompletionBlock = {
                        records, error in
                        if error != nil {
                            print(error)
                            NSNotificationCenter.defaultCenter().postNotificationName("notificationErrorInternet", object: nil)
                            
                        } else {
                            
                            paciente.exames.removeAll()
                            paciente.arrayExames.removeAll()
                            
                            for (_, result) in records! {
                                print("Preenchendo os vetores")
                                if  let order = menorData
                                {
                                    if order.compare((result.creationDate)!) ==  NSComparisonResult.OrderedDescending
                                    {
                                    menorData = result.creationDate
                                    }
                                }
                                else{
                                    menorData = result.creationDate
                                }
                                paciente.arrayExames.append(CKReference(recordID: result.recordID, action: .None))
                                paciente.exames.append(Exame(codigo: result.valueForKey("codigo") as! Int, nome: result.valueForKey("nome") as! String, medico: result.valueForKey("medico") as! String, local: result.valueForKey("local") as! String, data: result.valueForKey("data") as! String, hora: result.valueForKey("hora") as! String, aprovado: result.valueForKey("aprovado") as! Int, realizado:result.valueForKey("realizado") as! Int))
                            }
                            
                            NSNotificationCenter.defaultCenter().postNotificationName("notificationSuccessLoadExamesFromPaciente", object: nil)
                            
                            
                        }
                    }
                    
                    CKContainer.defaultContainer().publicCloudDatabase.addOperation(fetchOperation)
                }
                    
                else {
                    
                    if paciente.exames.count == 0
                    {
                        NSNotificationCenter.defaultCenter().postNotificationName("notificationSuccessLoadExamesFromPaciente", object: nil)
                    }
                    else{
                        NSNotificationCenter.defaultCenter().postNotificationName("notificationErrorLoadPaciente", object: nil)
                        
                    }
                    
                }
            }
            else {
                print(error)
            }
        }
        }
    */
    func fetchPacientes()
    {
        let container = CKContainer.defaultContainer()
        let publicDatabase = container.publicCloudDatabase
        let predicate = NSPredicate(value: true)
        
        let query = CKQuery(recordType: "Paciente", predicate: predicate)
        
        publicDatabase.performQuery(query, inZoneWithID: nil) { (results, error) -> Void in
            if error != nil {
                print(error)
                NSNotificationCenter.defaultCenter().postNotificationName("notificationErrorInternet", object: nil)
            }
            else {
                pacientes.removeAll()
                for result in results! {
                    var pacienteNovo = Paciente(cpf: result.valueForKey("cpf") as! Double, nome: result.valueForKey("nome") as! String, bairro: result.valueForKey("bairro") as! String, bairroPrefere: result.valueForKey("bairroPrefere") as! String, dataNasc: result.valueForKey("dataNasc") as! String, email: result.valueForKey("email") as! String, telefoneFixo: result.valueForKey("telefoneFixo") as! Double, celular: result.valueForKey("celular") as! Double, peso: result.valueForKey("peso") as! Double, altura: result.valueForKey("altura") as! Double, alergia: result.valueForKey("alergia") as! Int, marcapasso: result.valueForKey("marcapasso") as! Int, clipesCirurgico: result.valueForKey("clipesCirurgico") as! Int, operado: result.valueForKey("operado") as! Int, tipoOperacao: result.valueForKey("tipoOperacao") as? String, cadeirante: result.valueForKey("cadeirante") as! Int, diabetico: result.valueForKey("diabetico") as! Int, hipertenso: result.valueForKey("hipertenso") as! Int, convenio: result.valueForKey("convenio") as! String, tipoPlano: result.valueForKey("tipoPlano") as! String, matriculaPlano: result.valueForKey("matriculaPlano") as! String, claustrofobico: result.valueForKey("claustrofobico") as! Int)
                    
                        pacientes.append(pacienteNovo)
                    }
                NSNotificationCenter.defaultCenter().postNotificationName("notificationSuccessPacientes", object: nil)
                }
            }
    }
    func fetchNomeExames()
    {
        let container = CKContainer.defaultContainer()
        let publicDatabase = container.publicCloudDatabase
        let predicate = NSPredicate(value: true)
        
        let query = CKQuery(recordType: "NomeExame", predicate: predicate)
        
        publicDatabase.performQuery(query, inZoneWithID: nil) { (results, error) -> Void in
            if error != nil {
                print(error)
                NSNotificationCenter.defaultCenter().postNotificationName("notificationErrorInternet", object: nil)
            }
            else {
                nomeExames.removeAll()
                for result in results! {
                      var novoExame = NomeExame(nome: result.valueForKey("nome") as! String)
                    nomeExames.append(novoExame)
                }
                NSNotificationCenter.defaultCenter().postNotificationName("notificationSuccessNomeExames", object: nil)
            }
        }

    }
    func fetchExames()
    {
        let container = CKContainer.defaultContainer()
        let publicDatabase = container.publicCloudDatabase
        let predicate = NSPredicate(value: true)
        
        let query = CKQuery(recordType: "Exame", predicate: predicate)
        
        publicDatabase.performQuery(query, inZoneWithID: nil) { (results, error) -> Void in
            if error != nil {
                print(error)
                NSNotificationCenter.defaultCenter().postNotificationName("notificationErrorInternet", object: nil)
            }
            else {
                exames.removeAll()
                for result in results! {

                    var novoExame = Exame(tipoProcedimento: result.valueForKey("tipo") as! String,cpf: result.valueForKey("cpf") as! Double, codigo: result.valueForKey("codigo") as! Int, nome: result.valueForKey("nome") as! String, medico: result.valueForKey("medico") as! String, local: result.valueForKey("local") as! String,dataMarcado:result.valueForKey("dataMarcado") as! NSDate, dataRealizado: result.valueForKey("dataRealizado") as! NSDate, realizado: result.valueForKey("realizado") as! Int)
                    print(result.valueForKey("dataRealizado") as! NSDate)
                    exames.append(novoExame)
                    
                }
                NSNotificationCenter.defaultCenter().postNotificationName("notificationSuccessExames", object: nil)
            }
        }

    }
    func fetchMedicos()
    {
        let container = CKContainer.defaultContainer()
        let publicDatabase = container.publicCloudDatabase
        let predicate = NSPredicate(value: true)
        
        let query = CKQuery(recordType: "Medico", predicate: predicate)
        
        publicDatabase.performQuery(query, inZoneWithID: nil) { (results, error) -> Void in
            if error != nil {
                print(error)
                NSNotificationCenter.defaultCenter().postNotificationName("notificationErrorInternet", object: nil)
            }
            else {
                medicos.removeAll()
                for result in results! {
                    var novoMedico = Medico(nome: result.valueForKey("nome") as! String, email: result.valueForKey("email") as! String, crm: result.valueForKey("crm") as! Double, telefone: result.valueForKey("telefone") as? Double)
                    medicos.append(novoMedico)
                }
                NSNotificationCenter.defaultCenter().postNotificationName("notificationSuccessMedicos", object: nil)
            }
        }
    }
    func fetchPacienteByCpf(cpf:Int)
    {
        let container = CKContainer.defaultContainer()
        let publicDatabase = container.publicCloudDatabase
        let predicate = NSPredicate(value: true)
        
        let query = CKQuery(recordType: "Paciente", predicate: predicate)
        
        publicDatabase.performQuery(query, inZoneWithID: nil) { (results, error) -> Void in
            if error != nil {
                print(error)
                NSNotificationCenter.defaultCenter().postNotificationName("notificationErrorInternet", object: nil)
            }
            else {
                for result in results! {
                    if result.valueForKey("cpf") as! Int == cpf
                    {
                        pacienteSelecionado = Paciente(cpf: result.valueForKey("cpf") as! Double, nome: result.valueForKey("nome") as! String, bairro: result.valueForKey("bairro") as! String, bairroPrefere: result.valueForKey("bairroPrefere") as! String, dataNasc: result.valueForKey("dataNasc") as! String, email: result.valueForKey("email") as! String, telefoneFixo: result.valueForKey("telefoneFixo") as! Double, celular: result.valueForKey("celular") as! Double, peso: result.valueForKey("peso") as! Double, altura: result.valueForKey("altura") as! Double, alergia: result.valueForKey("alergia") as! Int, marcapasso: result.valueForKey("marcapasso") as! Int, clipesCirurgico: result.valueForKey("clipesCirurgico") as! Int, operado: result.valueForKey("operado") as! Int, tipoOperacao: result.valueForKey("tipoOperacao") as? String, cadeirante: result.valueForKey("cadeirante") as! Int, diabetico: result.valueForKey("diabetico") as! Int, hipertenso: result.valueForKey("hipertenso") as! Int, convenio: result.valueForKey("convenio") as! String, tipoPlano: result.valueForKey("tipoPlano") as! String, matriculaPlano: result.valueForKey("matriculaPlano") as! String, claustrofobico: result.valueForKey("claustrofobico") as! Int)

                    }
                }
                NSNotificationCenter.defaultCenter().postNotificationName("notificationSuccessPacienteCpf", object: nil)
            }

    }
    }
}