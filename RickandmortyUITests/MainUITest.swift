import XCTest

final class MainUITest: XCTestCase {
    
    override func setUpWithError() throws { }
    
    override func tearDownWithError() throws {  }
    
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
        
        XCTAssertNotEqual(itemListBefore,itemListAfter)
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
