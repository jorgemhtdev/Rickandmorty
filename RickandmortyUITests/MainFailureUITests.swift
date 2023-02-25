import XCTest

final class MainFailureUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testScreenLoad() throws {
        let app = XCUIApplication()
        app.launchArguments = ["isRunningUITests"]
        app.launch()
        
        let cv = app.otherElements["lista"].children(matching: .any).element
        
        XCTAssert(cv.waitForExistence(timeout: 5), "The list should be visible on the screen.")
    }
    
    func testListElementDeleteElement() throws {
        let app = XCUIApplication()
        app.launchArguments = ["isRunningUITests"]
        app.launch()
        
        let cv = app.otherElements["lista"].children(matching: .any).element

        let itemListBefore = cv.children(matching: .any).element(boundBy: 0)

        let removeButton = app.buttons["btn"].firstMatch
        
        let itemListAfter = cv.children(matching: .any).element(boundBy: 0)

        removeButton.tap()
    }
    
    func testListTapElement() throws {
        
        let app = XCUIApplication()
        app.launchArguments = ["isRunningUITests"]
        app.launch()
        
        let cv = app.otherElements["lista"].children(matching: .any).element
        
        XCTAssertTrue(cv.waitForExistence(timeout: 5), "The list should exist on the screen")
        
        let itemList = cv.children(matching: .any).element(boundBy: 0)
        
        itemList.tap()
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
