//
//  SimulatorKit.swift
//  SimulatorKit
//
//  Created by Tomasz on 05.09.21.
//

public struct SimulatorKit {
  public static func create() -> SimulatorKit {
    return DependenciesContainer.shared.compositionRoot()
  }

  private let simulatorsService: SimulatorsServicable

  init(simulatorsService: SimulatorsServicable) {
    self.simulatorsService = simulatorsService
  }
}
