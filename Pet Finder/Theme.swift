//
//  Theme.swift
//  Pet Finder
//
//  Created by MTQ on 8/9/17.
//  Copyright © 2017 Ray Wenderlich. All rights reserved.
//

import UIKit

enum Theme: Int {
  // 1
  case `default`, dark, graphical
  
  // 2
  private enum Keys {
    static let selectedTheme = "Selected Theme"
  }
  
  // 3
  static var current: Theme {
    let storedTheme = UserDefaults.standard.integer(forKey: Keys.selectedTheme)
    return Theme(rawValue: storedTheme) ?? .default
  }
  
  var mainColor: UIColor {
    switch self {
    case .default:
      return UIColor(red: 87/255, green: 188/255, blue: 95/255, alpha: 1)
    case .dark:
      return UIColor(red: 255/255, green: 115/255, blue: 50/255, alpha: 1)
    case .graphical:
      return UIColor(red: 10/255, green: 10/255, blue: 10/255, alpha: 1)
    }
  }
  
  var barStyle: UIBarStyle {
    switch self {
    case .default, .graphical:
      return .default
    case .dark:
      return .black
    }
  }
  
  var navigationBackgroundImage: UIImage? {
    return self == .graphical ? UIImage(named: "navBackground") : nil
  }
  
  var tabBarBackgroundImage: UIImage? {
    return self == .graphical ? UIImage(named: "tabBarBackground") : nil
  }
  
  func apply() {
    // 1
    UserDefaults.standard.set(rawValue, forKey: Keys.selectedTheme)
    UserDefaults.standard.synchronize()
    
    // 2
    UIApplication.shared.delegate?.window??.tintColor = mainColor
    
    UINavigationBar.appearance().barStyle = barStyle
    UINavigationBar.appearance().setBackgroundImage(navigationBackgroundImage, for: .default)
    
    UINavigationBar.appearance().backIndicatorImage = UIImage(named: "backArrow")
    UINavigationBar.appearance().backIndicatorTransitionMaskImage = UIImage(named: "backArrowMaskFixed")
    
    UITabBar.appearance().barStyle = barStyle
    UITabBar.appearance().backgroundImage = tabBarBackgroundImage
    
    let tabIndicator = UIImage(named: "tabBarSelectionIndicator")?.withRenderingMode(.alwaysTemplate)
    let tabResizableIndicator = tabIndicator?.resizableImage(withCapInsets: UIEdgeInsets(top: 0, left: 2.0, bottom: 0, right: 2.0))
    UITabBar.appearance().selectionIndicatorImage = tabResizableIndicator
    
    let controlBackground = UIImage(named: "controlBackground")?.withRenderingMode(.alwaysTemplate).resizableImage(withCapInsets: UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3))
    
    let controlSelectedBackground = UIImage(named: "controlSelectedBackground")?.withRenderingMode(.alwaysTemplate).resizableImage(withCapInsets: UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3))
    
    UISegmentedControl.appearance().setBackgroundImage(controlBackground, for: .normal, barMetrics: .default)
    UISegmentedControl.appearance().setBackgroundImage(controlSelectedBackground, for: .normal, barMetrics: .default)
  }
}
