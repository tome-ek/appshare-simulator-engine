//
//  WindowsProviderSpec.swift
//  SimulatorKitTests
//
//  Created by Tomasz on 05.09.21.
//

import Mockingbird
import Nimble
import Quick
@testable import SimulatorKit

class WindowsProviderSpec: QuickSpec {
  override func spec() {
    let windowsCopying = mock(CGWindowCopying.self)
    let windowsProvider = WindowsProvider(windowsCopying: windowsCopying)
    
    describe("WindowsProvider") {
      afterEach {
        reset(windowsCopying)
      }

      describe("visibleWindowsForPid") {
        it("should return visible windows") {
          let (windowsDictionaries, expectedWindows) = Window.Fixture
            .simulatorHasVisibleWindows
          given(windowsCopying.copyWindows()).willReturn(windowsDictionaries)

          let windows = windowsProvider
            .visibleWindowsForPid(Int32(Window.Fixture.simulatorPid))

          expect(windows).to(equal(expectedWindows))
        }
        
        it("should return empty array if no visible windows") {
          let (windowsDictionaries, expectedWindows) = Window.Fixture
            .simulatorHasNoVisibleWindows
          given(windowsCopying.copyWindows()).willReturn(windowsDictionaries)

          let windows = windowsProvider
            .visibleWindowsForPid(Int32(Window.Fixture.simulatorPid))

          expect(windows).to(equal(expectedWindows))
        }
        
        it("should return empty array if no windows are copied") {
          let (windowsDictionaries, expectedWindows) = Window.Fixture
            .noWindowsCopied
          given(windowsCopying.copyWindows()).willReturn(windowsDictionaries)

          let windows = windowsProvider
            .visibleWindowsForPid(Int32(Window.Fixture.simulatorPid))

          expect(windows).to(equal(expectedWindows))
        }
        
        it("should not throw when copied windows have missing keys") {
          let (windowsDictionaries, expectedWindows) = Window.Fixture
            .copiedWindowsHaveMissingKeys
          given(windowsCopying.copyWindows()).willReturn(windowsDictionaries)

          let windows = windowsProvider
            .visibleWindowsForPid(Int32(Window.Fixture.simulatorPid))

          expect(windows).to(equal(expectedWindows))
        }
      }
    }
  }
}
