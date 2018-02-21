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

/// Step of the rating process
///
/// - rating: User has to choose a rating
/// - feedback: User has to choose giving a feedback because of disliking
/// - storeReview: User has the choice of giving an AppStore review
public enum RatingStep {
  case rating(context: StarsKitContext)
  case feedback(context: StarsKitContext)
  case storeReview(context: StarsKitContext)
  
  func title() -> String {
    switch self {
    case .rating:
      return StarsKit.shared.configuration.localizableTitle(for: StarsKitLocalizableKeys.mainTitle)
    case .feedback:
      return StarsKit.shared.configuration.localizableTitle(for: StarsKitLocalizableKeys.dislikeMainTitle)
    case .storeReview:
      return StarsKit.shared.configuration.localizableTitle(for: StarsKitLocalizableKeys.likeMainTitle)
    }
  }
  
  func indicatorTitle() -> String {
    switch self {
    case .rating:
      return StarsKit.shared.configuration.localizableTitle(for: StarsKitLocalizableKeys.mainText)
    case .feedback:
      return StarsKit.shared.configuration.localizableTitle(for: StarsKitLocalizableKeys.dislikeMainText)
    case .storeReview:
      return StarsKit.shared.configuration.localizableTitle(for: StarsKitLocalizableKeys.likeMainText)
    }
    
  }
  
  func actionTitle() -> String {
    switch self {
    case .rating:
      return StarsKit.shared.configuration.localizableTitle(for: StarsKitLocalizableKeys.mainActionButton)
    case .feedback:
      return StarsKit.shared.configuration.localizableTitle(for: StarsKitLocalizableKeys.dislikeActionButton)
    case .storeReview:
      return StarsKit.shared.configuration.localizableTitle(for: StarsKitLocalizableKeys.likeActionButton)
    }
  }
  
  func laterTitle() -> String {
    switch self {
    case .rating, .storeReview:
      return StarsKit.shared.configuration.localizableTitle(for: StarsKitLocalizableKeys.likeExitButton)
    case .feedback:
      return StarsKit.shared.configuration.localizableTitle(for: StarsKitLocalizableKeys.dislikeExitButton)
    }
  }
}
