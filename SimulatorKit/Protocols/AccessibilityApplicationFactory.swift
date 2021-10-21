//
//  AccessibilityApplicationFactory.swift
//  SimulatorKit
//
//  Created by Tomasz on 18.09.21.
//

import AXSwift

protocol AccessibilityApplicationFactory {
  func create(app: Application) -> AccessibilityApplication
}
