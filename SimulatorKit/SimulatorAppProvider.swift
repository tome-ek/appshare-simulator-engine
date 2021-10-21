//
//  SimulatorAppProvider.swift
//  SimulatorKit
//
//  Created by Tomasz on 04.09.21.
//

import PromiseKit
import Quartz

struct SimulatorAppProvider: SimulatorAppProvidable {
  let pid: Promise<pid_t>

  private var runningApplication: Promise<NSRunningApplication>

  private let shellCommandService: ShellCommandServicable
  private let workspace: NSWorkspace

  init(
    shellCommandService: ShellCommandServicable,
    workspace: NSWorkspace = NSWorkspace.shared
  ) {
    self.shellCommandService = shellCommandService
    self.workspace = workspace

    let pendingPidPromise = Promise<pid_t>.pending()
    let pendingApplicationPromise = Promise<NSRunningApplication>.pending()
    
    pid = pendingPidPromise.promise
    runningApplication = pendingApplicationPromise.promise

    launchSimulatorApplication()
      .done { runningApplication in
        pendingPidPromise
          .resolver
          .fulfill(runningApplication.processIdentifier)

        pendingApplicationPromise
          .resolver
          .fulfill(runningApplication)
      }
      .catch { error in
        pendingPidPromise
          .resolver
          .reject(error)

        pendingApplicationPromise
          .resolver
          .reject(error)
      }
  }

  private enum C {
    static let simulatorBundleIdentifier = "com.apple.iphonesimulator"
  }

  enum Error: SimulatorKitError {
    case simulatorAppNotFound

    var message: String {
      return "Failed to launch the simulator process."
    }
  }

  private func launchSimulatorApplication() -> Promise<NSRunningApplication> {
    shellCommandService.runCommand(ShellCommand.launchSimulatorApp)
      .map {
        if let runningApplication = workspace.runningApplications
          .first(where: {
            ($0.bundleIdentifier ?? "") == C.simulatorBundleIdentifier
          })
        {
          return runningApplication
        } else {
          throw Error.simulatorAppNotFound
        }
      }
  }
}
