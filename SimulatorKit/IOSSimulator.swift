//
//  IOSSimulator.swift
//  SimulatorKit
//
//  Created by Tomasz on 04.09.21.
//

import Foundation
import PromiseKit

struct IOSSimulator: Simulator {
  let sessionId: String
  let randomYCoordinate: CGFloat
  var window: Window?

  private let deviceBlueprint: DeviceBlueprint
  private let shellCommandService: ShellCommandServicable

  init(
    sessionId: String,
    deviceBlueprint: DeviceBlueprint,
    shellCommandService: ShellCommandServicable
  ) {
    self.sessionId = sessionId
    self.deviceBlueprint = deviceBlueprint
    self.shellCommandService = shellCommandService
    self.randomYCoordinate = CGFloat(Int.random(in: 0...720))
  }

  func shutdown() -> Promise<Void> {
    shellCommandService.runCommand(ShellCommand.closeSimulator(sessionId))
  }

  func start() -> Promise<Void> {
    return shellCommandService
      .runCommand(ShellCommand.cloneSimulator(sessionId, deviceBlueprint.identifier))
      .then {
        shellCommandService.runCommand(ShellCommand.bootSimulator(sessionId))
      }
  }

  func installApp(atPath path: String) -> Promise<Void> {
    return shellCommandService
      .runCommand(ShellCommand.installApp(sessionId, path))
  }
}
