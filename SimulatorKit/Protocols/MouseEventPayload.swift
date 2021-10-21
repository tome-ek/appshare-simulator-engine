//
//  MouseEventPayload.swift
//  SimulatorKit
//
//  Created by Tomasz on 03.09.21.
//

import Quartz

typealias Coordinate = Double

protocol MouseEventPayload: EventPayload {
  var x: Coordinate { get }
  var y: Coordinate { get }
  var pressure: Pressure { get }
  var systemEventType: NSEvent.EventType { get }
}
