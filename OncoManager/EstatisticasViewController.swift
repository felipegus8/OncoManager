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
    
    
    var months: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chartView.delegate = self
        
        months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0, 18.0, 2.0, 4.0, 5.0, 4.0]
        
        setChart(months, values: unitsSold)
        
        // Descrição do gráfico que aparece no canto inferir direito da interface
        chartView.descriptionText = ""
        
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(yVals: dataEntries, label: "Units Sold")
        let chartData = BarChartData(xVals: months, dataSet: chartDataSet)
        chartView.data = chartData
        
        //Colocar cores nos gráficos: .liberty(), .joyful(), .pastel(), .coloful(), .vordiplom()
        chartDataSet.colors = [UIColor(red: 230/255, green: 126/255, blue: 34/255, alpha: 1)]
        //chartDataSet.colors = ChartColorTemplates.liberty()
        
        //Colocar as informações do eixo x na parte abaixo do gráfico
        chartView.xAxis.labelPosition = .Bottom
        
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

    
}
