//
//  Window+Fixtures.swift
//  SimulatorKitTests
//
//  Created by Tomasz on 05.09.21.
//

import Foundation
@testable import SimulatorKit

typealias WindowsFixture = (windowsDictionaries: NSArray, expectedWindows: [Window])

extension Window {
  enum Fixture {
    static var simulatorPid: Int = 42

    static var simulatorHasVisibleWindows: WindowsFixture {
      let visibleSimulatorWindow1: [CFString: Any] = [
        kCGWindowOwnerPID: simulatorPid,
        kCGWindowIsOnscreen: Int(1),
        kCGWindowNumber: Int(1),
      ]
      let visibleSimulatorWindow2: [CFString: Any] = [
        kCGWindowOwnerPID: simulatorPid,
        kCGWindowIsOnscreen: Int(1),
        kCGWindowNumber: Int(2),
      ]
      let visibleSimulatorWindow3: [CFString: Any] = [
        kCGWindowOwnerPID: simulatorPid,
        kCGWindowIsOnscreen: Int(1),
        kCGWindowNumber: Int(3),
      ]
      let invisibleSimulatorWindow1: [CFString: Any] = [
        kCGWindowOwnerPID: simulatorPid,
        kCGWindowIsOnscreen: Int(0),
        kCGWindowNumber: Int(4),
      ]

      let visibleOtherAppWindow1: [CFString: Any] = [
        kCGWindowOwnerPID: Int(9001),
        kCGWindowIsOnscreen: Int(1),
        kCGWindowNumber: Int(5),
      ]
      let invisibleOtherAppWindow1: [CFString: Any] = [
        kCGWindowOwnerPID: Int(9001),
        kCGWindowIsOnscreen: Int(1),
        kCGWindowNumber: Int(6),
      ]

      let expectedWindows = [
        Window(number: 1, bounds: .zero),
        Window(number: 2, bounds: .zero),
        Window(number: 3, bounds: .zero),
      ]

      return (
        windowsDictionaries: NSArray(arrayLiteral: [visibleSimulatorWindow1,
                                                    visibleSimulatorWindow2,
                                                    visibleSimulatorWindow3,
                                                    invisibleSimulatorWindow1,
                                                    visibleOtherAppWindow1,
                                                    invisibleOtherAppWindow1]),
        expectedWindows: expectedWindows
      )
    }
    
    static var simulatorHasNoVisibleWindows: WindowsFixture {
      let visibleSimulatorWindow1: [CFString: Any] = [
        kCGWindowOwnerPID: simulatorPid,
        kCGWindowIsOnscreen: Int(0),
        kCGWindowNumber: Int(1),
      ]
      let visibleSimulatorWindow2: [CFString: Any] = [
        kCGWindowOwnerPID: simulatorPid,
        kCGWindowIsOnscreen: Int(0),
        kCGWindowNumber: Int(2),
      ]
      let visibleSimulatorWindow3: [CFString: Any] = [
        kCGWindowOwnerPID: simulatorPid,
        kCGWindowIsOnscreen: Int(0),
        kCGWindowNumber: Int(3),
      ]
      let invisibleSimulatorWindow1: [CFString: Any] = [
        kCGWindowOwnerPID: simulatorPid,
        kCGWindowIsOnscreen: Int(0),
        kCGWindowNumber: Int(4),
      ]

      let visibleOtherAppWindow1: [CFString: Any] = [
        kCGWindowOwnerPID: Int(9001),
        kCGWindowIsOnscreen: Int(1),
        kCGWindowNumber: Int(5),
      ]
      let invisibleOtherAppWindow1: [CFString: Any] = [
        kCGWindowOwnerPID: Int(9001),
        kCGWindowIsOnscreen: Int(1),
        kCGWindowNumber: Int(6),
      ]

      let expectedWindows = [Window]()

      return (
        windowsDictionaries: NSArray(arrayLiteral: [visibleSimulatorWindow1,
                                                    visibleSimulatorWindow2,
                                                    visibleSimulatorWindow3,
                                                    invisibleSimulatorWindow1,
                                                    visibleOtherAppWindow1,
                                                    invisibleOtherAppWindow1]),
        expectedWindows: expectedWindows
      )
    }
    
    static var copiedWindowsHaveMissingKeys: WindowsFixture {
      let visibleSimulatorWindow1: [CFString: Any] = [
        kCGWindowOwnerPID: simulatorPid,
        kCGWindowIsOnscreen: Int(1),
        kCGWindowNumber: Int(1),
      ]
      let visibleSimulatorWindow2: [CFString: Any] = [
        kCGWindowOwnerPID: simulatorPid,
      ]
      let visibleSimulatorWindow3: [CFString: Any] = [
        kCGWindowOwnerPID: simulatorPid,
      ]
      let invisibleSimulatorWindow1: [CFString: Any] = [
        kCGWindowOwnerPID: simulatorPid,
      ]

      let visibleOtherAppWindow1: [CFString: Any] = [
        kCGWindowOwnerPID: Int(9001),
      ]
      let invisibleOtherAppWindow1: [CFString: Any] = [
        kCGWindowOwnerPID: Int(9001),
      ]

      let expectedWindows = [Window(number: 1, bounds: .zero)]

      return (
        windowsDictionaries: NSArray(arrayLiteral: [visibleSimulatorWindow1,
                                                    visibleSimulatorWindow2,
                                                    visibleSimulatorWindow3,
                                                    invisibleSimulatorWindow1,
                                                    visibleOtherAppWindow1,
                                                    invisibleOtherAppWindow1]),
        expectedWindows: expectedWindows
      )
    }
    
    static var noWindowsCopied: WindowsFixture {
      let expectedWindows = [Window]()

      return (
        windowsDictionaries: NSArray(arrayLiteral: []),
        expectedWindows: expectedWindows
      )
    }
  }
}
