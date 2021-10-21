//
//  Event+Mouse.swift
//  SimulatorKit
//
//  Created by Tomasz on 03.09.21.
//

extension Event {
  struct Mouse: EventType {
    let payload: EventPayload

    init(_ payload: MouseEventPayload) {
      self.payload = payload
    }
  }
}
