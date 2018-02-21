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

import UIKit

public class StoreViewController: UIViewController {

  @IBOutlet weak var ibIndicatorLabel: UILabel!
  @IBOutlet weak var ibActionButton: UIButton!
  @IBOutlet weak var ibLaterButton: UIButton!
  
  private var graphicContext: StarsKitGraphicContext = StarsKit.shared.graphicContext
  private var coordinator: StarsRatingCoordinator?
  
  init(graphicContext: StarsKitGraphicContext, coordinator: StarsRatingCoordinator) {
    let nibName = "StoreViewController"
    let bundle: Bundle = bundleForResource(name: nibName, ofType: "nib")
    super.init(nibName: nibName, bundle: bundle)
    self.graphicContext = graphicContext
    self.coordinator = coordinator
  }
  
  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override public func viewDidLoad() {
    super.viewDidLoad()
    
    self.prepareViews()
    
  }
  
  private func prepareViews() {
    self.ibIndicatorLabel.numberOfLines = 0
    self.ibIndicatorLabel.textAlignment = .center
    self.ibIndicatorLabel.text = StarsKit.shared.configuration.localizableTitle(for: StarsKitLocalizableKeys.likeMainText)
    
    let actionTitle = StarsKit.shared.configuration.localizableTitle(for: StarsKitLocalizableKeys.likeActionButton)
    self.ibActionButton.setTitle(actionTitle, for: .normal)
    self.ibActionButton.tintColor = self.graphicContext.actionButtonTitleColor
    self.ibActionButton.layer.masksToBounds = true
    self.ibActionButton.layer.cornerRadius = 5
    self.ibActionButton.setBackgroundImage(self.graphicContext.actionButtonBackgroundColor.ex.toImage(), for: .normal)
    self.ibActionButton.titleLabel?.font = self.graphicContext.actionButtonTitleFont
    
    let laterTitle = StarsKit.shared.configuration.localizableTitle(for: StarsKitLocalizableKeys.likeExitButton)
    self.ibLaterButton.setTitle(laterTitle, for: .normal)
    self.ibLaterButton.tintColor = self.graphicContext.laterTitleTintColor
    self.ibLaterButton.titleLabel?.font = self.graphicContext.laterTitleFont
  }
  
  @IBAction public func didChooseAction(_ sender: Any) {
    self.coordinator?.didChooseStoreReview()
  }
  
  @IBAction public func didChooseDismissAction(_ sender: Any) {
    self.coordinator?.later()
  }
  
  
}
