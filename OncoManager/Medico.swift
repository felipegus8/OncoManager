//
//  Medico.swift
//  OncoManager
//
//  Created by Felipe Viberti on 7/13/16.
//  Copyright © 2016 Felipe Viberti. All rights reserved.
//

import Foundation
// DaoCloudKit().addAdmin(Admin(email: "Teste", senha: "qualquer", nome: "Teste"))
let testeExame =  Exame(codigo: 8, nome: "TesteExame", medico: "Testando", local: "Copa", data: "23-08-2016", hora: "17:00", aprovado: 0, realizado: 1)
let testePaciente = Paciente(cpf: 16798089766, nome: "Teste", bairro: "Magé", bairroPrefere: "Niteroi", dataNasc: "26-09-1962", email: "qualquer", telefoneFixo: 2345980135, celular: 346725789, peso: 78, altura: 1.70, alergia: 0, marcapasso: 0, clipesCirurgico: 0, operado: 0, tipoOperacao: nil, cadeirante: 0, diabetico: 1, hipertenso: 0, convenio: "Assim", tipoPlano: "Ruim", matriculaPlano: "12345",claustrofobico:0)
//DaoCloudKit().addPaciente(testePaciente)
//DaoCloudKit().addExameToPaciente(testeExame, paciente: testePaciente)

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