//
//  SimulatorsServiceSpec.swift
//  SimulatorKitTests
//
//  Created by Tomasz on 04.09.21.
//

import Mockingbird
import Nimble
import PromiseKit
import Quartz
import Quick
@testable import SimulatorKit

class SimulatorsServiceSpec: QuickSpec {
  override func spec() {
    let shellCommandService = mock(ShellCommandServicable.self)
    
    let simulatorWindowService = mock(SimulatorWindowsServicable.self)
    given(simulatorWindowService.windowForSimulator(any()))
      .willReturn(.value(Window(number: 1, bounds: .zero)))

    let simulatorsFacory = mock(SimulatorsFactory.self)
    given(simulatorsFacory.create(
      sessionId: any(),
      deviceBlueprint: any(IPhoneDeviceBlueprint.self)
    )).will { sessionId, deviceBlueprint in
      IOSSimulator(
        sessionId: sessionId,
        deviceBlueprint: deviceBlueprint,
        shellCommandService: shellCommandService
      )
    }

    let simulatorsService = SimulatorsService(
      simulatorsFactory: simulatorsFacory,
      simulatorWindowsService: simulatorWindowService
    )

    describe("SimulatorsService") {
      beforeEach {
        reset(shellCommandService)
        clearInvocations(on: simulatorsFacory)
      }

      describe("createSimulator") {
        it("should resolve when simulator app is running") {
          // Arrange
          given(shellCommandService.runCommand(any())).willReturn(.value)

          // Act
          let resultPromise = simulatorsService.createSimulator(
            "foobar",
            forDeviceBlueprint: IPhoneDeviceBlueprint.iphone8
          )

          // Assert
          expect(resultPromise.value).toEventuallyNot(beNil())
        }

        it("should invoke create simulator on factory") {
          // Arrange
          given(shellCommandService.runCommand(any())).willReturn(.value)

          // Act
          _ = simulatorsService.createSimulator(
            "foobar",
            forDeviceBlueprint: IPhoneDeviceBlueprint.iphone8
          )

          // Assert
          let expectation = eventually {
            verify(simulatorsFacory.create(
              sessionId: "foobar",
              deviceBlueprint: any(IPhoneDeviceBlueprint.self, of: .iphone8)
            )).wasCalled()
          }
          self.wait(for: [expectation], timeout: 1.0)
        }

        it("should run clone simulator command") {
          // Arrange
          given(shellCommandService.runCommand(any())).willReturn(.value)

          // Act
          _ = simulatorsService.createSimulator(
            "foobar",
            forDeviceBlueprint: IPhoneDeviceBlueprint.iphone8
          )

          // Assert
          let expectation = eventually {
            verify(shellCommandService.runCommand(any(
              ShellCommand.self,
              of: .cloneSimulator("foobar", IPhoneDeviceBlueprint.iphone8.identifier)
            ))).wasCalled()
          }
          self.wait(for: [expectation], timeout: 1.0)
        }

        it("should run boot simulator command") {
          // Arrange
          given(shellCommandService.runCommand(any())).willReturn(.value)

          // Act
          _ = simulatorsService.createSimulator(
            "foobar",
            forDeviceBlueprint: IPhoneDeviceBlueprint.iphone8
          )

          // Assert
          let expectation = eventually {
            verify(shellCommandService.runCommand(any(
              ShellCommand.self,
              of: .bootSimulator("foobar")
            ))).wasCalled()
          }
          self.wait(for: [expectation], timeout: 1.0)
        }

        it("should reject when cloning simulator fails") {
          // Arrange
          given(shellCommandService.runCommand(any(
            ShellCommand.self,
            of: .cloneSimulator("foobar", IPhoneDeviceBlueprint.iphone8.identifier)
          )))
            .willReturn(Promise(error: ShellCommandError.cloneSimulatorFailure))

          // Act
          let resultPromise = simulatorsService.createSimulator(
            "foobar",
            forDeviceBlueprint: IPhoneDeviceBlueprint.iphone8
          )

          // Assert
          expect(resultPromise.error)
            .toEventually(matchError(ShellCommandError.cloneSimulatorFailure))
        }

        it("should reject when booting simulator fails") {
          // Arrange
          given(shellCommandService.runCommand(any(
            ShellCommand.self,
            of: .cloneSimulator("foobar", IPhoneDeviceBlueprint.iphone8.identifier)
          )))
            .willReturn(.value)

          given(shellCommandService.runCommand(any(
            ShellCommand.self,
            of: .bootSimulator("foobar")
          )))
            .willReturn(Promise(error: ShellCommandError.bootSimulatorFailure))

          // Act
          let resultPromise = simulatorsService.createSimulator(
            "foobar",
            forDeviceBlueprint: IPhoneDeviceBlueprint.iphone8
          )

          // Assert
          expect(resultPromise.error)
            .toEventually(matchError(ShellCommandError.bootSimulatorFailure))
        }
      }

      describe("shutdownSimulator") {
        it("should resolve when simulator is running") {
          given(shellCommandService.runCommand(any())).willReturn(.value)

          // Act
          let resultPromise = simulatorsService.createSimulator(
            "foobar",
            forDeviceBlueprint: IPhoneDeviceBlueprint.iphone8
          )
          .then {
            simulatorsService.shutdownSimulator("foobar")
          }

          // Assert
          expect(resultPromise.value).toEventuallyNot(beNil())
        }

        it("should reject when simulator does not exist") {
          given(shellCommandService.runCommand(any())).willReturn(.value)

          // Act
          let resultPromise = simulatorsService.shutdownSimulator("bazbar")

          // Assert
          expect(resultPromise.error)
            .toEventually(matchError(SimulatorsService.Error.simulatorNotFound))
        }

        it("should run close simulator command") {
          // Arrange
          given(shellCommandService.runCommand(any())).willReturn(.value)

          // Act
          _ = simulatorsService.createSimulator(
            "foobar",
            forDeviceBlueprint: IPhoneDeviceBlueprint.iphone8
          )
          .then {
            simulatorsService.shutdownSimulator("foobar")
          }

          // Assert
          let expectation = eventually {
            verify(shellCommandService.runCommand(any(
              ShellCommand.self,
              of: .closeSimulator("foobar")
            ))).wasCalled()
          }
          self.wait(for: [expectation], timeout: 1.0)
        }
      }

      describe("installApp") {
        it("should resolve when simulator is running") {
          given(shellCommandService.runCommand(any())).willReturn(.value)

          // Act
          let resultPromise = simulatorsService.createSimulator(
            "foobar",
            forDeviceBlueprint: IPhoneDeviceBlueprint.iphone8
          )
          .then {
            simulatorsService.installApp("foo/bar", sessionId: "foobar")
          }

          // Assert
          expect(resultPromise.value).toEventuallyNot(beNil())
        }

        it("should reject when simulator does not exist") {
          given(shellCommandService.runCommand(any())).willReturn(.value)

          // Act
          let resultPromise = simulatorsService.installApp(
            "foo/bar",
            sessionId: "bazbar"
          )

          // Assert
          expect(resultPromise.error)
            .toEventually(matchError(SimulatorsService.Error.simulatorNotFound))
        }

        it("should run install app command") {
          // Arrange
          given(shellCommandService.runCommand(any())).willReturn(.value)

          // Act
          _ = simulatorsService.createSimulator(
            "foobar",
            forDeviceBlueprint: IPhoneDeviceBlueprint.iphone8
          )
          .then {
            simulatorsService.installApp("foo/bar", sessionId: "foobar")
          }

          // Assert
          let expectation = eventually {
            verify(shellCommandService.runCommand(any(
              ShellCommand.self,
              of: .installApp("foobar", "foo/bar")
            ))).wasCalled()
          }
          self.wait(for: [expectation], timeout: 1.0)
        }
      }
    }
  }
}
