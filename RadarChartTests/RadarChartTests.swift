import XCTest

class RadarChartTests: XCTestCase {
    
    var subject: RadarChart!
    
    override func setUp() {
        super.setUp()
        subject = RadarChart(numberOfVertexes: 5,
                             numberTicks: 3,
                             size: CGSize(width: 200, height: 200),
                             maximumLabelSize: CGSize(width: 30, height: 30),
                             labelMargin: 10)
    }
    
    func testCenter() {
        let center = subject.center
        XCTAssertEqual(center, CGPoint(x: 100, y: 100))
    }
    
    func testRadius() {
        let values: [CGFloat] = [
            2.0,
            20.0,
            40.0,
            60.0
        ]
        for (i, value) in values.enumerated() {
            let result = subject.radius(for: i)
            XCTAssertEqual(result, value, accuracy: CGFloat(Float.ulpOfOne))
        }
    }
    
    func testVertex() {
        let values = [
            CGPoint(x: 100, y: 40),
            CGPoint(x: 42.9366090222908, y: 81.4589803375031),
            CGPoint(x: 64.7328848624516, y: 148.541019662497),
            CGPoint(x: 135.267115137548, y: 148.541019662497),
            CGPoint(x: 157.063390977709, y: 81.4589803375032)
        ]
        for (i, value) in values.enumerated() {
            let result = subject.vertex(for: i, tick: 3)
            XCTAssertEqual(result.x, value.x, accuracy: 0.000000001)
            XCTAssertEqual(result.y, value.y, accuracy: 0.000000001)
        }
    }
    
    func testLabelCenter() {
        let values = [
            CGPoint(x: 100, y: 15.0),
            CGPoint(x: 19.160196114912, y: 73.7335554781295),
            CGPoint(x: 50.0382535551398, y: 168.766444521871),
            CGPoint(x: 149.96174644486, y: 168.766444521871),
            CGPoint(x: 180.839803885088, y: 73.7335554781295)
        ]
        for (i, value) in values.enumerated() {
            let result = subject.labelCenter(for: i, labelSize: CGSize(width: 30, height: 30))
            XCTAssertEqual(result.x, value.x, accuracy: 0.000000001)
            XCTAssertEqual(result.y, value.y, accuracy: 0.000000001)
        }
    }
    
}
