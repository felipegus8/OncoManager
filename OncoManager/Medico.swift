//
//  Medico.swift
//  OncoManager
//
//  Created by Felipe Viberti on 7/13/16.
//  Copyright © 2016 Felipe Viberti. All rights reserved.
//

import Foundation

public var medicos:[Medico] = []
public class Medico
{
    var nome:String!
    var email: String!
    var crm: Int!
    var telefone: Int?
    
    init(nome: String, email: String, crm: Int,telefone:Int?) {
        
        self.nome = nome
        self.email = email
        self.crm = crm
        self.telefone = telefone
    }
}