//
//  MacOSWindowsCopying.swift
//  SimulatorKit
//
//  Created by Tomasz on 05.09.21.
//

import Foundation

struct MacOSWindowsCopying: CGWindowCopying {
  func copyWindows() -> NSArray {
    return NSArray(object: CGWindowListCopyWindowInfo(.optionAll, kCGNullWindowID)!)
  }
}
