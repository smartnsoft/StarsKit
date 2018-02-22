// The MIT License (MIT)
//
// Copyright (c) 2018 Smart&Soft
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import XCTest

class StarsKit_ExampleUITests: XCTestCase {
  
  override func setUp() {
    super.setUp()
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    continueAfterFailure = false
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    XCUIApplication().launch()
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }
  
  func testRating() {
    
    let app = XCUIApplication()
    app.buttons["Show Rating"].tap()
    let ratingElement = app.otherElements["Rating"]
    ratingElement.swipeLeft()
    ratingElement.swipeRight()
    ratingElement.tap()
    ratingElement.tap()
    ratingElement.tap()
    ratingElement.swipeLeft()
    ratingElement.tap()
    
  }
  
  func testRatingAndValidate() {
    
    let app = XCUIApplication()
    app.buttons["Show Rating"].tap()
    app.otherElements["Rating"].tap()
    app.buttons["Valider"].tap()
    app.buttons["Plus tard"].tap()
    
  }
  
  func testRatingButLater() {
    
    let app = XCUIApplication()
    app.buttons["Show Rating"].tap()
    app.otherElements["Rating"].tap()
    app.buttons["Plus tard"].tap()
    
  }
  
//  func testRatingPositiveWithAction() {
//
//    let app = XCUIApplication()
//    app.buttons["Show Rating"].tap()
//    app.otherElements["Rating"].tap()
//    app.buttons["Valider"].tap()
//    app.buttons["C’est parti !"].tap()
//
//  }
  
  func testRatingPositiveButLater() {
    
    let app = XCUIApplication()
    app.buttons["Show Rating"].tap()
    app.otherElements["Rating"].tap()
    app.buttons["Valider"].tap()
    app.buttons["Plus tard"].tap()
    
  }
  
  func testRatingNegativeWithAction() {
    
    let app = XCUIApplication()
    let showRatingButton = app.buttons["Show Rating"]
    showRatingButton.tap()
    
    let ratingElement = app.otherElements["Rating"]
    ratingElement.tap()
    
    let validerButton = app.buttons["Valider"]
    validerButton.tap()
    app.buttons["Faire une suggestion"].tap()

    
  }
  
  func testRatingNegativeButLater() {
    let app = XCUIApplication()
    let showRatingButton = app.buttons["Show Rating"]
    showRatingButton.tap()

    let ratingElement = app.otherElements["Rating"]
    ratingElement.tap()
    
    let validerButton = app.buttons["Valider"]
    validerButton.tap()
    app.buttons["Plus tard"].tap()
  }
  
}
