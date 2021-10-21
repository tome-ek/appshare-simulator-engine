//
//  ProcessProviding.swift
//  SimulatorKit
//
//  Created by Tomasz on 04.09.21.
//

protocol ProcessProviding {
  func processWith(
    _ launchPath: String,
    arguments: [String],
    _ terminationHandler: @escaping ((TerminationStatus) -> Void)
  )
}
