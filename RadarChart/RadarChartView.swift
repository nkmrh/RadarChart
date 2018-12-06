//
//  RadarChartView.swift
//  RadarChart
//
// Copyright © 2018 hajime-nakamura. All rights reserved.
//

import Foundation
import UIKit

open class RadarChartView: UIView {

    private var plotLayer: CAShapeLayer?
    private var xAxisLayers: [CAShapeLayer] = []
    private var yAxisLayers: [CAShapeLayer] = []
    private var labels: [UILabel] = []
    private var isPlotAnimationStarted = false

    public var data: [Int] = []

    public var labelTexts: [String] = []

    public var numberOfVertexes: Int = 0

    public var numberTicks: Int = 0

    public var style: RadarChartStyle?

    public var option: RadarChartOption?

    public func prepareForDrawChart() {
        setupLayersAndLabels()
        isPlotAnimationStarted = false
    }

    private func makePlotLayer(with style: RadarChartStyle) -> CAShapeLayer {
        let layer = CAShapeLayer()
        layer.fillColor = style.color.cgColor
        return layer
    }

    private func makeXAxisLayers(with style: RadarChartStyle) -> [CAShapeLayer] {
        return Array(0..<numberTicks).map { i -> CAShapeLayer in
            let layer = CAShapeLayer()
            layer.fillColor = i == numberTicks - 1 ? style.backgroundColor.cgColor : UIColor.clear.cgColor
            if let xAxis = style.xAxis {
                layer.strokeColor = xAxis.color(for: i).cgColor
                layer.lineWidth = xAxis.width(for: i)
            }
            return layer
        }
    }

    private func makeYAxisLayers(with style: RadarChartStyle.Axis?) -> [CAShapeLayer] {
        return Array(0..<numberOfVertexes).map { i -> CAShapeLayer in
            let layer = CAShapeLayer()
            layer.fillColor = UIColor.clear.cgColor
            if let style = style {
                layer.strokeColor = style.color(for: i).cgColor
                layer.lineWidth = style.width(for: i)
            }
            return layer
        }
    }

    private func makeLabels(with style: RadarChartStyle.Label?) -> [UILabel] {
        return labelTexts.map { text -> UILabel in
            var fontColor: UIColor
            var font: UIFont
            var lineSpacing: CGFloat
            var letterSpacing: CGFloat
            if let style = style {
                fontColor = style.fontColor
                font = UIFont(name: style.fontName, size: style.fontSize) ?? UIFont.systemFont(ofSize: style.fontSize)
                lineSpacing = style.lineSpacing
                letterSpacing = style.letterSpacing
            } else {
                fontColor = RadarChartStyle.Label.defaultFontColor
                font = UIFont.systemFont(ofSize: RadarChartStyle.Label.defaultFontSize)
                lineSpacing = RadarChartStyle.Label.defaultLineSpacing
                letterSpacing = RadarChartStyle.Label.defaultLetterSpacing
            }

            let label = UILabel()
            label.lineBreakMode = .byWordWrapping
            label.numberOfLines = 0
            label.textColor = fontColor
            let textString = NSMutableAttributedString(
                string: text,
                attributes: [.font: font]
            )
            let textRange = NSRange(location: 0, length: textString.length)
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = lineSpacing
            paragraphStyle.alignment = .center
            textString.addAttribute(.paragraphStyle, value: paragraphStyle, range: textRange)
            textString.addAttribute(.kern, value: letterSpacing, range: textRange)
            label.attributedText = textString
            label.sizeToFit()
            return label
        }
    }

    static private func maximumLabelSize(_ labels: [UILabel]) -> CGSize {
        return labels.reduce(.zero) { CGSize(width: max($0.width, $1.bounds.width),
                                             height: max($0.height, $1.bounds.height)) }
    }

    private func drawChart() {
        guard let style = self.style,
            let option = self.option else { return }

        let maximumLabelSize = RadarChartView.maximumLabelSize(labels)
        let chart = RadarChart(numberOfVertexes: numberOfVertexes,
                               numberTicks: numberTicks,
                               size: bounds.size,
                               maximumLabelSize: maximumLabelSize,
                               labelMargin: style.label?.margin ?? RadarChartStyle.Label.defaultMargin)
        let pathProvider = RadarChartPathProvider(with: chart)

        for (i, xAxisLayer) in xAxisLayers.enumerated() {
            xAxisLayer.path = pathProvider.xAxisPaths[i]
        }
        for (i, yAxisLayer) in yAxisLayers.enumerated() {
            yAxisLayer.path = pathProvider.yAxisPaths[i]
        }
        for (i, label) in labels.enumerated() {
            label.center = chart.labelCenter(for: i, labelSize: label.bounds.size)
        }

        if option.shouldPlot {
            if option.animated, !isPlotAnimationStarted {
                isPlotAnimationStarted = true
                let animation = CABasicAnimation(keyPath:"path")
                let emptyData = Array(0..<numberOfVertexes).map { _ in 0 }
                animation.fromValue = pathProvider.makePath(from: emptyData)
                animation.toValue = pathProvider.makePath(from: data)
                animation.duration = option.duration
                animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
                animation.fillMode = CAMediaTimingFillMode.forwards
                animation.isRemovedOnCompletion = false
                plotLayer?.add(animation, forKey: nil)
            } else {
                plotLayer?.path = pathProvider.makePath(from: data)
            }
        }
    }

    private func setupLayersAndLabels() {
        guard let style = self.style else { return }

        subviews.forEach { $0.removeFromSuperview() }
        layer.sublayers?.forEach { layer in
            layer.removeAllAnimations()
            layer.removeFromSuperlayer()
        }

        xAxisLayers = makeXAxisLayers(with: style)
        yAxisLayers = makeYAxisLayers(with: style.yAxis)
        labels = makeLabels(with: style.label)
        for xAxisLayer in xAxisLayers {
            layer.insertSublayer(xAxisLayer, at: 0)
        }
        for yAxisLayer in yAxisLayers {
            layer.addSublayer(yAxisLayer)
        }
        for label in labels {
            addSubview(label)
        }

        let plotLayer = makePlotLayer(with: style)
        layer.addSublayer(plotLayer)
        self.plotLayer = plotLayer
    }

    open override func layoutSubviews() {
        super.layoutSubviews()
        drawChart()
    }
}
