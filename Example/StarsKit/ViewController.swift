//
//  ViewController.swift
//  StarsKit
//
//  Copyright (c) 2018 Smart&Soft. All rights reserved.
//

import UIKit
import StarsKit
import Extra

class ViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if let path = Bundle.main.path(forResource: "config", ofType: "json") {
      do {
        let data = try Data(contentsOf: URL(fileURLWithPath: path))
        if let localJSONConfiguration = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any?] {
          StarsKit.shared.updateConfig(from: localJSONConfiguration)
          StarsKit.shared.incrementSession()
          StarsKit.shared.priorityUseNativeRate = false
          StarsKit.shared.graphicContext.backgroundHeaderTitleImage = UIImage.gradient(from: UIColor.ex.fromHexa("#d8012a"),
                                                                                       end: UIColor.ex.fromHexa("#0024a6"),
                                                                                       rect: CGRect(x: 0, y: 0, width: 50, height: 50))
          StarsKit.shared.delegate = self
          
        }
      } catch {
        // handle error
      }
    }
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    StarsKit.shared.checkRateDisplay()
  }
  
}


// MARK: - StarsKitDelegate
extension ViewController: StarsKitDelegate {
  func didChooseAction(at step: RatingStep, from context: StarsKitContext) {
    print("Did choose action button at step \(step)")
  }
  
  func didChooseLater(at step: RatingStep, from context: StarsKitContext) {
    print("Did choose later button at step \(step)")
  }
  
  
  func needDisplayRateScreen() -> Bool {
    return true
  }
  
  func presenterController() -> UIViewController {
    return self
  }
  
  func didUpdateRating(from context: StarsKitContext, to rate: Int) {
    print("Did update rating at \(rate)")
  }
  
}
