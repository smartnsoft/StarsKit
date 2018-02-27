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

/// The Stars
public final class StarsKitConfiguration {
  
  // MARK: Properties
  public internal(set) var disabled: Bool {
    get {
      return UserDefaults.standard.bool(forKey: StarsKitConfigProperties.disabled.userDefaultsKey)
    }
    
    set {
      UserDefaults.standard.set(newValue, forKey: StarsKitConfigProperties.disabled.userDefaultsKey)
    }
  }
  
  public internal(set) var displaySessionCount: Int {
    get {
      return UserDefaults.standard.integer(forKey: StarsKitConfigProperties.displaySessionCount.userDefaultsKey)
    }
    
    set {
      UserDefaults.standard.set(newValue, forKey: StarsKitConfigProperties.displaySessionCount.userDefaultsKey)
    }
  }
  
  public internal(set) var positiveStarsLimit: Int {
    get {
      return UserDefaults.standard.integer(forKey: StarsKitConfigProperties.positiveStarsLimit.userDefaultsKey)
    }
    
    set {
      UserDefaults.standard.set(newValue, forKey: StarsKitConfigProperties.positiveStarsLimit.userDefaultsKey)
    }
  }
  
  public internal(set) var daysWithoutCrash: Int {
    get {
      return UserDefaults.standard.integer(forKey: StarsKitConfigProperties.daysWithoutCrash.userDefaultsKey)
    }
    
    set {
      UserDefaults.standard.set(newValue, forKey: StarsKitConfigProperties.daysWithoutCrash.userDefaultsKey)
    }
  }
  
  public internal(set) var maxNumberOfReminder: Int {
    get {
      return UserDefaults.standard.integer(forKey: StarsKitConfigProperties.maxNumberOfReminder.userDefaultsKey)
    }
    
    set {
      UserDefaults.standard.set(newValue, forKey: StarsKitConfigProperties.maxNumberOfReminder.userDefaultsKey)
    }
  }
  
  public internal(set) var maxDaysBetweenSession: Int {
    get {
      return UserDefaults.standard.integer(forKey: StarsKitConfigProperties.maxDaysBetweenSession.userDefaultsKey)
    }
    
    set {
      UserDefaults.standard.set(newValue, forKey: StarsKitConfigProperties.maxDaysBetweenSession.userDefaultsKey)
    }
  }
  
  public internal(set) var daysBeforeAskingAgain: Int {
    get {
      return UserDefaults.standard.integer(forKey: StarsKitConfigProperties.daysBeforeAskingAgain.userDefaultsKey)
    }
    
    set {
      UserDefaults.standard.set(newValue, forKey: StarsKitConfigProperties.daysBeforeAskingAgain.userDefaultsKey)
    }
  }
  
  public internal(set) var emailSupport: String? {
    get {
      return UserDefaults.standard.string(forKey: StarsKitConfigProperties.emailSupport.userDefaultsKey)
    }
    
    set {
      UserDefaults.standard.set(newValue, forKey: StarsKitConfigProperties.emailSupport.userDefaultsKey)
    }
  }
  
  public internal(set) var emailObject: String? {
    get {
      return UserDefaults.standard.string(forKey: StarsKitConfigProperties.emailObject.userDefaultsKey)
    }
    
    set {
      UserDefaults.standard.set(newValue, forKey: StarsKitConfigProperties.emailObject.userDefaultsKey)
    }
  }
  
  public internal(set) var emailHeaderContent: String? {
    get {
      return UserDefaults.standard.string(forKey: StarsKitConfigProperties.emailHeaderContent.userDefaultsKey)
    }
    
    set {
      UserDefaults.standard.set(newValue, forKey: StarsKitConfigProperties.emailHeaderContent.userDefaultsKey)
    }
  }
  
  // MARK: Configuration update
  
  /// Update the StarsKit configuration. It will change the fire values.
  ///
  /// - Parameter config: Key-Value dictionnary with StarsKitProperties & StarsKitLocalizableKeys keys
  func update(with config: [String: Any?]) {
    
    self.updateMetrics(from: config)
    self.updateLocalizables(from: config)
  }
  
  // MARK: Private methods
  
  /// Update localizable UserDefaults strings
  ///
  /// - Parameter config: Key-Value dictionnary with StarsKitLocalizableKeys keys
  private func updateLocalizables(from config: [String: Any?]) {
    StarsKitLocalizableKeys.allValues.forEach { (key) in
      if let stringValue = config[key.rawValue] as? String {
        self.updateLocalizableString(string: stringValue, for: key)
      }
    }
  }
  
  /// Update global configuration metrics
  ///
  /// - Parameter config: Key-Value dictionnary with StarsKitProperties keys
  private func updateMetrics(from config: [String: Any?]) {
    if let isDisabled = config[StarsKitConfigProperties.disabled.rawValue] as? Bool {
      self.disabled = isDisabled
    }
    
    StarsKitConfigProperties.allIntValues.forEach { (property) in
      if let intValue = config[property.rawValue] as? Int {
        self.updateInt(value: intValue, for: property)
      }
    }
    
    StarsKitConfigProperties.allStringValues.forEach { (property) in
      if let stringValue = config[property.rawValue] as? String {
        UserDefaults.standard.setValue(stringValue, forKey: property.userDefaultsKey)
      }
    }
  }
  
  private func updateInt(value: Int, `for` property: StarsKitConfigProperties) {
    UserDefaults.standard.setValue(value, forKey: property.userDefaultsKey)
  }
  
  private func updateLocalizableString(string: String, `for` key: StarsKitLocalizableKeys) {
    UserDefaults.standard.setValue(string, forKey: key.userDefaultsKey)
  }
  
  /// Returns the localizable title for a specific key.
  ///
  /// It will check if the localizable strings behavior is enabled.
  ///
  /// If it is, it will also check if you override the localizable keys in your bundle.
  ///
  /// If not, it will check the configuration given values
  /// - Parameter key: The localizable enum key to check
  /// - Returns: The translated value
  func localizableTitle(`for` key: StarsKitLocalizableKeys) -> String {
    if StarsKit.shared.localLocalizableStringsEnabled {
      let overridedLocalizable = NSLocalizedString(key.localizableKey, bundle: Bundle.main, comment: "")
      if overridedLocalizable == key.localizableKey {
        return NSLocalizedString(key.localizableKey,
                                 tableName: "StarsKit",
                                 bundle: Bundle(for: StarsKit.self),
                                 comment: "")
      } else {
        return overridedLocalizable
      }
    } else {
      return UserDefaults.standard.string(forKey: key.userDefaultsKey) ?? ""
    }
  }
  
}
