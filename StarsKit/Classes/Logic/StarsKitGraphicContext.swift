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
import Cosmos
import Jelly

/// UI customization properties for your rating steps screens
public class StarsKitGraphicContext {
  
  // MARK: StarsKit view customizations
  
  // The global corner radius to apply on the main displayed view
  public lazy var cornerRadius: CGFloat = 10
  
  // Top header title & style of the main screen header
  public lazy var mainTitleFont: UIFont = UIFont.boldSystemFont(ofSize: 16)
  public lazy var mainTitleColor: UIColor = .white
  public var backgroundHeaderTitleImage: UIImage?
  public lazy var backgroundHeaderColor: UIColor = .white
  
  // Title style of the description text in step screens
  public lazy var indicationTitleFont: UIFont = UIFont.boldSystemFont(ofSize: 18)
  public lazy var indicationTitleColor: UIColor = .darkGray
  
  // Style of the action button in step screens
  public lazy var actionButtonBackgroundColor: UIColor = .blue
  public lazy var actionButtonTitleColor: UIColor = .white
  public lazy var actionButtonTitleFont: UIFont = UIFont.boldSystemFont(ofSize: 15)
  
  // Style of the later button in step screens
  public lazy var laterTitleFont: UIFont = UIFont.boldSystemFont(ofSize: 15)
  public lazy var laterTitleTintColor: UIColor = .lightGray
  
  // Stars images if need, else use the cosmos settings below
  public lazy var emptyStarImage: UIImage? = UIImage(named: "shape_default",
                                                     in: Bundle(for: StarsKit.self),
                                                     compatibleWith: nil)
  public lazy var filledStarImage: UIImage? = UIImage(named: "shape_selected",
                                                      in: Bundle(for: StarsKit.self),
                                                      compatibleWith: nil)
  
  public lazy var preferredStatusBarStyle = UIStatusBarStyle.lightContent
  public lazy var stepTransitionOptions: UIViewAnimationOptions = .transitionCrossDissolve
  
  // MARK: Third parties customizations
  
  // Cosmos
  public lazy var cosmosSettings: CosmosSettings = CosmosSettings.default
  
  // Jelly
  public lazy var defaultJellyPresentation: JellyPresentation = {
    var presentation = JellySlideInPresentation(cornerRadius: Double(self.cornerRadius),
                                                backgroundStyle: .blur(effectStyle: .extraLight),
                                                duration: .medium,
                                                directionShow: .top,
                                                directionDismiss: .bottom,
                                                widthForViewController: .custom(value: 280),
                                                heightForViewController: .custom(value: 250))
    presentation.isTapBackgroundToDismissEnabled = false
    return presentation
  }()

  public lazy var jellyCustomTransition: JellyPresentation = {
    self.defaultJellyPresentation
  }()
}
