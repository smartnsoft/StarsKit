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

public final class StarsKitContext {
  
  public var nbSessions: Int {
    get {
      return UserDefaults.standard.integer(forKey: StarsKitContextProperties.nbSessions.userDefaultsKey)
    }
    
    set {
      if StarsKit.shared.useSessionSpaceChecking {
        if self.lastSessionDate == nil || Date().isAfter(self.lastSessionDate, pastDays: StarsKit.shared.configuration.maxDaysBetweenSession) {
          UserDefaults.standard.set(newValue, forKey: StarsKitContextProperties.nbSessions.userDefaultsKey)
          self.lastSessionDate = Date()
        }
      } else {
        UserDefaults.standard.set(newValue, forKey: StarsKitContextProperties.nbSessions.userDefaultsKey)
        self.lastSessionDate = Date()
      }
      if newValue == 0 {
        self.lastSessionDate = nil
      }
      
    }
  }
  
  public var nbCrashes: Int {
    get {
      return UserDefaults.standard.integer(forKey: StarsKitContextProperties.nbCrashes.userDefaultsKey)
    }
    
    set {
      self.lastCrashDate = Date()
      UserDefaults.standard.set(newValue, forKey: StarsKitContextProperties.nbCrashes.userDefaultsKey)
    }
  }
  
  public internal(set) var nbReminders: Int {
    get {
      return UserDefaults.standard.integer(forKey: StarsKitContextProperties.nbReminders.userDefaultsKey)
    }
    
    set {
      UserDefaults.standard.set(newValue, forKey: StarsKitContextProperties.nbReminders.userDefaultsKey)
    }
  }
  
  public internal(set) var lastDisplayDate: Date? {
    get {
      return UserDefaults.standard.object(forKey: StarsKitContextProperties.lastDisplayDate.userDefaultsKey) as? Date
    }
    
    set {
      UserDefaults.standard.set(newValue, forKey: StarsKitContextProperties.lastDisplayDate.userDefaultsKey)
    }
  }
  
  public internal(set) var lastSessionDate: Date? {
    get {
      return UserDefaults.standard.object(forKey: StarsKitContextProperties.lastSessionDate.userDefaultsKey) as? Date
    }
    
    set {
      UserDefaults.standard.set(newValue, forKey: StarsKitContextProperties.lastSessionDate.userDefaultsKey)
    }
  }
  
  public internal(set) var lastCrashDate: Date? {
    get {
      return UserDefaults.standard.object(forKey: StarsKitContextProperties.lastCrashDate.userDefaultsKey) as? Date
    }
    
    set {
      UserDefaults.standard.set(newValue, forKey: StarsKitContextProperties.lastCrashDate.userDefaultsKey)
    }
  }
  
  public internal(set) var userAlreadyRespondsToAction: Bool {
    get {
      return UserDefaults.standard.bool(forKey: StarsKitContextProperties.userAlreadyRespondsToAction.userDefaultsKey)
    }
    
    set {
      UserDefaults.standard.set(newValue, forKey: StarsKitContextProperties.userAlreadyRespondsToAction.userDefaultsKey)
    }
  }
}
