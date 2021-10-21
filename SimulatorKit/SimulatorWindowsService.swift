//
//  SimulatorWindowsService.swift
//  SimulatorKit
//
//  Created by Tomasz on 06.09.21.
//

import AXSwift
import Foundation
import PromiseKit

class SimulatorWindowsService: SimulatorWindowsServicable {
  enum Error: Swift.Error {
    case instanceDealocated
    case nilObserver
    case windowNotFound
    case moveFailure
  }

  private enum C {
    static let queueLabel = "com.SimulatorKit.SimulatorWindowsService"
  }

  private let windowsProvider: WindowsProvidable
  private let app: AccessibilityApplication
  
  private var activeObservers: [String: Observer] = [:]
  private let queue = DispatchQueue(label: C.queueLabel)

  init(
    windowsProvider: WindowsProvidable,
    app: AccessibilityApplication
  ) {
    self.windowsProvider = windowsProvider
    self.app = app
  }

  public func windowForSimulator(_ simulator: Simulator) -> Promise<Window> {
    return Promise { [weak self, simulator] resolver in

    }
  }
}
