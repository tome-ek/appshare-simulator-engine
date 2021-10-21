//
//  AccessibilitySimulatorApplicationFactory.swift
//  SimulatorKit
//
//  Created by Tomasz on 18.09.21.
//

import AXSwift
import Foundation

final class AccessibilitySimulatorApplication: AccessibilityApplication {
  enum Error: Swift.Error {
    case instanceDealocated
    case nilObserver
    case windowNotFound
    case moveFailure
  }

  private enum C {
    static let simulatorBundleIdentifier = "com.apple.iphonesimulator"
  }
  
  private let windowsProvider: WindowsProvidable
  private var app: Application?

  init(
    windowsProvider: WindowsProvidable,
    simulatorAppProvider: SimulatorAppProvidable,
    app: Application? = Application.allForBundleID(C.simulatorBundleIdentifier)
      .first
  ) {
    self.windowsProvider = windowsProvider

    if app == nil {
      simulatorAppProvider
        .pid
        .done { [weak self] pid in
          self?.app = Application(forProcessID: pid)
        }
        .cauterize()
    } else {
      self.app = app
    }
  }

}
