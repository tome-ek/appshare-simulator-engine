//
//  MacOSWindowsCopyingSpec.swift
//  SimulatorKitTests
//
//  Created by Tomasz on 06.09.21.
//

import Mockingbird
import Nimble
import Quartz
import Quick
@testable import SimulatorKit

class MacOSWindowsCopyingSpec: QuickSpec {
  override func spec() {
    let macOSWindowsCopying = MacOSWindowsCopying()
    
    describe("WindowsProvider") {
      describe("copyWindows") {
        it("should copy all windows") {
          // Arrange
          let expectedWindows = NSArray(objects: CGWindowListCopyWindowInfo(.optionAll, kCGNullWindowID)!)
           
          // Act
          let windows = macOSWindowsCopying.copyWindows()
          
          // Assert
          expect(windows.isEqual(to: expectedWindows)).to(beTrue())
        }
      }
    }
  }
}
