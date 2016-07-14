//
//  DaoCloudKit.swift
//  OncoManager
//
//  Created by Felipe Viberti on 7/13/16.
//  Copyright © 2016 Felipe Viberti. All rights reserved.
//

import Foundation
import CloudKit

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
                    })
                }
            }
        }
    }

    func addExame(exame:Exame)
    {
        let recordId = CKRecordID(recordName: String(exame.codigo))
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
                    record.setObject(exame.codigo, forKey: "codigo")
                    record.setObject(exame.data, forKey: "data")
                    record.setObject(exame.hora, forKey: "hora")
                    record.setObject(exame.local, forKey: "local")
                    record.setObject(exame.medico, forKey: "medico")
                    record.setObject(exame.aprovado, forKey: "aprovado")
                    record.setObject(exame.realizado, forKey: "realizado")
                    
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
                    })
                }
            }
        }
    }
 
    func addExameToPaciente(exame:Exame,paciente:Paciente)
    {
        let container = CKContainer.defaultContainer()
        let publicDatabase = container.publicCloudDatabase
        
        let record = CKRecord(recordType: "Exame")
        let recordId = CKRecordID(recordName: String(paciente.cpf))
        
        record.setObject(exame.codigo, forKey: "codigo")
        record.setObject(exame.data, forKey: "data")
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
    
}