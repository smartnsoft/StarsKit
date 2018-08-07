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
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }
  
  required init?(coder aDecoder: NSCoder) {
     super.init(coder: aDecoder)
    commonInit()
  }
  
  private func commonInit() {
    Bundle.main.loadNibNamed("SmileyRateView", owner: self, options: nil)
  }
  
  /// Closure will be called when the user lifts finger from the cosmos view. The touch rating argument is passed to the closure.
  open var didFinishTouching: ((Double)->())?
  
  func computeView () {
  
    ibStackView.spacing = 0
    var index = 1
    images?.forEach { (image: UIImage) in
      let button = UIButton(type: .custom)
      button.setImage(image, for: .normal)
      button.alpha = 1
      button.tag = index
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
      didFinishTouching?(Double(sender.tag))
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
