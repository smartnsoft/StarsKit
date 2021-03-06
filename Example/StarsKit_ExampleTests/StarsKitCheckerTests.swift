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
import StarsKit
import SwiftDate

class StarsKitCheckerTests: XCTestCase {
  
  let client = StarsKitClient()
  
  static func makeFakeSessions() {
    StarsKit.shared.context.nbSessions = 16
  }
  
  override func setUp() {
    super.setUp()
    StarsKit.shared.updateConfig(from: StubsReader.config(from: "DefaultConfiguration"))
    StarsKit.shared.uiDelegate = self.client
  }
  
  override func tearDown() {
    StarsKit.shared.delegate = nil
    StarsKit.shared.useDefaultBehavior = true
    StarsKit.shared.resetContext()
    StarsKit.shared.resetConfig()
    super.tearDown()
  }
  
  func testDisableConfig() {
    StarsKit.shared.updateConfig(from: StubsReader.config(from: "ConfigurationDisable"))
    XCTAssertFalse(StarsKit.shared.displayRateIfNeeded(), "Configuration doesn't correctly disable")
  }
  
  func testEnableConfig() {
    StarsKitCheckerTests.makeFakeSessions()
    XCTAssertTrue(StarsKit.shared.displayRateIfNeeded(), "Configuration doesn't correctly be enabled")
  }
  
  func testDisplaySessionsEnough() {
    StarsKitCheckerTests.makeFakeSessions()
    XCTAssertTrue(StarsKit.shared.displayRateIfNeeded(), "Pop-up have to be displayed after enought sessions")
  }
  
  func testDisplaySessionsLess() {
    StarsKit.shared.context.nbSessions = 1
    XCTAssertFalse(StarsKit.shared.displayRateIfNeeded(), "Pop-up have not to be displayed without enought number of sessions")
  }
  
  func testDisplayDate() {
    StarsKitCheckerTests.makeFakeSessions()
    XCTAssertTrue(StarsKit.shared.displayRateIfNeeded())
    XCTAssertFalse(StarsKit.shared.displayRateIfNeeded(), "Pop-up have to not be displayed after recently be displayed")
  }
  
  func testDisplayDateEnough() {
    StarsKitCheckerTests.makeFakeSessions()
    XCTAssertTrue(StarsKit.shared.displayRateIfNeeded())
    if let lastDisplayDate = StarsKit.shared.context.lastDisplayDate {
      let expiredDisplayDate = lastDisplayDate - 4.days
      UserDefaults.standard.set(expiredDisplayDate, forKey: "StarsKit.UserDefaults.context.lastDisplayDate")
    }
    XCTAssertTrue(StarsKit.shared.displayRateIfNeeded(), "Pop-up have to be displayed after be displayed enought after \(StarsKit.shared.configuration.daysBeforeAskingAgain) days")
  }
  
  func testDisplayCrash() {
    StarsKitCheckerTests.makeFakeSessions()
    StarsKit.shared.context.nbCrashes = 1
    XCTAssertFalse(StarsKit.shared.displayRateIfNeeded(), "Pop-up have to not be displayed after recently have a crash displayed")
  }
  
  func testDisplayCrashAfter() {
    StarsKitCheckerTests.makeFakeSessions()
    StarsKit.shared.context.nbCrashes = 1
    if let lastCrashDate = StarsKit.shared.context.lastCrashDate {
      let expiredCrashDate = lastCrashDate - 14.days
      UserDefaults.standard.set(expiredCrashDate, forKey: "StarsKit.UserDefaults.context.lastCrashDate")
    }
    
    XCTAssertFalse(StarsKit.shared.displayRateIfNeeded(), "Pop-up have not to be displayed after a crash happened less than \(StarsKit.shared.configuration.daysWithoutCrash) days")
  }
  
