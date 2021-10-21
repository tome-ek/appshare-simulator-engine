//
//  ProcessService.swift
//  SimulatorKit
//
//  Created by Tomasz on 04.09.21.
//

import PromiseKit

struct ShellCommandService: ShellCommandServicable {
  private enum C {
    static let path = "/bin/zsh"
    static let arguments = "-c"
  }

  private let processProvider: ProcessProviding

  init(processProvider: ProcessProviding) {
    self.processProvider = processProvider
  }

  func runCommand(_ command: Command) -> Promise<Void> {
    Promise { resolver in
      processProvider.processWith(
        C.path,
        arguments: [C.arguments, command.command]
      ) { terminationStatus in
        if terminationStatus != 0 {
          return resolver.reject(command.error)
        }
        
        resolver.fulfill(())
      }
    }
  }
}
