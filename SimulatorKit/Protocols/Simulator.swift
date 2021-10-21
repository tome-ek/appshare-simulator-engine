//
//  Simulator.swift
//  SimulatorKit
//
//  Created by Tomasz on 04.09.21.
//

import Foundation
import PromiseKit

protocol Simulator {
  var sessionId: String { get }
  var randomYCoordinate: CGFloat { get }
  var window: Window? { get set }

  func installApp(atPath path: String) -> Promise<Void>
  func shutdown() -> Promise<Void>
  func start() -> Promise<Void>
}
