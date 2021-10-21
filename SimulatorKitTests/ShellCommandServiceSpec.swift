//
//  ShellCommandServiceSpec.swift
//  SimulatorKitTests
//
//  Created by Tomasz on 04.09.21.
//

import Mockingbird
import Nimble
import Quick
@testable import SimulatorKit

class ShellCommandServiceSpec: QuickSpec {
  enum Error: SimulatorKitError {
    case mockError

    var message: String {
      return "mock error message"
    }
  }

  enum MockCommand: Command {
    case successful

    var command: String {
      return "foobar"
    }

    var error: SimulatorKitError {
      return Error.mockError
    }
  }

  override func spec() {
    let processProvider = mock(ProcessProviding.self)
    let shellCommandService = ShellCommandService(processProvider: processProvider)

    describe("ShellCommandService") {
      describe("runCommand") {
        beforeEach {
          reset(processProvider)
        }

        it("should resolve on successful termination") {
          // Arrange
          given(processProvider.processWith(any(), arguments: any(), any()))
            .will { _, _, closure in
              closure(0)
            }

          // Act
          let resultPromise = shellCommandService.runCommand(MockCommand.successful)

          // Assert
          expect(resultPromise.value).toEventuallyNot(beNil())
        }

        it("should reject on greater than zero termination status") {
          // Arrange
          given(processProvider.processWith(any(), arguments: any(), any()))
            .will { _, _, closure in
              closure(1)
            }

          // Act
          let resultPromise = shellCommandService.runCommand(MockCommand.successful)

          // Assert
          expect(resultPromise.error).toEventually(matchError(Error.mockError))
        }

        it("should reject on lower than zero termination status") {
          // Arrange
          given(processProvider.processWith(any(), arguments: any(), any()))
            .will { _, _, closure in
              closure(-1)
            }

          // Act
          let resultPromise = shellCommandService.runCommand(MockCommand.successful)

          // Assert
          expect(resultPromise.error).toEventually(matchError(Error.mockError))
        }
      }
    }
  }
}
