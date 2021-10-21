//
//  WindowsProvidable.swift
//  SimulatorKit
//
//  Created by Tomasz on 05.09.21.
//

import Foundation

protocol WindowsProvidable {
  func visibleWindowsForPid(_ pid: pid_t) -> [Window]
}
