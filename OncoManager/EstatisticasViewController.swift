//
//  EstatisticasViewController.swift
//  OncoManager
//
//  Created by Gabrielle Brandenburg dos Anjos on 7/13/16.
//  Copyright © 2016 Felipe Viberti. All rights reserved.
//

import UIKit
import Charts

class EstatisticasViewController: UIViewController, ChartViewDelegate {

    @IBOutlet weak var chartView: BarChartView!
    @IBOutlet weak var graphTitleLabel: UILabel!
    
    let listGraphcs:[String] = ["Paciente x Plano","Paciente x Cirurgia","Paciente x Exame", "Paciente x Médico", "Paciente x Hospital"]
    var i = 0
    var months: [String] = ["Raio X", "Raio Y", "TesteConsulta"]
    let points: [[Double]] = [ [20, 14,3], [3, 4,3], [10, 14,3],[10, 14,3],[10, 14,3] ]
    var contDias:[Double] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        chartView.delegate = self
        
        //contDias = calculaTempoMedioDeTodosOsExames(months, listaDeTodosOsExames: exames )
        
        setChart(months, values: points[0])
        graphTitleLabel.text = listGraphcs[0]
        
        // Descrição do gráfico que aparece no canto inferir direito da interface
        chartView.descriptionText = ""
        
        
        for exame in exames {
            print("TABELA COM O NOME DOS EXAMES: \(exame.nome), \(exame.tipoProcedimento)")
        }
        
       
        
        for aux in contDias{
            print(aux)
        }
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(yVals: dataEntries, label: "Meses")
        
        //Largura das barras do gráfico
        chartDataSet.barSpace = 0.2
        
        let chartData = BarChartData(xVals: months, dataSet: chartDataSet)
        
        //Nome e tamanho da fonte do número em cima da barra
        chartData.setValueFont(UIFont(name: "Avenir", size: 9))
        
        chartView.data = chartData
        
        //Colocar cores nos gráficos: .liberty(), .joyful(), .pastel(), .coloful(), .vordiplom()
        chartDataSet.colors = [UIColor(red: 230/255, green: 126/255, blue: 34/255, alpha: 1)]
        //chartDataSet.colors = ChartColorTemplates.liberty()
        
        //Colocar as informações do eixo x na parte abaixo do gráfico
        chartView.xAxis.labelPosition = .Bottom
        chartView.xAxis.labelRotationAngle = 80
        
        //Colocar cor no plano de fundo do gráfico:
        chartView.backgroundColor = UIColor(red: 189/255, green: 195/255, blue: 199/255, alpha: 1)
        
        //Colocar animação no gráfico.
        chartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
        //Mais opções em - SÓ QUE ESSA TA DANDO PROBLEMA:http://www.appcoda.com/ios-charts-api-tutorial/
        //barChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .EaseInOutElastic)
        
        
        
        //Adicionar uma LINHA LIMITE no gráfico
        let ll = ChartLimitLine(limit: 10.0, label: "Target")
        chartView.rightAxis.addLimitLine(ll)
        
    }
    
    @IBAction func nextGraphFunction(sender: AnyObject) {
        
        if i < listGraphcs.count - 1{
            
            
            if i < listGraphcs.count - 1 && i >= 0 {
                i = i + 1
            }
            graphTitleLabel.text = listGraphcs[i]
            setChart(months, values: points[i])
        }

    }
    
    @IBAction func backGraphFunction(sender: AnyObject) {
        
        if i > 0 {
            
            i = i - 1
            graphTitleLabel.text = listGraphcs[i]
            setChart(months, values: points[i])
        }
    }
    
    func calculaTempoMedioDeTodosOsExames(listaDeExames: [String], listaDeTodosOsExames: [Exame] ) -> [Double] {
        var index = 0
        var totDias: Double!
        var contTempo:  [Double] = []
        var contVezes: [Double] = []
        var diffDateComponents: NSDateComponents!
        
        //Inicializa os vetores contadormédiodedias e qtddevezesdeummesmoexame
        for i in 0..<listaDeExames.count{
            
            contTempo.append(0)
            contVezes.append(0)
        }
        
        for exame in listaDeTodosOsExames {
            
            //indice do vetor acumulador
            index = listaDeExames.indexOf(exame.nome)!
            
            if exame.tipoProcedimento == "Exame" || exame.tipoProcedimento == "Consulta" || exame.tipoProcedimento == "Cirurgia" {
                
                diffDateComponents = NSCalendar.currentCalendar().components([NSCalendarUnit.Day], fromDate: exame.dataMarcado, toDate: exame.dataRealizado, options: NSCalendarOptions.init(rawValue: 0))
                
                totDias = Double(diffDateComponents.day)
                
                contTempo[index] = totDias + contTempo[index]
                contVezes[index] = contVezes[index] + 1
            }
            
        }
        
        for i in 1..<listaDeExames.count{
            if contVezes[i] == 0{
                contTempo[i] = 0
            }
            else{
                contTempo[i] = contTempo[i]/contVezes[i]
            }
        }
        
        return contTempo
    }

    
        
}
 
