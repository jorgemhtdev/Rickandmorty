import XCTest

final class RickandmortyUITests: XCTestCase {

    override func setUpWithError() throws {

        continueAfterFailure = false
    }

    override func tearDownWithError() throws {

    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
