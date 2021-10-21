//
//  Process+Processable.swift
//  SimulatorKit
//
//  Created by Tomasz on 04.09.21.
//

import Foundation

struct Process: Processable {
  var launchPath: String

  var arguments: [String]

  func start(_ callback: @escaping ((TerminationStatus) -> Void)) {
    process.terminationHandler = { process in
      callback(process.terminationStatus)
    }
    process.launch()
  }

  private let process: Foundation.Process

  init(launchPath: String, arguments: [String]) {
    self.launchPath = launchPath
    self.arguments = arguments

    let process = Foundation.Process()
    
    process.launchPath = launchPath
    process.arguments = arguments

    self.process = process
  }
}
