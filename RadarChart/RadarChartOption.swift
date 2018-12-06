//
//  RadarChartOption.swift
//  RadarChart
//
// Copyright © 2018 hajime-nakamura. All rights reserved.
//

import Foundation

public struct RadarChartOption {
    let shouldPlot: Bool
    let animated: Bool
    let duration: Double

    public init(
        shouldPlot: Bool = true,
        animated: Bool = true,
        duration: Double = 1.0) {
            self.shouldPlot = shouldPlot
            self.animated = animated
            self.duration = duration
        }
}
