//
//  KeyboardEventPayload.swift
//  SimulatorKit
//
//  Created by Tomasz on 03.09.21.
//

protocol KeyboardEventPayload: EventPayload {
  var keyCode: UInt16 { get }
  var modifierKeys: ModifierKeys { get }
}
