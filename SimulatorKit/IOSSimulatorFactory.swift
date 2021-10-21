//
//  IOSSimulatorFactory.swift
//  SimulatorKit
//
//  Created by Tomasz on 04.09.21.
//

struct IOSSimulatorsFactory: SimulatorsFactory {
  private let shellCommandService: ShellCommandServicable

  init(shellCommandService: ShellCommandServicable) {
    self.shellCommandService = shellCommandService
  }

  func create(sessionId: String, deviceBlueprint: DeviceBlueprint) -> Simulator {
    return IOSSimulator(
      sessionId: sessionId,
      deviceBlueprint: deviceBlueprint,
      shellCommandService: shellCommandService
    )
  }
}
