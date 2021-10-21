//
//  WindowsProvider.swift
//  SimulatorKit
//
//  Created by Tomasz on 05.09.21.
//

import Quartz

struct WindowsProvider: WindowsProvidable {
  private let windowsCopying: CGWindowCopying

  init(windowsCopying: CGWindowCopying) {
    self.windowsCopying = windowsCopying
  }

  func visibleWindowsForPid(_ pid: pid_t) -> [Window] {
    let allWindows = windowsCopying
      .copyWindows()
      .compactMap { $0 as? NSArray }
      .first ?? []

    let allWindowsDictionaries = allWindows
      .compactMap { $0 as? [CFString: Any] }

    let allWindowsTuples = allWindowsDictionaries.compactMap {
      (
        $0[kCGWindowOwnerPID] as! Int,
        ($0[kCGWindowIsOnscreen] as? Int) ?? 0,
        ($0[kCGWindowNumber] as? Int) ?? 0,
        $0[kCGWindowBounds]
      )
    }

    let matchingWindowsNumbers = allWindowsTuples
      .filter { $0.0 == pid && $0.1 == 1 }
      .map { ($0.2, $0.3) }

    return matchingWindowsNumbers.map { Window(number: $0.0, bounds: $0.1 != nil ? CGRect(dictionaryRepresentation: ($0.1 as! CFDictionary)) ?? .zero : .zero) }
  }
}
