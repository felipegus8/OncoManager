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
    var sobrenome:String!
    var email:String!
    var RG:String!
    var telefoneFixo:Int!
    var celular:Int!
    var peso:Double!
    var altura:Double!
    var alergia:Bool!
    var tipoAlergia:String?
    var deficiente:Bool!
    var tipoDeficiencia:String?
    var metal:Bool!
    

    init(cpf:Int,nome:String,sobrenome:String,email:String,RG:String,telefoneFixo:Int,celular:Int,peso:Double,altura:Double,alergia:Bool,tipoAlergia:String?,deficiente:Bool,tipoDeficiencia:String?,metal:Bool)
    {
        self.cpf = cpf
        self.nome = nome
        self.sobrenome = sobrenome
        self.email = email
        self.RG = RG
        self.telefoneFixo = telefoneFixo
        self.celular = celular
        self.peso = peso
        self.altura = altura
        self.alergia = alergia
        self.tipoAlergia = tipoAlergia
        self.deficiente = deficiente
        self.tipoDeficiencia = tipoDeficiencia
        self.metal = metal
    }
}