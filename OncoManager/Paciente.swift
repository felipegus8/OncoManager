//
//  Paciente.swift
//  OncoManager
//
//  Created by Felipe Viberti on 7/13/16.
//  Copyright © 2016 Felipe Viberti. All rights reserved.
//

import Foundation

public class Paciente
{
    var cpf:Int!
    var nome:String!
    var email:String!
    var bairro:String!
    var bairroPrefere:String!
    var dataNasc:String!
    var telefoneFixo:Int!
    var celular:Int!
    var peso:Double!
    var altura:Double!
    var alergia:Bool!
    var marcapasso:Bool!
    var clipesCirurgico:Bool!
    var operado:Bool!
    var tipoOperacao:String?
    var claustrofobico:Bool!
    var cadeirante:Bool!
    var diabetico:Bool!
    var hipertenso:Bool!
    var convenio:String!
    var tipoPlano:String!
    var matriculaPlano:String!
    var exames:[Exame] = []

    init(cpf:Int,nome:String,bairro:String,bairroPrefere:String,dataNasc:String,email:String,telefoneFixo:Int,celular:Int,peso:Double,altura:Double,alergia:Bool,marcapasso:Bool,clipesCirurgico:Bool,operado:Bool,tipoOperacao:String?,cadeirante:Bool,diabetico:Bool,hipertenso:Bool,convenio:String,tipoPlano:String,matriculaPlano:String)
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
    }
    func addExame(exame: Exame) {
        self.exames.append(exame)
    }
    func getExames() -> ([Exame])
    {
        return self.exames
    }
}