//
//  Medico.swift
//  OncoManager
//
//  Created by Felipe Viberti on 7/13/16.
//  Copyright © 2016 Felipe Viberti. All rights reserved.
//

import Foundation

public var medicos:[Medico] = []
public var menorData:NSDate!
public class Medico
{
    var nome:String!
    var email: String!
    var crm: Double!
    var especialidade:String!
    var telefone: Double?
    
    init(nome: String, email: String, crm: Double,especialidade:String,telefone:Double?) {
        
        self.nome = nome
        self.email = email
        self.crm = crm
        self.especialidade = especialidade
        self.telefone = telefone
    }
}