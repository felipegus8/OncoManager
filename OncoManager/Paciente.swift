//
//  Paciente.swift
//  OncoManager
//
//  Created by Felipe Viberti on 7/13/16.
//  Copyright © 2016 Felipe Viberti. All rights reserved.
//

import Foundation
import CloudKit
public var pacientes:[Paciente] = []
public var pacienteSelecionado:Paciente!

public class Paciente
{
    var cpf:Double!
    var nome:String!
    var email:String!
    var bairro:String!
    var bairroPrefere:String!
    var dataNasc:String!
    var telefoneFixo:Double!
    var celular:Double!
    var peso:Double!
    var altura:Double!
    var alergia:Int!
    var marcapasso:Int!
    var clipesCirurgico:Int!
    var operado:Int!
    var tipoOperacao:String?
    var claustrofobico:Int!
    var cadeirante:Int!
    var diabetico:Int!
    var hipertenso:Int!
    var convenio:String!
    var tipoPlano:String!
    var matriculaPlano:String!
   // var exames:[Exame] = []
   // var arrayExames:[CKReference] = []
    
    init(cpf:Double,nome:String,bairro:String,bairroPrefere:String,dataNasc:String,email:String,telefoneFixo:Double,celular:Double,peso:Double,altura:Double,alergia:Int,marcapasso:Int,clipesCirurgico:Int,operado:Int,tipoOperacao:String?,cadeirante:Int,diabetico:Int,hipertenso:Int,convenio:String,tipoPlano:String,matriculaPlano:String,claustrofobico:Int)
    {
        self.cpf = cpf
        self.nome = nome
        self.bairro = bairro
        self.bairroPrefere = bairroPrefere
        self.email = email
        self.dataNasc = dataNasc
        self.telefoneFixo = telefoneFixo
        self.celular = celular
        self.peso = peso
        self.altura = altura
        self.alergia = alergia
        self.cadeirante = cadeirante
        self.marcapasso = marcapasso
        self.cadeirante = cadeirante
        self.hipertenso = hipertenso
        self.diabetico = diabetico
        self.clipesCirurgico = clipesCirurgico
        self.operado = operado
        self.tipoOperacao = tipoOperacao
        self.convenio = convenio
        self.tipoPlano = tipoPlano
        self.matriculaPlano = matriculaPlano
        self.claustrofobico = claustrofobico
    }
   /* func addExame(exame: Exame) {
        self.exames.append(exame)
    }
    func getExames() -> ([Exame])
    {
        return self.exames
    }
 */
}
func isValidEmail(testStr:String) -> Bool {
    
    let emailRegEx = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailTest.evaluateWithObject(testStr)
}