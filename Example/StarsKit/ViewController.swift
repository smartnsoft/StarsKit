//
//  ViewController.swift
//  StarsKit
//
//  Copyright (c) 2018 Smart&Soft. All rights reserved.
//

import UIKit
import StarsKit

class ViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if let path = Bundle.main.path(forResource: "config", ofType: "json") {
      do {
        let data = try Data(contentsOf: URL(fileURLWithPath: path))
        if let localJSONConfiguration = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any?] {
          StarsKit.shared.updateConfig(with: localJSONConfiguration)
          StarsKit.shared.incrementSession()
          StarsKit.shared.delegate = self
          StarsKit.shared.checkRateDisplay()
        }
      } catch {
        // handle error
      }
    }
  }
  
}


// MARK: - StarsKitDelegate
extension ViewController: StarsKitDelegate {
  
  func needDisplayRateScreen() -> Bool {
    return true
  }
  
  func presenterController() -> UIViewController {
    return self
  }
  
  func didUpdateRating(from context: StarsKitContext, to rate: Int) {
    //
  }
  
  func willDismissRatingView(from client: StarsKitContext) {
    //
  }
  
  func didChooseRateLater(from client: StarsKitContext) {
    //
  }
  
  func willDismissLikeScreen(from client: StarsKitContext) {
    //
  }
  
  func didDismissLikeScreen(from client: StarsKitContext) {
    //
  }
  
  func didExitLikeScreen(from client: StarsKitContext) {
    //
  }
  
  func didDismissUnlikeScreen(from client: StarsKitContext) {
    //
  }
  
  
}

