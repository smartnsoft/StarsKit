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
  
  public var configuration = StarsKitConfiguration()
  public var context = StarsKitContext()
  public var graphicContext = StarsKitGraphicContext()
  
  public var validateRatingButtonEnable = true
  public var useDefaultBehavior = true
  public var priorityUseNativeRate = false
  public var localLocalizableStringsEnabled = false
  
  fileprivate var jellyAnimator: JellyAnimator?
  
  public weak var delegate: StarsKitDelegate?
  
  // MARK: Initializer
  public init(delegate: StarsKitDelegate? = nil) {
    self.delegate = delegate
  }
  
  public func checkRateDisplay() {
    if (self.useDefaultBehavior && StarsKitChecker.needDisplayRateScreen(for: self))
      || self.delegate?.needDisplayRateScreen() == true {
      if self.priorityUseNativeRate {
        //Use 10.3 + native app rating
        if #available(iOS 10.3, *) {
          SKStoreReviewController.requestReview()
        }
      } else {
        if let controller = self.delegate?.presenterController() {
          
          let alertController = StarsPopViewController(graphicContext: self.graphicContext)
          // Custom Alert
          var alertPresentation = JellySlideInPresentation(cornerRadius: Double(self.graphicContext.cornerRadius),
                                                           backgroundStyle: .blur(effectStyle: .extraLight),
                                                           duration: .medium,
                                                           directionShow: .top,
                                                           directionDismiss: .bottom,
                                                           widthForViewController: .custom(value: 280),
                                                           heightForViewController: .custom(value: 250))
          alertPresentation.isTapBackgroundToDismissEnabled = false
          self.jellyAnimator = JellyAnimator(presentation: alertPresentation)
          self.jellyAnimator?.prepare(viewController: alertController)
          
          controller.present(alertController, animated: true, completion: nil)
        }
      }
    }
  }
  
  /// Reset all metrics context
  public func resetContext() {
    self.context.nbCrashes = 0
    self.context.nbSessions = 0
    self.context.lastDisplayDate = nil
  }
  
  public func incrementSession(by sessionCount: Int = 1) {
    self.context.nbSessions += sessionCount
  }
  
  // MARK: Config update
  public func updateConfig(from values: [String: Any?]) {
    self.configuration.update(with: values)
  }
  
}

func bundleForResource(name: String, ofType type: String) -> Bundle {
  
  if(Bundle.main.path(forResource: name, ofType: type) != nil) {
    return Bundle.main
  }
  
  return Bundle(for: StarsKit.self)
}
