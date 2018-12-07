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

    public init(
        color: UIColor,
        backgroundColor: UIColor,
        xAxis: Axis? = nil,
        yAxis: Axis? = nil,
        label: Label? = nil) {
            self.color = color
            self.backgroundColor = backgroundColor
            self.xAxis = xAxis
            self.yAxis = yAxis
            self.label = label
        }

    public struct Axis {
        private static let defaultColor: UIColor = .black
        private static let defaultWidth: CGFloat = 0

        public let colors: [UIColor]
        public let widths: [CGFloat]

        public init(colors: [UIColor], widths: [CGFloat]) {
            self.colors = colors
            self.widths = widths
        }

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

    public struct Label {
        static let defaultFontColor: UIColor = .black
        static let defaultFontSize: CGFloat = 0
        static let defaultLineSpacing: CGFloat = 0
        static let defaultLetterSpacing: CGFloat = 0
        static let defaultMargin: CGFloat = 0

        public let fontName: String
        public let fontColor: UIColor
        public let fontSize: CGFloat
        public let lineSpacing: CGFloat
        public let letterSpacing: CGFloat
        public let margin: CGFloat

        public init(
            fontName: String,
            fontColor: UIColor,
            fontSize: CGFloat,
            lineSpacing: CGFloat,
            letterSpacing: CGFloat,
            margin: CGFloat) {
            self.fontName = fontName
            self.fontColor = fontColor
            self.fontSize = fontSize
            self.lineSpacing = lineSpacing
            self.letterSpacing = letterSpacing
            self.margin = margin
        }
    }
}
