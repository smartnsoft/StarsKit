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


/// StarsKit events delegate
public protocol StarsKitDelegate: class {
  
  /// Only call when the default behavior is not used
  func needCustomDisplayRateScreen() -> Bool
  
  /// This callback fire when the user change the app rate on the view
  ///
  /// - Parameters:
  ///   - context: The context when the event fire
  ///   - rate: The user app rate level
  func didUpdateRating(from context: StarsKitContext, to rate: Int)
  
  //TODO: Start display
  //TODO: End display
  
  /// User tap on the submit rating button
  ///
  /// - Parameter rate: The user app rate level
  func didValidateRating(to rate: Int)
  
  
  /// User tap on the action related to a screen step
  ///
  /// - Parameter step: The last step displayed
  func didChooseAction(`at` step: RatingStep)
  
  
  /// User tap on the later button related to a screen step
  ///
  /// - Parameter step: The last step displayed
  func didChooseLater(`at` step: RatingStep)
  
}
