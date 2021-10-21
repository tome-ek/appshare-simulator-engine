//
//  ProcessProvider.swift
//  SimulatorKit
//
//  Created by Tomasz on 04.09.21.
//

import Foundation

struct ProcessProvider: ProcessProviding {
  func processWith(
    _ launchPath: String,
    arguments: [String],
    _ terminationHandler: @escaping ((TerminationStatus) -> Void)
  ) {
    let process = Process(launchPath: launchPath, arguments: arguments)
    process.start { terminationStatus in
      terminationHandler(terminationStatus)
    }
  }
}
