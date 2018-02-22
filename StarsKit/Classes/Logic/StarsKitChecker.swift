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
  // - Si le nombre de sessions minimum pour lui demander sont atteintes (défini dans la config et > 0)
  // - Si on ne lui a pas déjà demandé trop de fois (défini dans la config et > 0)
  // - Si l’utilisateur n’a pas déjà cliqué sur un bouton d’action (store ou envoi du courriel)
  // - Si l’utilisateur a dit “plus tard” la fois précédente, mais que le délai, en jours, entre 2 demandes est écoulé (défini dans la config et > 0)
  // - Si le dernier crash remonte à plus de X temps en jours (défini dans la config et > 0)
  /// - Parameter client: StarsKit client
  /// - Returns: true if the display if needed
  public static func needDisplayRateScreen(`for` client: StarsKit = StarsKit.shared) -> Bool {
    guard !StarsKit.shared.configuration.disabled else { return false }
    
    let configuration = client.configuration
    let context = client.context
    
    if context.nbSessions >= configuration.displaySessionCount
      // TODO
      // Voir RatingManager
      // && context.nbReminders < configuration.maxNumberOfReminder
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
fileprivate extension TimeInterval {
  static let dayInSeconds: TimeInterval = 24 * 60 * 60
}

fileprivate extension Date {
  func isAfter(_ date: Date?, pastDays: Int) -> Bool {
    return self.timeIntervalSinceReferenceDate > ((date?.timeIntervalSinceReferenceDate ?? 0)
      + (Double(pastDays) * TimeInterval.dayInSeconds))
  }
}
