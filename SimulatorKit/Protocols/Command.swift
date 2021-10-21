//
//  Command.swift
//  SimulatorKit
//
//  Created by Tomasz on 04.09.21.
//

protocol Command {
  var command: String { get }
  var error: SimulatorKitError { get }
}