  func testDisplayCrashAfterEnough() {
    StarsKitCheckerTests.makeFakeSessions()
    StarsKit.shared.context.nbCrashes = 1
    if let lastCrashDate = StarsKit.shared.context.lastCrashDate {
      let expiredCrashDate = lastCrashDate - 16.days
      UserDefaults.standard.set(expiredCrashDate, forKey: "StarsKit.UserDefaults.context.lastCrashDate")
    }
    
    XCTAssertTrue(StarsKit.shared.displayRateIfNeeded(), "Pop-up have to be displayed after a crash happened more than \(StarsKit.shared.configuration.daysWithoutCrash) days")
  }
  
  func testCustomCheking() {
    StarsKit.shared.context.nbSessions = 3
    StarsKit.shared.delegate = self.client
    StarsKit.shared.useDefaultBehavior = false
    XCTAssertFalse(StarsKit.shared.displayRateIfNeeded(), "Custom checking needs to display rating")
    
  }
  
  func testRemindersOutOfBound() {
    StarsKitCheckerTests.makeFakeSessions()
    for _ in 1...3 {
      StarsKit.shared.context.nbSessions += 1
      XCTAssertTrue(StarsKit.shared.displayRateIfNeeded())
      if let lastDisplayDate = StarsKit.shared.context.lastDisplayDate {
        let expiredDisplayDate = lastDisplayDate - 4.days
        UserDefaults.standard.set(expiredDisplayDate, forKey: "StarsKit.UserDefaults.context.lastDisplayDate")
      }
      UserDefaults.standard.set(nil, forKey: "StarsKit.UserDefaults.context.lastSessionDate")
    }
    XCTAssertFalse(StarsKit.shared.displayRateIfNeeded(), "Custom checking has not to display rating")
  }
  
  func testRemindersEnough() {
    
    StarsKitCheckerTests.makeFakeSessions()
    for _ in 1...2 {
      StarsKit.shared.context.nbSessions += 1
      XCTAssertTrue(StarsKit.shared.displayRateIfNeeded())
      if let lastDisplayDate = StarsKit.shared.context.lastDisplayDate {
        let expiredDisplayDate = lastDisplayDate - 4.days
        UserDefaults.standard.set(expiredDisplayDate, forKey: "StarsKit.UserDefaults.context.lastDisplayDate")
      }
      UserDefaults.standard.set(nil, forKey: "StarsKit.UserDefaults.context.lastSessionDate")
    }
    XCTAssertTrue(StarsKit.shared.displayRateIfNeeded(), "Custom checking needs to display rating")
  }
  
  func testSessionIncrementSameDay() {
    StarsKit.shared.context.nbSessions = 0
    StarsKit.shared.context.nbSessions += 1
    StarsKit.shared.context.nbSessions += 1
    XCTAssertTrue(StarsKit.shared.context.nbSessions == 1)
  }
  
  func testSessionIncrementDifferentDay() {
    StarsKit.shared.context.nbSessions = 0
    StarsKit.shared.context.nbSessions += 1
    //One day ellapsed
    if let lastSessionDate = UserDefaults.standard.value(forKey: "StarsKit.UserDefaults.context.lastSessionDate") as? Date {
      let newDate = lastSessionDate - 1.day
      UserDefaults.standard.set(newDate, forKey: "StarsKit.UserDefaults.context.lastSessionDate")
    }
    
    StarsKit.shared.context.nbSessions += 1
    XCTAssertTrue(StarsKit.shared.context.nbSessions == 2)
  }
  
}

final class StarsKitClient: StarsKitDelegate {
  
  func needCustomDisplayRateScreen() -> Bool {
    return StarsKit.shared.context.nbSessions > 6
  }
  
  func didUpdateRating(from context: StarsKitContext, to rate: Int) {
    //
  }
  
  func didValidateRating(to rate: Int) {
    //
  }
  
  func didChooseAction(at step: RatingStep) {
    //
  }
  
  func didChooseLater(at step: RatingStep) {
    //
  }
  
  
}

extension StarsKitClient: StarsKitUIDelegate {
  func presenterController() -> UIViewController? {
    return UIViewController() //mock controller
  }
  
  func didRatingScreenWillAppear() {
    //
  }
  
  func didRatingScreenDidAppear() {
    //
  }
  
  func didRatingScreenWillDisappear() {
    //
  }
  
  func didRatingScreenDidDisappear() {
    //
  }
  
  
}
