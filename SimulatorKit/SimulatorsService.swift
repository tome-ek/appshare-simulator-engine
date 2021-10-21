//
//  SimulatorsService.swift
//  SimulatorKit
//
//  Created by Tomasz on 04.09.21.
//

import PromiseKit

final class SimulatorsService: SimulatorsServicable {
  enum Error: SimulatorKitError {
    case simulatorNotFound

    var message: String {
      switch self {
      case .simulatorNotFound:
        return "Simulator not found for given session id."
      }
    }
  }

  var simulators: [Simulator]
  
  private let simulatorsFactory: SimulatorsFactory
  private let simulatorWindowsService: SimulatorWindowsServicable

  init(
    simulatorsFactory: SimulatorsFactory,
    simulatorWindowsService: SimulatorWindowsServicable
  ) {
    self.simulatorsFactory = simulatorsFactory
    self.simulatorWindowsService = simulatorWindowsService
    
    simulators = []
  }

  func createSimulator(
    _ sessionId: String,
    forDeviceBlueprint deviceBlueprint: DeviceBlueprint
  ) -> Promise<Void> {
    var simulator = simulatorsFactory.create(
      sessionId: sessionId,
      deviceBlueprint: deviceBlueprint
    )
    
    return simulator.start()
      .then { self.simulatorWindowsService.windowForSimulator(simulator) }
      .map { window in
        simulator.window = window
        self.simulators.append(simulator)
      }
      
  }

  func shutdownSimulator(_ sessionId: String) -> Promise<Void> {
    guard let simulator = simulators.first(where: { sessionId == $0.sessionId })
    else { return Promise(error: Error.simulatorNotFound) }

    return simulator.shutdown()
  }

  func installApp(_ appPath: String, sessionId: String) -> Promise<Void> {
    guard let simulator = simulators.first(where: { sessionId == $0.sessionId })
    else { return Promise(error: Error.simulatorNotFound) }

    return simulator.installApp(atPath: appPath)
  }
}
