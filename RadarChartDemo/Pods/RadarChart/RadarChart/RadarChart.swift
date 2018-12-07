//
//  RadarChart.swift
//  RadarChart
//
// Copyright © 2018 hajime-nakamura. All rights reserved.
//

import Foundation
import UIKit

struct RadarChart {
    
    let numberOfVertexes: Int
    let numberTicks: Int
    let size: CGSize
    let maximumLabelSize: CGSize
    let labelMargin: CGFloat
    
    var center: CGPoint {
        return CGPoint(x: size.width / 2, y: size.height / 2)
    }
    
    private var maximumChartRadius: CGFloat {
        let minimumHalfSize = min(size.width, size.height) / 2
        let maximumLabelLength = max(maximumLabelSize.width, maximumLabelSize.height)
        return minimumHalfSize - maximumLabelLength - labelMargin
    }
    
    private static func angle(from: CGPoint, to: CGPoint) -> CGFloat {
        return atan2(to.y - from.y, to.x - from.x)
    }
    
    func radius(for tick: Int) -> CGFloat {
        let tickDistance = maximumChartRadius / CGFloat(numberTicks)
        if tick == 0 {
            return tickDistance / 10
        } else {
            return tickDistance * CGFloat(tick)
        }
    }
    
    func vertex(for index: Int, tick: Int) -> CGPoint {
        let angle = Double.pi / 2
        let radius = self.radius(for: tick)
        let x = Double(center.x) + (Double(radius) * (cos(2 * Double(index) * Double.pi / Double(numberOfVertexes) + angle)))
        let y = Double(center.y) - (Double(radius) * (sin(2 * Double(index) * Double.pi / Double(numberOfVertexes) + angle)))
        return CGPoint(x: x, y: y)
    }
    
    func labelCenter(for index: Int, labelSize: CGSize) -> CGPoint {
        let vertex = self.vertex(for: index, tick: numberTicks)
        let radian = RadarChart.angle(from: center, to: vertex)
        return CGPoint(x: vertex.x + cos(radian) * (labelSize.width / 2 + labelMargin),
                       y: vertex.y + sin(radian) * (labelSize.height / 2 + labelMargin))
    }
}
