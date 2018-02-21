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

import Foundation
import UIKit

extension UIImage {
  
  static func gradient(from: UIColor?, end: UIColor?, alpha: CGFloat = 1.0, rect: CGRect) -> UIImage? {
    
    guard let fromColor = from, let endColor = end else { return nil}
    
    let gradientLayer = CAGradientLayer()
    gradientLayer.frame = rect
    let fromGradientColor = fromColor.withAlphaComponent(alpha).cgColor
    let endGradientColor = endColor.withAlphaComponent(alpha).cgColor
    gradientLayer.colors = [fromGradientColor, endGradientColor]
    gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
    gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
    UIGraphicsBeginImageContext(rect.size)
    guard let context = UIGraphicsGetCurrentContext() else { return UIImage() }
    gradientLayer.render(in: context)
    guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return UIImage() }
    UIGraphicsEndImageContext()
    return image
    
  }
}
