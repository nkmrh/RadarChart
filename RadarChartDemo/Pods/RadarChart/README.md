![](images/radar_chart.png)

A lightweight and simple to use radar chart.

![](https://img.shields.io/badge/platform-iOS%209%2B-blue.svg)
![](https://img.shields.io/badge/language-swift%204.2-green.svg)
![](https://img.shields.io/badge/pod-v1.0.0-blue.svg)
![](https://img.shields.io/badge/license-MIT-lightgrey.svg)
![](https://app.bitrise.io/app/d9565b31512dd4f8/status.svg?token=3FQuPkUBYdGoml46IDhTnQ)

## Customization

| Plot               |
| ------------------ |
| color              |
| background color   |
| should plot        |
| should animation   |
| animation duration |

| Axes   |
| ------ |
| colors |
| widths |

| Label          |
| -------------- |
| font           |
| font color     |
| font size      |
| line spacing   |
| letter spacing |
| margin         |

## Requirements

- iOS 9+
- Swift 4.2+

## Integration

Drop in `RadarChart` folder to your Xcode project. Make sure to enable Copy items if needed and Create groups Or via CocoaPods:

```
pod 'RadarChart`
```

## How to use

If you want to draw a chart like the image below, please write as follows.

![](images/demo.png)

Set properties of RadarChartView `data` `labelTexts` `numberOfVertexes` `numberTicks` `style` `option` like below.

```swift
class ViewController: UIViewController {

    @IBOutlet weak var chartView: RadarChartView!

    override func viewDidLoad() {
        super.viewDidLoad()

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
```

## License

`RadarChart` is released under the MIT license. Check LICENSE for details

## Contact

If you have any questions, requests, or enhancements, feel free to submit a pull request, create an issue.

**Hajime Nakamura**
**nkmrhj@gmail.com**
