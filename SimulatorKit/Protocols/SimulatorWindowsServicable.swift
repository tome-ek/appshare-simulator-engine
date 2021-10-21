//
//  SimulatorWindowsServicable.swift
//  SimulatorKit
//
//  Created by Tomasz on 06.09.21.
//

import PromiseKit

protocol SimulatorWindowsServicable {
  func windowForSimulator(_ simulator: Simulator) -> Promise<Window>
}
