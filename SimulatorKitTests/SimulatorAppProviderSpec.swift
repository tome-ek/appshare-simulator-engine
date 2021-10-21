//
//  SimulatorAppProviderSpec.swift
//  SimulatorKitTests
//
//  Created by Tomasz on 04.09.21.
//

import Mockingbird
import Nimble
import Quartz
import Quick
@testable import SimulatorKit

class SimulatorAppProviderSpec: QuickSpec {
  override func spec() {
    let shellCommandService = mock(ShellCommandServicable.self)

    describe("SimulatorAppProvider") {
      afterEach {
        reset(shellCommandService)
      }

      describe("pid") {
        it("should resolve when simulator app is running") {
          let expectedPid: pid_t = 42

          given(shellCommandService.runCommand(any()))
            .willReturn(.value)

          let workspace = mock(NSWorkspace.self)
          let simulatorApplication = mock(NSRunningApplication.self)

          given(simulatorApplication.bundleIdentifier)
            .willReturn("com.apple.iphonesimulator")
          given(simulatorApplication.processIdentifier)
            .willReturn(expectedPid)
          given(workspace.runningApplications).willReturn([simulatorApplication])

          let simulatorAppProvider =
            SimulatorAppProvider(
              shellCommandService: shellCommandService,
              workspace: workspace
            )
          let pid = simulatorAppProvider.pid

          expect(pid.value).toEventually(equal(expectedPid))
        }

        it("should reject when simulator app is not running") {
          given(shellCommandService.runCommand(any()))
            .willReturn(.value)
          let workspace = mock(NSWorkspace.self)

          given(workspace.runningApplications).willReturn([])

          let simulatorAppProvider =
            SimulatorAppProvider(
              shellCommandService: shellCommandService,
              workspace: workspace
            )
          let pid = simulatorAppProvider.pid

          expect(pid.error)
            .toEventually(matchError(
              SimulatorAppProvider.Error
                .simulatorAppNotFound
            ))
        }
      }
    }
  }
}
