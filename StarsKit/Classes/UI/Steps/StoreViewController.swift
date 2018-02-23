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

/// When the user like the app, it will be redirect to this screen
public class StoreViewController: StepViewController {
  
  // MARK: Initializers
  init(graphicContext: StarsKitGraphicContext, coordinator: RatingCoordinator) {
    let nibName = "StoreViewController"
    let bundle: Bundle = Bundle.bundleForResource(name: nibName, ofType: "nib")
    super.init(nibName: nibName, bundle: bundle)
    self.graphicContext = graphicContext
    self.coordinator = coordinator
  }
  
  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  // MARK: 
  @IBAction public func didChooseAction(_ sender: Any) {
    self.coordinator?.didChooseStoreReview()
  }
  
  @IBAction public func didChooseDismissAction(_ sender: Any) {
    self.coordinator?.later()
  }
  
}
