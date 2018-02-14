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

/// Global StarsKit client
public class StarsKit {
  
  public static let shared = StarsKit()
  
  public var configuration = StarsKitConfiguration()
  public var context = StarsKitContext()
  
  public weak var delegate: StarsKitDelegate?
  
  // MARK: Initializer
  public init(delegate: StarsKitDelegate? = nil) {
    self.delegate = delegate
  }
  
  // MARK: Metrics updates
  public func checkRateDisplay() {
    StarsKitChecker.displayRateScreenIfNeeded()
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
  public func updateConfig(with values: [String: Any?]) {
    self.configuration.update(with: values)
  }
  
}
