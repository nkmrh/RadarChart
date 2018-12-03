//
//  RadarChartPathProvider.swift
//  RadarChart
//
// Copyright © 2018 hajime-nakamura. All rights reserved.
//

import Foundation
import UIKit

struct RadarChartPathProvider {
    
    let chart: RadarChart
    private(set) var xAxisPaths: [CGPath] = []
    private(set) var yAxisPaths: [CGPath] = []
    
    init(with chart: RadarChart) {
        self.chart = chart
        self.xAxisPaths = makeXAxisPaths()
        self.yAxisPaths = makeYAxisPaths()
    }
    
    private func makeXAxisPaths() -> [CGPath] {
        return Array(0..<chart.numberTicks).map { makeXAxisPath(for: $0 + 1) }
    }
    
    private func makeXAxisPath(for tick: Int) -> CGPath {
        let path = CGMutablePath()
        for i in 0..<chart.numberOfVertexes {
            let vertex = chart.vertex(for: i, tick: tick)
            if i == 0 {
                path.move(to: vertex)
            } else {
                path.addLine(to: vertex)
            }
        }
        path.closeSubpath()
        return path
    }
    
    private func makeYAxisPaths() -> [CGPath] {
        return Array(0..<chart.numberOfVertexes).map { makeYAxisPath(index: $0) }
    }
    
    private func makeYAxisPath(index: Int) -> CGPath {
        let path = CGMutablePath()
        path.move(to: chart.center)
        let vertex = chart.vertex(for: index, tick: chart.numberTicks)
        path.addLine(to: vertex)
        path.closeSubpath()
        return path
    }
    
    func makePath(from data: [Int]) -> CGPath {
        let path = CGMutablePath()
        for (i, data) in data.enumerated() {
            let vertex = chart.vertex(for: i, tick: min(data, chart.numberTicks))
            if i == 0 {
                path.move(to: vertex)
            } else {
                path.addLine(to: vertex)
            }
        }
        path.closeSubpath()
        return path
    }
}
