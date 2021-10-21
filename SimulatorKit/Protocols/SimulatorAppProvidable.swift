//
//  SimulatorAppProvidable.swift
//  SimulatorKit
//
//  Created by Tomasz on 04.09.21.
//

import Foundation
import PromiseKit

protocol SimulatorAppProvidable {
  var pid: Promise<pid_t> { get }
}
