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

/// Localizable strings keys to translate into screen
/// You can override them into a StarsKitLocalizable.Strings file in your app bundle
/// Use the StarsKitConfiguration localLocalizableStringsEnabled property to enable Localizable.strings or specific strings
///
/// - mainTitle: Title displayed in the main rate screen
/// - mainText: Text description to ask user about his feeling on the app
/// - dislikeMainTitle: Title displayed in the dislike resume screen
/// - dislikeMainText: Text description to ask user gives feedback if he dislikes the app
/// - dislikeActionButton: Dislike screen's action button title
/// - dislikeExitButton: Dislike screen's exit button title
/// - likeMainTitle: Like screen's action button title
/// - likeMainText: Like screen's action button title
/// - likeActionButton: Title displayed in the like feedback screen
/// - likeExitButton: Like screen's exit button title
/// - emailHeaderContent: Email body start text
/// - emailFooterContent: Email body end text informations
public enum StarsKitLocalizableKeys: String {
  case mainTitle
  case mainText
  case mainActionButton
  case dislikeMainTitle
  case dislikeMainText
  case dislikeActionButton
  case dislikeExitButton
  case likeMainTitle
  case likeMainText
  case likeActionButton
  case likeExitButton
  
  static let allValues: [StarsKitLocalizableKeys] = [.mainTitle,
                                                     .mainText,
                                                     .mainActionButton,
                                                     .dislikeMainTitle,
                                                     .dislikeMainText,
                                                     .dislikeActionButton,
                                                     .dislikeExitButton,
                                                     .likeMainTitle,
                                                     .likeMainText,
                                                     .likeActionButton,
                                                     .likeExitButton]
  
  var userDefaultsKey: String {
    return "StarsKit.UserDefaults.localizable.\(self)"
  }
  
  var localizableKey: String {
    return "starskit.\(self)"
  }
}


/// Main properties that StarsKit check to display or not the app rating screen
internal enum StarsKitProperties: String {
  
  case disabled
  case localLocalizableStringsEnabled
  case displaySessionCount
  case positiveStarsLimit
  case daysWithoutCrash
  case daysBeforeAskingAgain
  case maxNumberOfReminder
  case maxDaysBetweenSession
  case nbSessions
  case nbCrashes
  case nbReminders
  case lastDisplayDate
  case lastCrashDate
  case userAlreadyRespondsToAction
  
  static let allIntValues : [StarsKitProperties] = [.displaySessionCount,
                                                    .positiveStarsLimit,
                                                    .daysWithoutCrash,
                                                    .daysBeforeAskingAgain,
                                                    .maxNumberOfReminder,
                                                    .maxDaysBetweenSession,
                                                    .nbSessions,
                                                    .nbCrashes]
  
  var userDefaultsKey: String {
    return "StarsKit.UserDefaults.\(self)"
  }
}
