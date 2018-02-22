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

import Foundation

/// Default display checker
public final class StarsKitChecker {
  
  @discardableResult
  
  
  /// Default display checking
  ///
  /// - Parameter client: StareKit check instance
  /// - Returns: True if display needed
  public static func needDisplayRateScreen(`for` client: StarsKit = StarsKit.shared) -> Bool {
    guard !StarsKit.shared.configuration.disabled else { return false }
    
    let configuration = client.configuration
    let context = client.context
    
    if context.nbSessions >= configuration.displaySessionCount
      && context.nbReminders < configuration.maxNumberOfReminder
      && !context.userAlreadyRespondsToAction
      && (context.lastDisplayDate == nil || Date().isAfter(context.lastDisplayDate,
                                                           pastDays: configuration.daysBeforeAskingAgain))
      && (context.lastCrashDate == nil || Date().isAfter(context.lastCrashDate,
                                                         pastDays: configuration.daysWithoutCrash))
    {
      return true
    }
    return false
    
  }
}


// MARK: - TimeInterval
extension TimeInterval {
  static let dayInSeconds: TimeInterval = 24 * 60 * 60
}

extension Date {
  func isAfter(_ date: Date?, pastDays: Int) -> Bool {
    return self.timeIntervalSinceReferenceDate > ((date?.timeIntervalSinceReferenceDate ?? self.timeIntervalSinceReferenceDate)
      + (Double(pastDays) * TimeInterval.dayInSeconds))
  }
}
