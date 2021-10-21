//
//  EventPayload.swift
//  SimulatorKit
//
//  Created by Tomasz on 03.09.21.
//

import Quartz

protocol EventPayload {
  var sessionId: SessionId { get }
}
