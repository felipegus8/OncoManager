//
//  EstatisticasViewController.swift
//  OncoManager
//
//  Created by Gabrielle Brandenburg dos Anjos on 7/13/16.
//  Copyright © 2016 Felipe Viberti. All rights reserved.
//

import UIKit
import Charts



// ********** DADOS QUE VIRÃO DO ICLOUD *********** //

var eixoX_TempoxExame = ["Exame1", "Exame2", "Exame3", "Exame4", "Exame5", "Exame6", "Raio X"]
var eixoX_PacientexPlano = ["Plano1","Plano2","Plano3","Plano4" ]
var eixoX_TempoxCirurgia = ["Cirurgia1","Cirurgi2","Cirurgia3"]

var valueX_TempoxExame = [20.0, 14.0,3.0,5.0,3.0,6.0,9.0]
var valueX_PacientexPlano = [3.0, 4.0,3.0,0.0]
var valueX_TempoxCirurgia = [10.0, 14.0,3.0]

         // ********** FIM *********** //

class EstatisticasViewController: UIViewController, ChartViewDelegate {

    @IBOutlet weak var chartView: BarChartView!
    @IBOutlet weak var graphTitleLabel: UILabel!
    
    let listGraphcs:[String] = ["Tempo x Exame", "Paciente x Plano", "Tempo x Cirurgia"]
    let vLabelEixoX: [[String]] = [eixoX_TempoxExame, eixoX_PacientexPlano, eixoX_TempoxCirurgia ]
    let vValueEixoX: [[Double]] = [ valueX_TempoxExame, valueX_PacientexPlano, valueX_TempoxCirurgia ]

    var contDias:[Double] = []
    var i = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        chartView.delegate = self
        
        //Vetor com os dados do GRAFICO 1 do aplicativo
        contDias = calculaTempoMedioDeTodosOsExames(vLabelEixoX[0], listaDeTodosOsExames: exames )
        
        //Gera o GRÁFICO 1 SEM usar iCloud
        //setChart(vLabelEixoX[0], values: vValueEixoX[0])
        
        //Gera o GRÁFICO 1 usando iCloud
        setChart(vLabelEixoX[0], values: contDias)
        graphTitleLabel.text = listGraphcs[0]
        
        // Descrição do gráfico que aparece no canto inferir direito da interface
        chartView.descriptionText = ""
        
        print("Teste do Wellington")
        for exame in exames {
            print("TABELA COM O NOME DOS EXAMES: nome: \(exame.nome), data marcado: \(exame.dataMarcado), \(exame.dataRealizado)")
        }
        
       
        
        for aux in contDias{
            print(aux)
        }
        
        for aux in nomeExames{
            print(aux.nome)
        }
        
        for aux in medicos{
            print(aux.nome)
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
        //chartDataSet.barSpace = 0.2
        
        let chartData = BarChartData(xVals: dataPoints, dataSet: chartDataSet)
        
        //Nome e tamanho da fonte do número em cima da barra
        //chartData.setValueFont(UIFont(name: "Avenir", size: 9))
        
        chartView.data = chartData
        
        //Colocar cores nos gráficos: .liberty(), .joyful(), .pastel(), .coloful(), .vordiplom()
        //chartDataSet.colors = [UIColor(red: 230/255, green: 126/255, blue: 34/255, alpha: 1)]
        //chartDataSet.colors = ChartColorTemplates.liberty()
        chartDataSet.colors = [.redColor(), .yellowColor(), .greenColor()]
        chartDataSet.colors = ChartColorTemplates.joyful()
        
        //Desabilita a leganda do Gráfico
        chartView.legend.enabled = false
        
        //Desabilita o Zoom
        chartView.scaleYEnabled = false
        chartView.scaleXEnabled = false
        chartView.pinchZoomEnabled = false
        chartView.doubleTapToZoomEnabled = false
        
        // Desabilita o Highlighter na seleção de uma barra do gráfico
        //chartView.highlighter = nil
        
        //Reduz o número de informações no eixo Y do gráfico
        chartView.rightAxis.enabled = false
        chartView.xAxis.drawGridLinesEnabled = false
        
        //Colocar as informações do eixo x na parte abaixo do gráfico
        chartView.xAxis.labelPosition = .Bottom
        chartView.xAxis.labelRotationAngle = -50
        
        //Mostrar todas as variáveis do eixo X
        chartView.xAxis.setLabelsToSkip(0)
        
        //Valor mínimo de um gráfico
        chartView.leftAxis.axisMinValue = 0.0
        
        //Colocar cor no plano de fundo do gráfico:
        chartView.backgroundColor = UIColor(red: 189/255, green: 195/255, blue: 199/255, alpha: 1)
        
        //Colocar animação no gráfico.
        chartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
        //Mais opções em - SÓ QUE ESSA TA DANDO PROBLEMA:http://www.appcoda.com/ios-charts-api-tutorial/
        //barChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .EaseInOutElastic)
        
        
        
        //Adicionar uma LINHA LIMITE no gráfico
        //let ll = ChartLimitLine(limit: 10.0, label: "Target")
        //chartView.rightAxis.addLimitLine(ll)
        
    }
    
    @IBAction func nextGraphFunction(sender: AnyObject) {
        
        if i < listGraphcs.count - 1{
            
            
            if i < listGraphcs.count - 1 && i >= 0 {
                i = i + 1
            }
            graphTitleLabel.text = listGraphcs[i]
            //Dados para teste
            //setChart(vLabelEixoX[i], values: vValueEixoX[i])
            
            //Dados do iCloud
            contDias = calculaTempoMedioDeTodosOsExames(vLabelEixoX[i], listaDeTodosOsExames: exames )
            setChart(vLabelEixoX[i], values: contDias)
        
        }

    }
    
    @IBAction func backGraphFunction(sender: AnyObject) {
        
        if i > 0 {
            
            i = i - 1
            graphTitleLabel.text = listGraphcs[i]
            //Dados para teste
            //setChart(vLabelEixoX[i], values: vValueEixoX[i])
            
            //Dados do iCloud
            contDias = calculaTempoMedioDeTodosOsExames(vLabelEixoX[i], listaDeTodosOsExames: exames )
            setChart(vLabelEixoX[i], values: contDias)
        }
    }
    
    func calculaTempoMedioDeTodosOsExames(listaDeExames: [String], listaDeTodosOsExames: [Exame] ) -> [Double] {
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
            var index = listaDeExames.indexOf(exame.nome)
            if index != nil {
            if exame.tipoProcedimento == "Exame" || exame.tipoProcedimento == "Consulta" || exame.tipoProcedimento == "Cirurgia" {
                
                diffDateComponents = NSCalendar.currentCalendar().components([NSCalendarUnit.Day], fromDate: exame.dataMarcado, toDate: exame.dataRealizado, options: NSCalendarOptions.init(rawValue: 0))
                
                totDias = Double(diffDateComponents.day)
                
                contTempo[index!] = totDias + contTempo[index!]
                contVezes[index!] = contVezes[index!] + 1
            }
            }
            
        }
        
        for i in 0..<listaDeExames.count{
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
 
 
 
