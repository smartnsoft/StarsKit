//
//  SmileyRateView.swift
//
//  Created by Willy on 06/08/2018.
//

import UIKit

@available(iOS 9.0, *)
class SmileyRateView: UIView {

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
  
  /// Closure will be called when the user lifts finger from the cosmos view. The touch rating argument is passed to the closure.
  open var didFinishTouching: ((Double) -> Void)?
  
  func computeView () {
  
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
        if let button = button as? UIButton, button != sender {
          button.isSelected = false
          button.alpha = 0.5
          UIView.animate(withDuration: 0.3) {
            button.transform = CGAffineTransform.identity
          }
        }
      }
      self.animateButton(button: sender)
      self.rating = Double(sender.tag)
      self.didFinishTouching?(Double(sender.tag))
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
