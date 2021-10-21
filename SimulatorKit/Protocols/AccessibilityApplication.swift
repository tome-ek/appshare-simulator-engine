//
//  AccessibilityApplication.swift
//  SimulatorKit
//
//  Created by Tomasz on 18.09.21.
//

import Foundation

protocol AccessibilityApplication {
  func windowObserver(forSimulator simulator: Simulator) -> WindowObserving
}
