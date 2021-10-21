//
//  WindowObserving.swift
//  SimulatorKit
//
//  Created by Tomasz on 18.09.21.
//

import AXSwift
import Foundation

protocol WindowObserving {
  func observeWindowCreated(_ callback: @escaping (UIElement) -> Void)
  func observeWindowMoved(_ callback: @escaping (UIElement) -> Void)
}
