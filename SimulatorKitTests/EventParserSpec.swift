//
//  EventParserSpec.swift
//  SimulatorKitTests
//
//  Created by Tomasz on 03.09.21.
//

import Nimble
import Quick
@testable import SimulatorKit

class EventParserSpec: QuickSpec {
  override func spec() {
    let eventParser = EventParser()

    describe("EventParser") {
      describe("parseEvent") {
        it("should parse touch down events") {
          let eventString = "\("foobar")\("0")\("000.50")\("111.50")"

          let event = eventParser.parseEvent(eventString)

          expect(event).toNot(beNil())
          expect(event?.payload).to(beAKindOf(MouseEventPayload.self))

          let payload = event!.payload as! MouseEventPayload

          expect(payload.sessionId).to(equal(SessionId("foobar")))
          expect(payload.systemEventType).to(equal(.leftMouseDown))
          expect(payload.x).to(equal(0.5))
          expect(payload.y).to(equal(111.5))
        }

        it("should parse touch up events") {
          let eventString = "\("!@#$%^")\("1")\("999.99")\("000.00")"

          let event = eventParser.parseEvent(eventString)

          expect(event).toNot(beNil())
          expect(event?.payload).to(beAKindOf(MouseEventPayload.self))

          let payload = event!.payload as! MouseEventPayload

          expect(payload.sessionId).to(equal(SessionId("!@#$%^")))
          expect(payload.systemEventType).to(equal(.leftMouseUp))
          expect(payload.x).to(equal(999.99))
          expect(payload.y).to(equal(0))
        }

        it("should parse touch move events") {
          let eventString = "\("ąćźżłó")\("2")\("123.45")\("543.21")"

          let event = eventParser.parseEvent(eventString)

          expect(event).toNot(beNil())
          expect(event?.payload).to(beAKindOf(MouseEventPayload.self))

          let payload = event!.payload as! MouseEventPayload

          expect(payload.sessionId).to(equal(SessionId("ąćźżłó")))
          expect(payload.systemEventType).to(equal(.leftMouseDragged))
          expect(payload.x).to(equal(123.45))
          expect(payload.y).to(equal(543.21))
        }

        it("should parse keyboard events") {
          let eventString = "\("------")\("3")\("100")\("00")"

          let event = eventParser.parseEvent(eventString)

          expect(event).toNot(beNil())
          expect(event?.payload).to(beAKindOf(KeyboardEventPayload.self))

          let payload = event!.payload as! KeyboardEventPayload

          expect(payload.sessionId).to(equal(SessionId("------")))
          expect(payload.keyCode).to(equal(UInt16(100)))
          expect(payload.modifierKeys).to(equal(ModifierKeys.none))
        }

        it("should parse keyboard events with both flags") {
          let eventString = "\("foobar")\("3")\("222")\("11")"

          let event = eventParser.parseEvent(eventString)

          let payload = event!.payload as! KeyboardEventPayload
          expect(payload.modifierKeys).to(equal([.alt, .shift]))
        }

        it("should parse keyboard events with shift flag") {
          let eventString = "\("foobar")\("3")\("333")\("10")"

          let event = eventParser.parseEvent(eventString)

          let payload = event!.payload as! KeyboardEventPayload
          expect(payload.modifierKeys).to(equal(.shift))
        }

        it("should parse keyboard events with alt flag") {
          let eventString = "\("foobar")\("3")\("444")\("01")"

          let event = eventParser.parseEvent(eventString)

          let payload = event!.payload as! KeyboardEventPayload
          expect(payload.modifierKeys).to(equal(.alt))
        }

        it("should not parse too short session id") {
          let eventString = "\("foo")\("0")\("000.00")\("000.00")"

          let event = eventParser.parseEvent(eventString)

          expect(event).to(beNil())
        }

        it("should not parse unknown event type") {
          let eventString = "\("foobar")\("4")\("000.00")\("000.00")"

          let event = eventParser.parseEvent(eventString)

          expect(event).to(beNil())
        }

        it("should not parse touch events with invalid x coordinate") {
          let eventString = "\("foobar")\("1")\("loremi")\("000.00")"

          let event = eventParser.parseEvent(eventString)

          expect(event).to(beNil())
        }

        it("should not parse touch events with invalid y coordinate") {
          let eventString = "\("foobar")\("2")\("000.00")\("loremi")"

          let event = eventParser.parseEvent(eventString)

          expect(event).to(beNil())
        }

        it("should not parse keyboard events with invalid keycode") {
          let eventString = "\("foobar")\("3")\("foo")\("00")"

          let event = eventParser.parseEvent(eventString)

          expect(event).to(beNil())
        }

        it("should not parse keyboard events with missing modifier flags") {
          let eventString = "\("foobar")\("3")\("foo")"

          let event = eventParser.parseEvent(eventString)

          expect(event).to(beNil())
        }

        it("should not parse empty string") {
          let eventString = ""

          let event = eventParser.parseEvent(eventString)

          expect(event).to(beNil())
        }

        it("should not parse just the session id") {
          let eventString = "foobar"

          let event = eventParser.parseEvent(eventString)

          expect(event).to(beNil())
        }
      }
    }
  }
}
