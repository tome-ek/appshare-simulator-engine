//
//  SessionId.swift
//  SimulatorKit
//
//  Created by Tomasz on 03.09.21.
//

struct SessionId: Equatable {
  enum C {
    static let length = 6
  }

  let value: String

  init?(_ value: String) {
    guard value.count == C.length else { return nil }

    self.value = value
  }
}
