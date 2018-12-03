//
//  ViewController.swift
//  RadarChartDemo
//
//  Copyright © 2018 hajime-nakamura. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var chartView: RadarChartView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let color = UIColor(red:0.282, green:0.541, blue:0.867, alpha:0.50)
        let backgroundColor = UIColor(red:0.851, green:0.851, blue:0.941, alpha:1.00)
        let xAxisColor = UIColor(red:0.396, green:0.769, blue:0.914, alpha:1.00)
        let yAxisColor = UIColor(red:0.596, green:0.863, blue:0.945, alpha:1.50)
        let fontColor = UIColor(red:0.259, green:0.365, blue:0.565, alpha:1.00)

        chartView.data = [3, 1, 2, 1, 4, 1]
        chartView.labelTexts = ["Running", "Catching", "Rhythm", "Throwing", "Balance", "Jumping"]
        chartView.numberOfVertexes = 6
        chartView.numberTicks = 5
        chartView.style = RadarChartStyle(color: color,
                                          backgroundColor: backgroundColor,
                                          xAxis: RadarChartStyle.Axis(
                                            colors: [xAxisColor],
                                            widths: [0.5, 0.5, 0.5, 0.5, 2.0]),
                                          yAxis: RadarChartStyle.Axis(
                                            colors: [yAxisColor],
                                            widths: [0.5]),
                                          label: RadarChartStyle.Label(fontName: "Helvetica",
                                                                       fontColor: fontColor,
                                                                       fontSize: 11,
                                                                       lineSpacing: 0,
                                                                       letterSpacing: 0,
                                                                       margin: 10)
        )
        chartView.option = RadarChartOption()
    }

    override func viewDidLayoutSubviews() {
        chartView.prepareForDrawChart()
        chartView.setNeedsLayout()
    }
}
