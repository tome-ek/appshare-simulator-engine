//
//  SimulatorsFactory.swift
//  SimulatorKit
//
//  Created by Tomasz on 04.09.21.
//

protocol SimulatorsFactory {
  func create(sessionId: String, deviceBlueprint: DeviceBlueprint) -> Simulator
}
