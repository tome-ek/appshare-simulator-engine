//
//  ShellCommandError.swift
//  SimulatorKit
//
//  Created by Tomasz on 04.09.21.
//

enum ShellCommandError: SimulatorKitError {
  case closeSimulatorFailure
  case bootSimulatorFailure
  case cloneSimulatorFailure
  case installAppFailure
  case launchSimulatorAppFailure

  public var message: String {
    switch self {
    case .closeSimulatorFailure:
      return "Failed to close the simulator."
    case .bootSimulatorFailure:
      return "Failed to boot the simulator."
    case .cloneSimulatorFailure:
      return "Failed to boot the simulator."
    case .installAppFailure:
      return "Failed to install the app on the simulator."
    case .launchSimulatorAppFailure:
      return "Failed to launch the simulator process."
    }
  }
}
