//
//  Exame.swift
//  OncoManager
//
//  Created by Felipe Viberti on 7/13/16.
//  Copyright © 2016 Felipe Viberti. All rights reserved.
//

import Foundation

public class Exame
{
    var codigo:Int!
    var nome:String!
    var medico:String!
    var local:String!
    var data:String!
    var hora:String!
    var aprovado:Bool!
    var realizado:Bool!
    

    init(codigo:Int,nome:String,medico:String,local:String,data:String,hora:String,aprovado:Bool,realizado:Bool)
    {
        self.codigo = codigo
        self.nome = nome
        self.medico = medico
        self.local = local
        self.data = data
        self.hora = hora
        self.aprovado = aprovado
        self.realizado = realizado
    }
}