# StarsKit

[![CI Status](http://img.shields.io/travis/smartnsoft/StarsKit.svg?style=flat)](https://travis-ci.org/smartnsoft/StarsKit)
[![Version](https://img.shields.io/cocoapods/v/StarsKit.svg?style=flat)](https://img.shields.io/cocoapods/v/StarsKit.svg?style=flat)
[![License](https://img.shields.io/cocoapods/l/StarsKit.svg?style=flat)](https://img.shields.io/cocoapods/l/StarsKit.svg?style=flat)
[![Platform](https://img.shields.io/cocoapods/p/StarsKit.svg?style=flat)](https://img.shields.io/cocoapods/p/StarsKit.svg?style=flat)

<img width=100% src="./img/Cover.jpg">

### Look at this beautiful MouSTARche!

StarsKit is a Swift library to simplify, customize and configure your iOS app rating workflow.

It can be based on a remote, local or static configuration data with optionnals properties.

<p align="center"><img width=32% src="./img/step_rate.png"> <img width=32% src="./img/step_feedback.png"> <img width=32% src="./img/step_store.png"></p>

## Requirements

- iOS 9.0+
- Swift 4+
- Xcode 9.2+

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

StarsKit is available through [CocoaPods](http://cocoapods.org). To install
it, add the following line to your Podfile:

``` ruby
pod 'StarsKit'
```

## Third-party dependencies

Today we have third-parties dependencies, but the purpose is to avoid them the most.

We also want to have a quickly available library and significant customization, we use 3 dependencies:

- [Extra/UIKit](https://github.com/smartnsoft/Extra): our library to simplify UIKit operation code
- [Jelly](https://github.com/SebastianBoldt/Jelly): a simple UI component to simplify the rating transition display
- [Cosmos](https://github.com/evgenyneu/Cosmos): a powerful and flexible stars slider UI component

## Description

### Behavior

The main feature of the library is to **use static or dynamic (remote) configuration to show native or custom app rating screen**.

If the user chooses a negative rate, he will be redirected to the **feedback screen**.
If the user chooses a positive rate, he will be redirected to the **Store review screen**.

You and only you choose what to do when the user chooses to give a feedback, like:

- send an e-mail
- launch your own feedback screen

It's the same when the user chooses to rate the app: 

- redirect the user to the AppStore review page
- call a custom analytics

### Native StoreKit screen

You can also display the native `StoreKit` screen instead of custom screens (iOS 10.3+ only):

<p align="center"><img width=32% src="./img/storekit.png"></p>
### Features list

- [X] Use localizable or configuration strings
- [X] Default localizable strings : 
- - [X] EN
- - [X] FR
- [X] Overridable localizable strings
- [X] Static configuration strings
- [X] Cocoapods integration
- [X] Default & configurable step transitions
- [X] Default display algorithm behavior
- [X] Customizable display algorithm behavior
- [X] Customizable stars style
- [X] Customizable fonts, text & tint colors
- [X] Rating & screen actions callbacks
- [X] Configurable with dictionary/data or remote URL: everything you want!
- [X] Native iOS 10.3+ StoreKit integration
- [X] Overridable layouts
- [X] Lifecycle display events ([will/did]appear/disappear)
- [ ] Additional condition checking on the default check
- [ ] Carthage integration
- [ ] Configurable key for parsing
- [ ] Firebase extension to bind Remote Config to StarsKit data

## Configurable metrics for display

You can specify metrics to trigger the default display behavior or use your own one.

- [X] Disable/enable the component
- [X] Increment sessions counter
- [X] Increment crashes counter
- [X] Static configuration strings
- [X] Days without crashes
- [X] Days before asking again
- [X] Number of reminding
- [X] Maximum of days between session count
- [X] email properties: mail address, mail subject, mail header body
- [X] Step 1: Rate screen properties
- [X] Step 2: Feedback screen properties
- [X] Step 3: Store review screen properties

## Usage

### Display the rating

```
// Call this, the algorithm will do the rest:
StarsKit.shared.displayRateIfNeeded()

// You can also force the display:
StarsKit.shared.displayRateIfNeeded(forced: true)
```
### Update the configuration properties

See also: `StarsKitConfigProperties` enum keys.
You have to conform the data dictionary to the expected keys.

**StarsKit offers you the possibility of using any configuration source**: local JSON file, static dictionnary, remote file (remote JSON or Firebase remote configuration file).

JSON StarsKit configuration example:

``` json
{
    "disabled": false,
    "prefersNativeRating": false,
    "displaySessionCount": 3,
    "mainTitle": "Your opinion interests us :)",
    "mainText": "Do you like the app StarsKit?",
    "mainActionButton": "Submit",
    "positiveStarsLimit": 4,
    "dislikeMainTitle": "Your opinion interests us",
    "dislikeMainText": "Help us to improve the app StarsKit",
    "dislikeActionButton": "Make a suggestion",
    "dislikeExitButton": "Later",
    "likeMainTitle": "You like our app! Thanks!",
    "likeMainText": "Let us know on the AppStore in a minute!",
    "likeActionButton": "Let's go!",
    "likeExitButton": "Later 😥",
    "maxNumberOfReminder": 3,
    "maxDaysBetweenSession": 3,
    "emailSupport": "starskit@smartnsoft.com",
    "emailObject": "Application StarsKit",
    "daysWithoutCrash": 15,
    "daysBeforeAskingAgain": 3,
    "emailHeaderContent": "Why do you not like the app?"
}
```

To update the configuration, give the dictionnary data :

``` swift
let data = try Data(contentsOf: URL(fileURLWithPath: path))
let localJSONConfiguration = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String: Any?]
StarsKit.shared.updateConfig(from: localJSONConfiguration)
```

### `StarsKit` instance & configuration

Today StarsKit manages a default singleton instance.

You can set-up your own `configuration`, `context` and `graphicContext` for StarsKit.

You can also decide of:

- **`validateRatingButtonEnable`**: disable or enable the submit step rating. If disabled, the rate will be instantly submited after user touch.
- **`useDefaultBehavior`**: disable the default StarsKit display checking behavior and implement your own in the `StarsKitDelegate`
- **`useSessionSpaceChecking`**: enable/disable the time checking when incrementing StarsKit's sessions counter.
  Default is `true` which means StarsKit will **only count 1 session a day**, but also that StarsKit will **reset the sessoins counter** if too much time has passed since the last session. (see `StarsKitConfiguration.maxDaysBetweenSession`).That behavior allow us to target only active users.
- **`localLocalizableStringsEnabled`**: enable the localization titles instead of configuration one. It will use the default StarKit strings. If you override them in your app localizable strings (with the same key), it will take them 😎.

### `StarsKitContext`: update the metrics 

To trigger the pop-up rating display, you have to update the metrics.

``` swift
// Increment the number of crash, this will automatically update the last crash date (lastCrashDate)
StarsKit.shared.context.nbCrashes += 1

// Increment the session directly
StarsKit.shared.context.nbSessions += 1
// or
StarsKit.shared.incrementSession(by: 10)

// You can also reset all the app context values
StarsKit.shared.resetContext()

// You can also reset all the configuration properties
// After a new major version update for instance
StarsKit.shared.resetConfig()
```

You can also use the `nbCrashes` property with **Fabric and Crashlytics**:

``` swift

extension AppDelegate {
  
  func setupFabricSDK(_ application: UIApplication) {
    Fabric.with([Crashlytics.self])
    Crashlytics.sharedInstance().delegate = self
  }
}

// MARK: - CrashlyticsDelegate
extension AppDelegate: CrashlyticsDelegate {
  func crashlyticsDidDetectReport(forLastExecution report: CLSReport) {
    StarsKit.shared.context.nbCrashes += 1
  }
}

```

See also `StarsKitContextProperties` for the user defaults properties.

## Customization

### Use `StarsKitGraphicContext`

Customizable items :

- titles fonts
- titles colors 
- button tintColor
- button backgroundColor
- header background image
- ViewController presentation transition (via Jelly)
- Stars style (via Cosmos)

### Transitions & display (Jelly)

StarsKit uses Jelly fro customizable transitions. You can specify your own via the `jellyCustomTransition` property in the `StarsKitGraphicContext`.

<p align="center"><img width=48% src="./img/presentation_black.png"> <img width=48% src="./img/presentation_bottom.png"></p>
Go to [Jelly repo](https://github.com/SebastianBoldt/Jelly) for more information.

### Stars (Cosmos)

Cosmos provides a `CosmosSettings` property that can be set in the `StarsKitGraphicContext`.

You specify your own stars images (filled/empty).
If nil, Cosmos will use the specified star path via `starPoints`.

<p align="center"><img width=60% border=1 src="https://github.com/evgenyneu/Cosmos/raw/master/graphics/Screenshots/cosmos_star_rating_control_for_ios_swift_space.png"></p>
Go to [Comos repo](https://github.com/evgenyneu/Cosmos) for more information.

### Step screens

- Create the desired xib screen, with the same name than in StarsKit
- Specify the custom class and the module as "StarsKit"
- Uncheck "Inherit Module From Target"

IBOutlets are optionnals, so you can decide if you want to implement them or not.

<p align="center"><img width=90% border=1 src="./img/custom_xib_class.png"></p>
<p align="center"><img width=90% border=1 src="./img/custom_xib.png"></p>
**Note**: if you want to test it in the demo project, check the `FeedbackViewController.xib` in the StarsKit-Example target.

### Override localizable strings

Simple add in your Localizable strings the localizable key(s) to override

See the default `StarsKit.strings` keys.

```
"starskit.mainTitle" = "My overrided title";
```

### Override step controllers

### `StarsKitDelegate` : listen to rating callbacks


``` swift
// MARK: - StarsKitDelegate
extension ViewController: StarsKitDelegate {
  func didValidateRating(to rate: Int) {
  	// Why not send an analytic ?
    print("Did validate rating to rate \(rate)")
  }
  
  func didChooseAction(at step: RatingStep) {
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
```

### `StarsKitUIDelegate` : listen to UI cycle events

``` swift

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
  
  func presenterController() -> UIViewController {
    // Return the controller where the rate screen will be presented
    // The current, the top most one, anywhere, anyone
    return self
  }
}
```

## Contributors

Made in 🇫🇷 by the [Smart&Soft](https://smartnsoft.com/) iOS Team.

## License

StarsKit is available under the MIT license. See the LICENSE file for more info.
