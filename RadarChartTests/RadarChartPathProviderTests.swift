import XCTest

class RadarChartPathProviderTests: XCTestCase {

    var subject: RadarChartPathProvider!
    
    override func setUp() {
        super.setUp()
        let chart = RadarChart(numberOfVertexes: 5,
                               numberTicks: 3,
                               size: CGSize(width: 200, height: 200),
                               maximumLabelSize: CGSize(width: 30, height: 30),
                               labelMargin: 10)
        subject = RadarChartPathProvider(with: chart)
    }

    private func makePath(with vertexes: [CGPoint]) -> CGPath {
        let path = CGMutablePath()
        for (i, vertex) in vertexes.enumerated() {
            if i == 0 {
                path.move(to: vertex)
            } else {
                path.addLine(to: vertex)
            }
        }
        path.closeSubpath()
        return path
    }

    func testXAxisPahts() {
        let vertexes1 = [
            CGPoint(x: 100, y: 80),
            CGPoint(x: 80.9788696740969, y: 93.8196601125011),
            CGPoint(x: 88.2442949541505, y: 116.180339887499),
            CGPoint(x: 111.755705045849, y: 116.180339887499),
            CGPoint(x: 119.021130325903, y: 93.8196601125011)
        ]
        let vertexes2 = [
            CGPoint(x: 100, y: 60),
            CGPoint(x: 61.9577393481939, y: 87.6393202250021),
            CGPoint(x: 76.4885899083011, y: 132.360679774998),
            CGPoint(x: 123.511410091699, y: 132.360679774998),
            CGPoint(x: 138.042260651806, y: 87.6393202250021)
        ]
        let vertexes3 = [
            CGPoint(x: 100, y: 40),
            CGPoint(x: 42.9366090222908, y: 81.4589803375031),
            CGPoint(x: 64.7328848624516, y: 148.541019662497),
            CGPoint(x: 135.267115137548, y: 148.541019662497),
            CGPoint(x: 157.063390977709, y: 81.4589803375032),
            ]
        let paths = [
            makePath(with: vertexes1),
            makePath(with: vertexes2),
            makePath(with: vertexes3)
        ]

        let results = subject.xAxisPaths
        XCTAssertEqual(results.count, 3)
        for (i, result) in results.enumerated() {
            XCTAssertEqual(result.boundingBox.origin.x, paths[i].boundingBox.origin.x, accuracy: 0.000000001)
            XCTAssertEqual(result.boundingBox.origin.y, paths[i].boundingBox.origin.y, accuracy: 0.000000001)
            XCTAssertEqual(result.boundingBox.width, paths[i].boundingBox.width, accuracy: 0.000000001)
            XCTAssertEqual(result.boundingBox.height, paths[i].boundingBox.height, accuracy: 0.000000001)
            XCTAssertEqual(result.currentPoint.x, paths[i].currentPoint.x, accuracy: 0.000000001)
            XCTAssertEqual(result.currentPoint.y, paths[i].currentPoint.y, accuracy: 0.000000001)
        }
    }

    func testYAxisPahts() {
        let vertexes1 = [
            CGPoint(x: 100, y: 100),
            CGPoint(x: 100, y: 40)
        ]
        let vertexes2 = [
            CGPoint(x: 100, y: 100),
            CGPoint(x: 42.9366090222908, y: 81.4589803375031)
        ]
        let vertexes3 = [
            CGPoint(x: 100, y: 100),
            CGPoint(x: 64.7328848624516, y: 148.541019662497)
        ]
        let vertexes4 = [
            CGPoint(x: 100, y: 100),
            CGPoint(x: 135.267115137548, y: 148.541019662497)
        ]
        let vertexes5 = [
            CGPoint(x: 100, y: 100),
            CGPoint(x: 157.063390977709, y: 81.4589803375032)
        ]
        let paths = [
            makePath(with: vertexes1),
            makePath(with: vertexes2),
            makePath(with: vertexes3),
            makePath(with: vertexes4),
            makePath(with: vertexes5)
        ]

        let results = subject.yAxisPaths
        XCTAssertEqual(results.count, 5)
        for (i, result) in results.enumerated() {
            XCTAssertEqual(result.boundingBox.origin.x, paths[i].boundingBox.origin.x, accuracy: 0.000000001)
            XCTAssertEqual(result.boundingBox.origin.y, paths[i].boundingBox.origin.y, accuracy: 0.000000001)
            XCTAssertEqual(result.boundingBox.width, paths[i].boundingBox.width, accuracy: 0.000000001)
            XCTAssertEqual(result.boundingBox.height, paths[i].boundingBox.height, accuracy: 0.000000001)
            XCTAssertEqual(result.currentPoint.x, paths[i].currentPoint.x, accuracy: 0.000000001)
            XCTAssertEqual(result.currentPoint.y, paths[i].currentPoint.y, accuracy: 0.000000001)
        }
    }

    func testMakePath() {
        let data = [3, 3, 3, 3, 3]
        let vertexes = [
            CGPoint(x: 100, y: 40),
            CGPoint(x: 42.9366090222908, y: 81.4589803375031),
            CGPoint(x: 64.7328848624516, y: 148.541019662497),
            CGPoint(x: 135.267115137548, y: 148.541019662497),
            CGPoint(x: 157.063390977709, y: 81.4589803375032)
        ]
        let path = makePath(with: vertexes)

        let result = subject.makePath(from: data)
        XCTAssertEqual(result.boundingBox.origin.x, path.boundingBox.origin.x, accuracy: 0.000000001)
        XCTAssertEqual(result.boundingBox.origin.y, path.boundingBox.origin.y, accuracy: 0.000000001)
        XCTAssertEqual(result.boundingBox.width, path.boundingBox.width, accuracy: 0.000000001)
        XCTAssertEqual(result.boundingBox.height, path.boundingBox.height, accuracy: 0.000000001)
        XCTAssertEqual(result.currentPoint.x, path.currentPoint.x, accuracy: 0.000000001)
        XCTAssertEqual(result.currentPoint.y, path.currentPoint.y, accuracy: 0.000000001)
    }
    
}
