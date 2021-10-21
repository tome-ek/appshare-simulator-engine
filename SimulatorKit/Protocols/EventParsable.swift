//
//  EventParsable.swift
//  SimulatorKit
//
//  Created by Tomasz on 03.09.21.
//

protocol EventParsable {
  func parseEvent(_ eventString: String) -> EventType?
}
