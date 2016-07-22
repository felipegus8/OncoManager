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
    var tipoProcedimento:String!
    var cpf:Double!
    var nome:String!
    var medico:String!
    var local:String!
    var dataMarcado:NSDate!
    var dataRealizado:NSDate!
    var realizado:Int!
    

    init(tipoProcedimento:String,cpf:Double,nome:String,medico:String,local:String,dataMarcado:NSDate,dataRealizado:NSDate,realizado:Int)
    {
        self.tipoProcedimento = tipoProcedimento
        self.cpf = cpf
        self.nome = nome
        self.medico = medico
        self.local = local
        self.dataMarcado = dataMarcado
        self.dataRealizado = dataRealizado
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