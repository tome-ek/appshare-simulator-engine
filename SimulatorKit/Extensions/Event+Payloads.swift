//
//  Event+Payload.swift
//  SimulatorKit
//
//  Created by Tomasz on 03.09.21.
//

import Quartz

extension Event {
  enum Payload {
    struct Keyboard: KeyboardEventPayload {
      let keyCode: UInt16
      let modifierKeys: ModifierKeys
      let sessionId: SessionId
    }

    struct Mouse: MouseEventPayload {
      let x: Coordinate
      let y: Coordinate
      let pressure: Pressure
      let systemEventType: NSEvent.EventType
      let sessionId: SessionId
    }
  }
}
