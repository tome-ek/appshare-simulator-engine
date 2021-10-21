//
//  SimulatorServicable.swift
//  SimulatorKit
//
//  Created by Tomasz on 04.09.21.
//

import PromiseKit

protocol SimulatorsServicable {
  func createSimulator(
    _ sessionId: String,
    forDeviceBlueprint deviceBlueprint: DeviceBlueprint
  ) -> Promise<Void>
  func shutdownSimulator(_ sessionId: String) -> Promise<Void>
  func installApp(_ appPath: String, sessionId: String) -> Promise<Void>
}
