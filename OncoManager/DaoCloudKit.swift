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
        let recordId = CKRecordID(recordName:(String(exame.nome) + String(exame.cpf) + (exame.dataRealizado.convertNsDateToStringWithoutHour())))
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
                            NSNotificationCenter.defaultCenter().postNotificationName("notificationSuccessCadastroExame", object: nil)
                        }
                    })
                }
                else{
                    
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
                NSNotificationCenter.defaultCenter().postNotificationName("notificationErrorCadastroNovoExame", object: nil)
                
            }
                
            else {
                
                if(fetchedRecord == nil) {

                    print("primeira vez que ta criando o exame")
                    record.setObject(nome.nome, forKey: "nome")
                    
                    
                    publicDatabase.saveRecord(record, completionHandler: { (record, error) -> Void in
                        if (error != nil) {
                            print(error)
                        }
                        else{
                            NSNotificationCenter.defaultCenter().postNotificationName("notificationSuccessCadastroNovoExame", object: nil)
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
                    record.setObject(medico.especialidade, forKey: "especialidade")
                    publicDatabase.saveRecord(record, completionHandler: { (record, error) -> Void in
                        if (error != nil) {
                            print(error)
                        }
                        else{
                            NSNotificationCenter.defaultCenter().postNotificationName("notificationSuccessCadastroMedico", object: nil)
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
                            print("senha errada")
                            NSNotificationCenter.defaultCenter().postNotificationName("notificationErrorPassword", object: nil)
                            return
                        }
                    }
                }
                print("Email não existe")
                NSNotificationCenter.defaultCenter().postNotificationName("notificationErrorEmail", object: nil)
            }
        }
    }
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
                    let pacienteNovo = Paciente(cpf: result.valueForKey("cpf") as! Double, nome: result.valueForKey("nome") as! String, bairro: result.valueForKey("bairro") as! String, bairroPrefere: result.valueForKey("bairroPrefere") as! String, dataNasc: result.valueForKey("dataNasc") as! String, email: result.valueForKey("email") as! String, telefoneFixo: result.valueForKey("telefoneFixo") as! Double, celular: result.valueForKey("celular") as! Double, peso: result.valueForKey("peso") as! Double, altura: result.valueForKey("altura") as! Double, alergia: result.valueForKey("alergia") as! Int, marcapasso: result.valueForKey("marcapasso") as! Int, clipesCirurgico: result.valueForKey("clipesCirurgico") as! Int, operado: result.valueForKey("operado") as! Int, tipoOperacao: result.valueForKey("tipoOperacao") as? String, cadeirante: result.valueForKey("cadeirante") as! Int, diabetico: result.valueForKey("diabetico") as! Int, hipertenso: result.valueForKey("hipertenso") as! Int, convenio: result.valueForKey("convenio") as! String, tipoPlano: result.valueForKey("tipoPlano") as! String, matriculaPlano: result.valueForKey("matriculaPlano") as! String, claustrofobico: result.valueForKey("claustrofobico") as! Int)
                    
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
                      let novoExame = NomeExame(nome: result.valueForKey("nome") as! String)
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
                let formatter = NSDateFormatter()
                formatter.dateFormat = "dd/MM/yyyy - HH:mm"
                formatter.timeZone = NSTimeZone(forSecondsFromGMT: 10800)
                for result in results! {
                    let dataRealString = ((result.valueForKey("dataRealizado") as! NSDate)).consertaHorarioDeVerao()
                   let dataRealizadoCerto = formatter.dateFromString(dataRealString)
                    let dataMarcadoString = ((result.valueForKey("dataMarcado") as! NSDate)).consertaHorarioDeVerao()
                    let dataMarcadoCerto = formatter.dateFromString(dataMarcadoString)
                    print(dataRealizadoCerto)
                    let novoExame = Exame(tipoProcedimento: result.valueForKey("tipo") as! String,cpf: result.valueForKey("cpf") as! Double,nome: result.valueForKey("nome") as! String, medico: result.valueForKey("medico") as! String, local: result.valueForKey("local") as! String,dataMarcado:dataMarcadoCerto!, dataRealizado: dataRealizadoCerto!, realizado: result.valueForKey("realizado") as! Int)
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
                    let novoMedico = Medico(nome: result.valueForKey("nome") as! String, email: result.valueForKey("email") as! String, crm: result.valueForKey("crm") as! Double, especialidade:result.valueForKey("especialidade") as! String,telefone: result.valueForKey("telefone") as? Double)
                    
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
    
    //MARK: Edit Functions
    func editExame(exameOld:Exame,exameNew:Exame)
    {
        let recordId = CKRecordID(recordName: (String(exameOld.nome) + String(exameOld.cpf) + (exameOld.dataRealizado.convertNsDateToStringWithoutHour())))
        print(recordId.recordName)
        let container = CKContainer.defaultContainer()
        let publicDatabase = container.publicCloudDatabase
        var i = 0
        publicDatabase.fetchRecordWithID(recordId) { (fetchedRecord,error) in
            
            if error == nil {
                
                print("Já existe esse paciente")
                for valor in exames
                {
                    if valor.nome == exameOld.nome && valor.cpf == exameOld.cpf && valor.dataRealizado.convertNsDateToStringWithoutHour() == exameOld.dataRealizado.convertNsDateToStringWithoutHour()
                    {
                        exames[i] = exameNew
                        break
                    }
                    i += 1
                }
                fetchedRecord!.setObject(exameNew.tipoProcedimento, forKey: "tipo")
                 fetchedRecord!.setObject(exameNew.cpf, forKey: "cpf")
                 fetchedRecord!.setObject(exameNew.dataRealizado, forKey: "dataRealizado")
                 fetchedRecord!.setObject(exameNew.dataMarcado, forKey: "dataMarcado")
                 fetchedRecord!.setObject(exameNew.nome, forKey: "nome")
                 fetchedRecord!.setObject(exameNew.local, forKey: "local")
                 fetchedRecord!.setObject(exameNew.medico, forKey: "medico")
                 fetchedRecord!.setObject(exameNew.realizado, forKey: "realizado")
                
                publicDatabase.saveRecord(fetchedRecord!, completionHandler: { (record, error) -> Void in
                    if (error != nil) {
                        print(error)
                    }
                    else{
                        NSNotificationCenter.defaultCenter().postNotificationName("notificationSuccessEditExame", object: nil)
                    }

            })
            }
            else {
                
                if(fetchedRecord == nil) {
                    print(error)
                    
                    NSNotificationCenter.defaultCenter().postNotificationName("notificationErrorEditExame", object: nil)
                    
            }
            }
        }

    }
    func editPaciente(pacienteOld:Paciente,pacienteNew:Paciente)
    {
        let recordId = CKRecordID(recordName: String(pacienteOld.cpf))
       // print(String(Int(paciente.cpf)))
        let container = CKContainer.defaultContainer()
        let publicDatabase = container.publicCloudDatabase
        var i = 0
        publicDatabase.fetchRecordWithID(recordId) { (fetchedRecord,error) in
            
            if error == nil {
                
                print("Já existe esse paciente")
                for valor in pacientes
                {
                    if valor.cpf == pacienteOld.cpf
                    {
                        pacientes[i] = pacienteOld
                        break
                    }
                    i+=1
                }
                fetchedRecord!.setObject(pacienteNew.cpf, forKey: "cpf")
                fetchedRecord!.setObject(pacienteNew.nome, forKey: "nome")
                fetchedRecord!.setObject(pacienteNew.email, forKey: "email")
                fetchedRecord!.setObject(pacienteNew.alergia, forKey: "alergia")
                fetchedRecord!.setObject(pacienteNew.altura, forKey: "altura")
                fetchedRecord!.setObject(pacienteNew.peso, forKey: "peso")
                fetchedRecord!.setObject(pacienteNew.bairro, forKey: "bairro")
                fetchedRecord!.setObject(pacienteNew.bairroPrefere, forKey: "bairroPrefere")
                fetchedRecord!.setObject(pacienteNew.cadeirante, forKey: "cadeirante")
                fetchedRecord!.setObject(pacienteNew.celular, forKey: "celular")
                fetchedRecord!.setObject(pacienteNew.claustrofobico, forKey: "claustrofobico")
                fetchedRecord!.setObject(pacienteNew.clipesCirurgico, forKey: "clipesCirurgico")
                fetchedRecord!.setObject(pacienteNew.convenio, forKey: "convenio")
                fetchedRecord!.setObject(pacienteNew.dataNasc, forKey: "dataNasc")
                fetchedRecord!.setObject(pacienteNew.diabetico, forKey: "diabetico")
                fetchedRecord!.setObject(pacienteNew.hipertenso, forKey: "hipertenso")
                fetchedRecord!.setObject(pacienteNew.marcapasso, forKey: "marcapasso")
                fetchedRecord!.setObject(pacienteNew.matriculaPlano, forKey: "matriculaPlano")
                fetchedRecord!.setObject(pacienteNew.operado, forKey: "operado")
                fetchedRecord!.setObject(pacienteNew.tipoOperacao, forKey: "tipoOperacao")
                fetchedRecord!.setObject(pacienteNew.tipoPlano, forKey: "tipoPlano")
                fetchedRecord!.setObject(pacienteNew.telefoneFixo, forKey: "telefoneFixo")
                fetchedRecord!.setObject(pacienteNew.matriculaPlano, forKey: "matriculaPlano")
                

                
                publicDatabase.saveRecord(fetchedRecord!, completionHandler: { (record, error) -> Void in
                    if (error != nil) {
                        print(error)
                    }
                    else{
                        NSNotificationCenter.defaultCenter().postNotificationName("notificationSuccessEditPaciente", object: nil)
                    }
                    
                })
            }
            else {
                
                if(fetchedRecord == nil) {
                    print(error)
                    
            NSNotificationCenter.defaultCenter().postNotificationName("notificationErrorEditPaciente", object: nil)
                    
                }
            }
        }

    }
    func editNomeExame(nameOld:NomeExame,nameNew:NomeExame)
    {
        let recordId = CKRecordID(recordName: nameOld.nome)
        let container = CKContainer.defaultContainer()
        let publicDatabase = container.publicCloudDatabase
        var i = 0
        publicDatabase.fetchRecordWithID(recordId) { (fetchedRecord,error) in
            
            if error == nil {
                
                print("Já existe esse paciente")
                for valor in nomeExames
                {
                    if valor.nome == nameOld.nome
                    {
                        nomeExames[i] = nameNew
                        break
                    }
                    i += 1
                }
                fetchedRecord!.setObject(nameNew.nome, forKey: "nome")
                publicDatabase.saveRecord(fetchedRecord!, completionHandler: { (record, error) -> Void in
                    if (error != nil) {
                        print(error)
                    }
                    else{
                        NSNotificationCenter.defaultCenter().postNotificationName("notificationSuccessEditNomeExame", object: nil)
                    }
                    
                })
            }
            else {
                
                if(fetchedRecord == nil) {
                    print(error)
                    
                    NSNotificationCenter.defaultCenter().postNotificationName("notificationErrorEditNomeExame", object: nil)
                    
                }
            }
        }

    }
    func editMedico(medicoOld:Medico,medicoNew:Medico)
    {
        let recordId = CKRecordID(recordName: medicoOld.email)
        let container = CKContainer.defaultContainer()
        let publicDatabase = container.publicCloudDatabase
        var i = 0
        publicDatabase.fetchRecordWithID(recordId) { (fetchedRecord,error) in
            
            if error == nil {
                
                print("Já existe esse paciente")
                for valor in medicos
                {
                    if valor.email == medicoOld.email
                    {
                        medicos[i] = medicoNew
                        break
                    }
                    i += 1
                }
                fetchedRecord!.setObject(medicoNew.nome, forKey: "nome")
                 fetchedRecord!.setObject(medicoNew.crm, forKey: "crm")
                 fetchedRecord!.setObject(medicoNew.especialidade, forKey: "especialidade")
                 fetchedRecord!.setObject(medicoNew.telefone, forKey: "telefone")
                 fetchedRecord!.setObject(medicoNew.email, forKey: "email")
                publicDatabase.saveRecord(fetchedRecord!, completionHandler: { (record, error) -> Void in
                    if (error != nil) {
                        print(error)
                    }
                    else{
                        NSNotificationCenter.defaultCenter().postNotificationName("notificationSuccessEditMedico", object: nil)
                    }
                    
                })
            }
            else {
                
                if(fetchedRecord == nil) {
                    print(error)
                    
                    NSNotificationCenter.defaultCenter().postNotificationName("notificationErrorEditMedico", object: nil)
                    
                }
            }
        }

    }
    //MARK:Delete Functions
    
    func deletePaciente(paciente:Paciente)
    {
        let recordId = CKRecordID(recordName: String(paciente.cpf))
        let container = CKContainer.defaultContainer()
        let publicDatabase = container.publicCloudDatabase
        var i = 0
        for valor in pacientes
        {
            if valor.cpf == paciente.cpf
            {
                pacientes.removeAtIndex(i)
                break
            }
            i += 1
        }
       publicDatabase.deleteRecordWithID(recordId) { (fetchedRecord,error) in
        if error == nil{
            NSNotificationCenter.defaultCenter().postNotificationName("notificationSucessDeletePaciente", object: nil)
        }
        else{
            NSNotificationCenter.defaultCenter().postNotificationName("notificationErrorDeletePaciente", object: nil)

        }
        }
    }
    func deleteExame(exame:Exame)
    {
        let recordId = CKRecordID(recordName: (String(exame.nome) + String(exame.cpf) + (exame.dataRealizado.convertNsDateToStringWithoutHour())))
        let container = CKContainer.defaultContainer()
        let publicDatabase = container.publicCloudDatabase
        var i = 0
        for valor in exames
        {
            if valor.nome == exame.nome && valor.cpf == exame.cpf && valor.dataRealizado.convertNsDateToStringWithoutHour() == exame.dataRealizado.convertNsDateToStringWithoutHour()
            {
                exames.removeAtIndex(i)
                break
            }
            i += 1
        }
        publicDatabase.deleteRecordWithID(recordId) { (fetchedRecord,error) in
            if error == nil{
                NSNotificationCenter.defaultCenter().postNotificationName("notificationSucessDeleteExame", object: nil)
            }
            else{
                print(error)
                NSNotificationCenter.defaultCenter().postNotificationName("notificationErrorDeleteExame", object: nil)
                
            }
        }
    }
    func deleteNomeExame(nome:NomeExame)
    {
        let recordId = CKRecordID(recordName:nome.nome)
        let container = CKContainer.defaultContainer()
        let publicDatabase = container.publicCloudDatabase
        var i = 0
        for valor in nomeExames
        {
            if valor.nome == nome.nome
            {
                nomeExames.removeAtIndex(i)
                break
            }
            i += 1
        }
        publicDatabase.deleteRecordWithID(recordId) { (fetchedRecord,error) in
            if error == nil{
                NSNotificationCenter.defaultCenter().postNotificationName("notificationSucessDeleteNomeExame", object: nil)
            }
            else{
                NSNotificationCenter.defaultCenter().postNotificationName("notificationErrorDeleteNomeExame", object: nil)
                
            }
        }
    }
    func deleteMedico(medico:Medico)
    {
        let recordId = CKRecordID(recordName: medico.email)
        let container = CKContainer.defaultContainer()
        let publicDatabase = container.publicCloudDatabase
        var i = 0
        for valor in medicos
        {
            if valor.email == medico.email
            {
                medicos.removeAtIndex(i)
                break
            }
            i += 1
        }
        publicDatabase.deleteRecordWithID(recordId) { (fetchedRecord,error) in
            if error == nil{
                NSNotificationCenter.defaultCenter().postNotificationName("notificationSucessDeleteMedico", object: nil)
            }
            else{
                NSNotificationCenter.defaultCenter().postNotificationName("notificationErrorDeleteMedico", object: nil)
                
            }
        }

    }
}