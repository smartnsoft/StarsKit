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
import StoreKit
import Jelly

/// Global StarsKit client
public class StarsKit {
  
  public static let shared = StarsKit()
  
  // StarsKit contexts and configuration
  public var configuration = StarsKitConfiguration()
  public var context = StarsKitContext()
  public var graphicContext = StarsKitGraphicContext()
  
  // Defines if you want to submit immediatelly after Stars touches
  // or validate after with a specific submit button
  public var validateRatingButtonEnable = true
  
  // Defines if StarsKit will appluy its own behavior process or if you want to apply yours
  public var useDefaultBehavior = true
  
  // Defines if you want to enable the StoreKit Rating Controller (from iOS 10.3 only)
  public var priorityUseNativeRate = false
  
  // Define if StarsKit use the Localizable strings (and your overrided ones)
  // or if it uses the configuration strings ones
  public var localLocalizableStringsEnabled = false
  
  fileprivate var jellyAnimator: JellyAnimator?
  
  public weak var delegate: StarsKitDelegate?
  
  // MARK: Initializer
  public init(delegate: StarsKitDelegate? = nil) {
    self.delegate = delegate
  }
  
  /// Start the rating checking and display the rating view if needed
  @discardableResult
  public func displayRateIfNeeded(forced: Bool = false) -> Bool {
    
    if forced
      || (self.useDefaultBehavior && StarsKitChecker.needDisplayRateScreen(for: self))
      || (self.delegate != nil && self.delegate?.needDisplayRateScreen() == true) {
      
      self.context.nbReminders += 1
      self.context.lastDisplayDate = Date()
      
      if self.priorityUseNativeRate {
        //Use 10.3 + native app rating
        if #available(iOS 10.3, *) {
          SKStoreReviewController.requestReview()
        }
      } else {
        if let controller = self.delegate?.presenterController() {
          
          let alertController = StarsPopViewController(graphicContext: self.graphicContext)
          let alertPresentation = self.graphicContext.jellyCustomTransition
          self.jellyAnimator = JellyAnimator(presentation: alertPresentation)
          self.jellyAnimator?.prepare(viewController: alertController)
          
          controller.present(alertController, animated: true, completion: nil)
        }
      }
      return true
    }
    return false
  }
  
  /// MARK: Metrics update
  
  /// **Warning**: Be sure about calling a reset context !
  public func resetContext() {
    self.resetCrashMetrics()
    self.context.nbSessions = 0
    self.context.nbReminders = 0
    self.context.userAlreadyRespondsToAction = false
    self.context.lastDisplayDate = nil
  }
  
  public func resetConfig() {
    self.configuration.daysBeforeAskingAgain = 0
    self.configuration.daysWithoutCrash = 0
    self.configuration.disabled = true
    self.configuration.displaySessionCount = 0
    self.configuration.maxDaysBetweenSession = 0
    self.configuration.maxNumberOfReminder = 0
    self.configuration.positiveStarsLimit = 0
  }
  
  public func resetCrashMetrics() {
    self.context.nbCrashes = 0
    self.context.lastCrashDate = nil
  }
  
  public func incrementSession(by sessionCount: Int = 1) {
    self.context.nbSessions += sessionCount
  }
  
  public func updateConfig(from values: [String: Any?]) {
    self.configuration.update(with: values)
  }
  
}

// MARK: - Bundle
extension Bundle {
  static func bundleForResource(name: String, ofType type: String) -> Bundle {
    
    if(Bundle.main.path(forResource: name, ofType: type) != nil) {
      return Bundle.main
    }
    
    return Bundle(for: StarsKit.self)
  }
}
