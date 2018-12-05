//
//  RadarChartStyle.swift
//  RadarChart
//
// Copyright © 2018 hajime-nakamura. All rights reserved.
//

import Foundation
import UIKit

public struct RadarChartStyle {

    let color: UIColor
    let backgroundColor: UIColor
    let xAxis: Axis?
    let yAxis: Axis?
    let label: Label?

    struct Axis {
        private static let defaultColor: UIColor = .black
        private static let defaultWidth: CGFloat = 0

        let colors: [UIColor]
        let widths: [CGFloat]

        func color(for index: Int) -> UIColor {
            if index > colors.count - 1 {
                guard let last = colors.last else { return Axis.defaultColor }
                return last
            } else {
                return colors[index]
            }
        }

        func width(for index: Int) -> CGFloat {
            if index > widths.count - 1 {
                guard let last = widths.last else { return Axis.defaultWidth }
                return last
            } else {
                return widths[index]
            }
        }
    }

    struct Label {
        static let defaultFontColor: UIColor = .black
        static let defaultFontSize: CGFloat = 0
        static let defaultLineSpacing: CGFloat = 0
        static let defaultLetterSpacing: CGFloat = 0
        static let defaultMargin: CGFloat = 0

        let fontName: String
        let fontColor: UIColor
        let fontSize: CGFloat
        let lineSpacing: CGFloat
        let letterSpacing: CGFloat
        let margin: CGFloat
    }
}
