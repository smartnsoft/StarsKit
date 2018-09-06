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

@available(iOS 9.0, *)

class SmileyRateView: UIView, RateView {
  
  var delegate: RateViewDelegate?
  
  @IBOutlet var ibStackView: UIStackView!
  
  var images: [UIImage]?
  var rating: Double = 0
  private let nibName = "SmileyRateView"
  private var view: UIView!
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    xibSetUp()
  }
  
  required init?(coder aDecoder: NSCoder) {
     super.init(coder: aDecoder)
    xibSetUp()
  }
  
  func xibSetUp() {
    view = loadViewFromNib()
    view.frame = self.bounds
    view.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
    addSubview(view)
  }
  
  func loadViewFromNib() -> UIView? {
    let bundle = Bundle(for: type(of: self))
    let nib = UINib(nibName: nibName, bundle: bundle)
    let view: UIView? = nib.instantiate(withOwner: self, options: nil)[0] as? UIView ?? nil
    return view
  }

  func computeView () {
    self.images = StarsKit.shared.graphicContext.customImages
    self.ibStackView.spacing = 10
    var index = 1
    images?.forEach { (image: UIImage) in
      let button = UIButton(type: .custom)
      button.setImage(image, for: .normal)
      button.alpha = 1
      button.tag = index
      button.imageView?.contentMode = .scaleAspectFit
      index += 1
      button.addTarget(self, action: #selector(SmileyRateView.selectRate(_:)), for: UIControlEvents.touchUpInside)
      self.ibStackView.addArrangedSubview(button)
    }
    
  }
  
  @objc private func selectRate(_ sender: UIButton) {
    if !sender.isSelected {
      self.ibStackView.arrangedSubviews.forEach { button in
      guard let button = button as? UIButton, button != sender else { return }
        button.isSelected = false
        button.alpha = 0.5
        UIView.animate(withDuration: 0.3) {
          button.transform = CGAffineTransform.identity
        }
      }
      self.animateButton(button: sender)
      self.rating = Double(sender.tag)
      self.delegate?.onSelectRate(rating: Double(sender.tag))
    }
    sender.isSelected = true
  }
  
  private func animateButton(button: UIButton) {
    
    button.isSelected = true
    button.alpha = 1
    UIView.animate(withDuration: 0.3, delay: 0, animations: {
      button.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
    }, completion: { _ in
      UIView.animate(withDuration: 0.3, delay: 0, options: [.beginFromCurrentState], animations: {
        button.transform = CGAffineTransform(scaleX: 1, y: 1)
      })
    })
  }
  
}
