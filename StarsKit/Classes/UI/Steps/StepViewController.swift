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

/// Main default implementation of a step controller.
///
/// It contains and text description, action button and dismiss button.
public class StepViewController: UIViewController {
  
  var graphicContext: StarsKitGraphicContext = StarsKit.shared.graphicContext
  var coordinator: StarsRatingCoordinator?
  
  @IBOutlet weak var ibIndicatorLabel: UILabel!
  @IBOutlet weak var ibActionButton: UIButton!
  @IBOutlet weak var ibLaterButton: UIButton!
  
  // MARK: Initializers
  public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }
  
  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  // MARK: View Life Cycle
  override public func viewDidLoad() {
    super.viewDidLoad()
    self.prepareViews()
  }
  
  // MARK: View customization
  func prepareViews() {
    self.ibIndicatorLabel.numberOfLines = 0
    self.ibIndicatorLabel.textAlignment = .center
    self.ibIndicatorLabel.text = self.coordinator?.step.indicatorTitle()
    self.ibIndicatorLabel.font = self.graphicContext.indicationTitleFont
    
    self.ibActionButton.setTitle(self.coordinator?.step.actionTitle(), for: .normal)
    self.ibActionButton.tintColor = self.graphicContext.actionButtonTitleColor
    self.ibActionButton.layer.masksToBounds = true
    self.ibActionButton.layer.cornerRadius = 5
    self.ibActionButton.setBackgroundImage(self.graphicContext.actionButtonBackgroundColor.ex.toImage(), for: .normal)
    self.ibActionButton.titleLabel?.font = self.graphicContext.actionButtonTitleFont
  
    self.ibLaterButton.setTitle(self.coordinator?.step.laterTitle(), for: .normal)
    self.ibLaterButton.tintColor = self.graphicContext.laterTitleTintColor
    self.ibLaterButton.titleLabel?.font = self.graphicContext.laterTitleFont
  }
  
}
