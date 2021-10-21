//
//  Event+Type.swift
//  SimulatorKit
//
//  Created by Tomasz on 03.09.21.
//

extension Event {
  struct Keyboard: EventType {
    let payload: EventPayload

    init(_ payload: KeyboardEventPayload) {
      self.payload = payload
    }
  }
}
