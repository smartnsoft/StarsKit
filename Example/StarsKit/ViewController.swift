//
//  ViewController.swift
//  StarsKit
//
//  Copyright (c) 2018 Smart&Soft. All rights reserved.
//

import UIKit
import StarsKit
import Extra
import Jelly
import MessageUI

enum TransitionType: Int {
  case `default`
  case bottom
  case slideIn
  
  func configure() {
    var presentation: JellyPresentation
    switch self {
    case .default:
      presentation = StarsKit.shared.graphicContext.defaultJellyPresentation
    case .slideIn:
      presentation = JellySlideInPresentation(cornerRadius: 15,
                                              backgroundStyle: .blur(effectStyle: .dark),
                                              jellyness: .jellier,
                                              duration: .medium,
                                              directionShow: .left,
                                              directionDismiss: .right,
                                              widthForViewController: .custom(value: 300),
                                              heightForViewController: .custom(value: 300))
    case .bottom:
      presentation = {
        var jellyShift = JellyShiftInPresentation()
        jellyShift.direction = .bottom
        jellyShift.backgroundStyle = .blur(effectStyle: .light)
        jellyShift.size = .custom(value: 300)
        return jellyShift
      }()
    }
    
    StarsKit.shared.graphicContext.jellyCustomTransition = presentation
  }
}

class ViewController: UIViewController {
  
  @IBOutlet weak var ibNbSessionsLabel: UILabel!
  @IBOutlet weak var ibNbCrashLabel: UILabel!
  @IBOutlet weak var ibLastCrashDate: UILabel!
  
  @IBOutlet weak var ibSessionintervalChecking: UISwitch!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.ibSessionintervalChecking.isOn = StarsKit.shared.useSessionSpaceChecking
    
    let imageView = UIImageView(image: UIImage(named: "Cover"))
    imageView.contentMode = .scaleAspectFit
    self.navigationItem.titleView = imageView
    
    if let path = Bundle.main.path(forResource: "config", ofType: "json") {
      do {
        let data = try Data(contentsOf: URL(fileURLWithPath: path))
        if let localJSONConfiguration = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any?] {
          StarsKit.shared.updateConfig(from: localJSONConfiguration)
//          let bgImageGradient = UIImage.gradient(from: CGS("#007BFF"),
//                                         end: UIColor.ex.fromHexa("#FFC107"),
//                                         rect: CGRect(x: 0, y: 0, width: 50, height: 50))
          let bgImage = UIColor.ex.fromHexa("#42aaf4")?.ex.toImage()
          StarsKit.shared.graphicContext.backgroundHeaderTitleImage = bgImage
          
          if let image1 = UIImage(named: "ic_notation_1",in: Bundle(for: StarsKit.self),
                                  compatibleWith: nil), let image2 = UIImage(named: "ic_notation_2",in: Bundle(for: StarsKit.self),
                                                                             compatibleWith: nil), let image3 = UIImage(named: "ic_notation_3",in: Bundle(for: StarsKit.self),
                                                                                                                        compatibleWith: nil), let image4 = UIImage(named: "ic_notation_4",in: Bundle(for: StarsKit.self),
                                                                                                                                                                   compatibleWith: nil), let image5 = UIImage(named: "ic_notation_5",in: Bundle(for: StarsKit.self),
                                                                                                                                                                                                              compatibleWith: nil) {
          StarsKit.shared.graphicContext.customImages = [image1, image2, image3, image4, image5]
        }
        
          StarsKit.shared.graphicContext.actionButtonBackgroundColor = UIColor.ex.fromHexa("#007BFF")!
          StarsKit.shared.delegate = self
          StarsKit.shared.uiDelegate = self
          //          StarsKit.shared.graphicContext.emptyStarImage = nil
          //          StarsKit.shared.graphicContext.emptyStarImage = nil
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
  
  private func sendMail() {
    if MFMailComposeViewController.canSendMail() == true {
      
      let recipients = [StarsKit.shared.configuration.emailSupport ?? ""]
      let mailController = MFMailComposeViewController()
      mailController.mailComposeDelegate = self
      mailController.setToRecipients(recipients)
      mailController.setSubject(StarsKit.shared.configuration.emailObject ?? "")
      mailController.setMessageBody(StarsKit.shared.configuration.emailHeaderContent ?? "", isHTML: false)
      
      self.present(mailController, animated: true, completion: {
        //
      })
    }
    
  }
  
  @IBAction func didSwitchCustomImageMode(_ sender: UISwitch) {
    StarsKit.shared.customImageMode = sender.isOn
  }
  
  @IBAction func didSwitchNativeRating(_ sender: UISwitch) {
    StarsKit.shared.priorityUseNativeRate = sender.isOn
  }
  
  @IBAction func didSwitchLocalizable(_ sender: UISwitch) {
    StarsKit.shared.localLocalizableStringsEnabled = sender.isOn
  }
  @IBAction func didTapShowRatingButton(_ sender: Any) {
    StarsKit.shared.displayRateIfNeeded(forced: true)
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
  
  @IBAction func didChangeSegmentTransitionType(_ sender: UISegmentedControl) {
    let type = TransitionType(rawValue: sender.selectedSegmentIndex)
    type?.configure()
  }
  
  @IBAction func didSwitchSessionIntervalCheck(_ sender: UISwitch) {
    StarsKit.shared.useSessionSpaceChecking = sender.isOn
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
    if step == .feedback {
      self.sendMail()
    }
    print("Did choose action button at step \(step)")
  }
  
  func didChooseLater(at step: RatingStep) {
    print("Did choose later button at step \(step)")
  }
  
  func needCustomDisplayRateScreen() -> Bool {
    //Implement your own behavior if you want
    return false
  }
  
  func didUpdateRating(from context: StarsKitContext, to rate: Int) {
    print("Did update rating at \(rate)")
  }
  
}


// MARK: - StarsKitUIDelegate
extension ViewController: StarsKitUIDelegate {
  
  func didRatingScreenWillAppear() {
    print("didRatingScreenWillAppear")
  }
  
  func didRatingScreenDidAppear() {
    print("didRatingScreenDidAppear")
  }
  
  func didRatingScreenWillDisappear() {
    print("didRatingScreenWillDisappear")
  }
  
  func didRatingScreenDidDisappear() {
    print("didRatingScreenDidDisappear")
  }
  
  func presenterController() -> UIViewController? {
    // Return the controller where the rate screen will be presented
    // The current, the top most one, anywhere, anyone
    return self
  }
}

// MARK: MFMessageComposeViewControllerDelegate
extension ViewController: MFMailComposeViewControllerDelegate {
  
  func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
    controller.dismiss(animated: true) { () -> Void in
      switch result {
      case .sent:
        print("mail send")
      case .failed:
        print("mail failed")
      case .saved:
        print("mail saved")
      default: break
      }
    }
  }
}
