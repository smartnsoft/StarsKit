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
  
  @IBOutlet weak var ibNbSessionsLabel: UILabel!
  @IBOutlet weak var ibNbCrashLabel: UILabel!
  @IBOutlet weak var ibLastCrashDate: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let imageView = UIImageView(image: UIImage(named: "Cover"))
    imageView.contentMode = .scaleAspectFit
    self.navigationItem.titleView = imageView
    
    if let path = Bundle.main.path(forResource: "config", ofType: "json") {
      do {
        let data = try Data(contentsOf: URL(fileURLWithPath: path))
        if let localJSONConfiguration = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any?] {
          StarsKit.shared.updateConfig(from: localJSONConfiguration)
          let bgImage = UIImage.gradient(from: UIColor.ex.fromHexa("#0024a6"),
                                         end: UIColor.ex.fromHexa("#d8012a"),
                                         rect: CGRect(x: 0, y: 0, width: 50, height: 50))
          StarsKit.shared.graphicContext.backgroundHeaderTitleImage = bgImage
          StarsKit.shared.delegate = self
          self.updateDisplayMetrics()
        }
      } catch {
        // handle error
      }
    }
  }
  
  private func updateDisplayMetrics() {
    self.ibNbCrashLabel.text = "Crashes: \(StarsKit.shared.context.nbCrashes)"
    self.ibNbSessionsLabel.text = "Sessions: \(StarsKit.shared.context.nbSessions)"
    self.ibLastCrashDate.text = "Last crash at: \(StarsKit.shared.context.lastCrashDate?.description ?? "?")"
  }
  
  @IBAction func didSwitchNativeRating(_ sender: UISwitch) {
    StarsKit.shared.priorityUseNativeRate = sender.isOn
  }
  
  @IBAction func didSwitchLocalizable(_ sender: UISwitch) {
    StarsKit.shared.localLocalizableStringsEnabled = sender.isOn
  }
  @IBAction func didTapShowRatingButton(_ sender: Any) {
    StarsKit.shared.checkRateDisplay()
    self.updateDisplayMetrics()
  }
  
  @IBAction func didTapIncrementCrash(_ sender: Any) {
    StarsKit.shared.context.nbCrashes += 1
    self.updateDisplayMetrics()
  }
  
  @IBAction func didTapResetMetrics(_ sender: Any) {
    StarsKit.shared.resetContext()
    self.updateDisplayMetrics()
  }
  
  @IBAction func didTapIncrementSession(_ sender: Any) {
    StarsKit.shared.context.nbSessions += 1
    self.updateDisplayMetrics()
  }
}

// MARK: - StarsKitDelegate
extension ViewController: StarsKitDelegate {
  func didValidateRating(to rate: Int) {
    print("Did validate rating to rate \(rate)")
  }
  
  func didChooseAction(at step: RatingStep) {
    print("Did choose action button at step \(step)")
  }
  
  func didChooseLater(at step: RatingStep) {
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
