//
//  Admin.swift
//  OncoManager
//
//  Created by Felipe Viberti on 7/13/16.
//  Copyright © 2016 Felipe Viberti. All rights reserved.
//

import Foundation

public class Admin
{
    var email:String!
    var senha:String!
    var nome:String!
    
    init(email:String,senha:String,nome:String)
    {
        self.email = email
        self.senha = senha
        self.nome  = nome
    }
}