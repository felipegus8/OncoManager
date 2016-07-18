//
//  Exame.swift
//  OncoManager
//
//  Created by Felipe Viberti on 7/13/16.
//  Copyright © 2016 Felipe Viberti. All rights reserved.
//

import Foundation
public var nomeExames:[NomeExame] = []
public var exames:[Exame] = []
public var examesDoPaciente:[Exame] = []
public class Exame
{
    var cpf:Int!
    var codigo:Int!
    var nome:String!
    var medico:String!
    var local:String!
    var dataMarcado:NSDate!
    var dataRealizado:NSDate!
    var aprovado:Int!
    var realizado:Int!
    

    init(cpf:Int,codigo:Int,nome:String,medico:String,local:String,dataMarcado:NSDate,dataRealizado:NSDate,aprovado:Int,realizado:Int)
    {
        self.cpf = cpf
        self.codigo = codigo
        self.nome = nome
        self.medico = medico
        self.local = local
        self.dataMarcado = dataMarcado
        self.dataRealizado = dataRealizado
       // self.hora = hora
        self.aprovado = aprovado
        self.realizado = realizado
    }
}
public class NomeExame
{
    var nome:String!
    init(nome:String)
    {
        self.nome = nome
    }
}