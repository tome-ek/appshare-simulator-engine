//
//  ShellCommand.swift
//  SimulatorKit
//
//  Created by Tomasz on 04.09.21.
//

import Foundation

enum ShellCommand: Command, Equatable {
  enum Simulator {
    static let base = "xcrun simctl"
    static let delete = "delete"
    static let boot = "boot"
    static let clone = "clone"
    static let install = "install"
    static let launchApp = "open -a Simulator"
  }

  typealias SessionId = String
  typealias BlueprintId = String
  typealias AppPath = String

  case closeSimulator(SessionId)
  case bootSimulator(SessionId)
  case cloneSimulator(SessionId, BlueprintId)
  case installApp(SessionId, AppPath)
  case launchSimulatorApp

  var command: String {
    switch self {
    case let .closeSimulator(sessionId):
      return "\(Simulator.base) \(Simulator.delete) \(sessionId)"
    case let .bootSimulator(sessionId):
      return "\(Simulator.base) \(Simulator.boot) \(sessionId)"
    case let .cloneSimulator(sessionId, blueprintId):
      return "\(Simulator.base) \(Simulator.clone) \(blueprintId) \(sessionId)"
    case let .installApp(sessionId, appPath):
      return "\(Simulator.base) \(Simulator.install) \(sessionId) \(appPath)"
    case .launchSimulatorApp:
      return Simulator.launchApp
    }
  }

  var error: SimulatorKitError {
    switch self {
    case .closeSimulator:
      return ShellCommandError.closeSimulatorFailure
    case .bootSimulator:
      return ShellCommandError.bootSimulatorFailure
    case .cloneSimulator:
      return ShellCommandError.cloneSimulatorFailure
    case .installApp:
      return ShellCommandError.installAppFailure
    case .launchSimulatorApp:
      return ShellCommandError.launchSimulatorAppFailure
    }
  }
}
