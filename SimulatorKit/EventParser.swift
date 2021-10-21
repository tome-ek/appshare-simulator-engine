//
//  EventParser.swift
//  SimulatorKit
//
//  Created by Tomasz on 03.09.21.
//

import Quartz

struct EventParser: EventParsable {
  private enum EventVariant: String {
    case touchDown = "0"
    case touchUp = "1"
    case touchMove = "2"
    case key = "3"
  }

  private enum C {
    static let coordinateLength = 6
    static let eventVariantLength = 1
    static let keyCodeLength = 3
    static let keyFlagLength = 1
  }

  func parseEvent(_ eventString: String) -> EventType? {
    guard let eventVariantString = eventString.substring(
      from: SessionId.C.length,
      length: C.eventVariantLength
    ) else { return nil }

    guard let eventVariant = EventVariant(
      rawValue: eventVariantString
    ) else { return nil }

    return eventForVariant(eventVariant, eventString: eventString)
  }

  private func eventForVariant(
    _ variant: EventVariant,
    eventString: String
  ) -> EventType? {
    guard let sessionIdString = eventString.substring(
      from: .zero,
      length: SessionId.C.length
    ) else { return nil }

    guard let sessionId = SessionId(sessionIdString) else { return nil }

    switch variant {
    case .touchDown, .touchMove, .touchUp:
      return mouseEvent(for: eventString, variant: variant, sessionId: sessionId)
    case .key:
      return keyboardEvent(for: eventString, variant: variant, sessionId: sessionId)
    }
  }

  private func mouseEvent(
    for eventString: String,
    variant: EventVariant,
    sessionId: SessionId
  ) -> Event.Mouse? {
    guard let xCoordinateString = eventString.substring(
      from: SessionId.C.length + C.eventVariantLength,
      length: C.coordinateLength
    ) else { return nil }

    guard let yCoordinateString = eventString.substring(
      from: SessionId.C.length + C.eventVariantLength + C.coordinateLength,
      length: C.coordinateLength
    ) else { return nil }

    guard let xCoordinate = Double(xCoordinateString),
          let yCoordinate = Double(yCoordinateString)
    else { return nil }

    let touchPressure = pressure(for: variant)
    guard let systemEvent = systemEvent(for: variant) else { return nil }

    let mouseEventPayload = Event.Payload.Mouse(
      x: xCoordinate,
      y: yCoordinate,
      pressure: touchPressure,
      systemEventType: systemEvent,
      sessionId: sessionId
    )

    return Event.Mouse(mouseEventPayload)
  }

  private func keyboardEvent(
    for eventString: String,
    variant _: EventVariant,
    sessionId: SessionId
  ) -> Event.Keyboard? {
    guard let keyCodeString = eventString.substring(
      from: SessionId.C.length + C.eventVariantLength,
      length: C.keyCodeLength
    ) else { return nil }

    guard let keyCode = UInt16(keyCodeString) else { return nil }

    guard let hasShiftFlag = eventString.substring(
      from: SessionId.C.length + C.eventVariantLength + C.keyCodeLength,
      length: C.keyFlagLength
    ) else { return nil }

    guard let hasAltFlag = eventString.substring(
      from: SessionId.C.length + C.eventVariantLength + C.keyCodeLength + C
        .keyFlagLength,
      length: C.keyFlagLength
    ) else { return nil }

    var modifierKeys = ModifierKeys()

    if hasShiftFlag == "1" {
      modifierKeys.insert(.shift)
    }
    if hasAltFlag == "1" {
      modifierKeys.insert(.alt)
    }

    let keyboardEventPayload = Event.Payload.Keyboard(
      keyCode: keyCode, modifierKeys: modifierKeys, sessionId: sessionId
    )

    return Event.Keyboard(keyboardEventPayload)
  }

  private func systemEvent(for variant: EventVariant) -> NSEvent.EventType? {
    switch variant {
    case .touchDown:
      return .leftMouseDown
    case .touchUp:
      return .leftMouseUp
    case .touchMove:
      return .leftMouseDragged
    default:
      return nil
    }
  }

  private func pressure(for variant: EventVariant) -> Pressure {
    switch variant {
    case .touchDown:
      return .applied
    default:
      return .none
    }
  }
}
