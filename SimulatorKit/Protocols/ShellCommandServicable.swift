//
//  ShellCommandServicable.swift
//  SimulatorKit
//
//  Created by Tomasz on 04.09.21.
//

import PromiseKit

protocol ShellCommandServicable {
  func runCommand(_ command: Command) -> Promise<Void>
}
