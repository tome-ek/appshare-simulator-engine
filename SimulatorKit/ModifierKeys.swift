//
//  ModifierKeys.swift
//  SimulatorKit
//
//  Created by Tomasz on 03.09.21.
//

struct ModifierKeys: OptionSet {
  static let none = ModifierKeys([])
  static let alt = ModifierKeys(rawValue: 1)
  static let shift = ModifierKeys(rawValue: 1 << 1)

  let rawValue: Int8
}
