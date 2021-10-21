//
//  StringIndex+Initializers.swift
//  SimulatorKit
//
//  Created by Tomasz on 03.09.21.
//

import Foundation

public extension String {
  func substring(from: Int?, to: Int?) -> String? {
    if let start = from {
      guard start < count else {
        return nil
      }
    }

    if let end = to {
      guard end >= 0 else {
        return nil
      }
    }

    if let start = from, let end = to {
      guard end - start >= 0 else {
        return nil
      }
    }

    let startIndex: String.Index
    if let start = from, start >= 0 {
      startIndex = index(self.startIndex, offsetBy: start)
    } else {
      startIndex = self.startIndex
    }

    let endIndex: String.Index
    if let end = to, end >= 0, end < count {
      endIndex = index(self.startIndex, offsetBy: end + 1)
    } else {
      return nil
    }

    return String(self[startIndex ..< endIndex])
  }

  func substring(from: Int?, length: Int) -> String? {
    guard length > 0 else {
      return nil
    }

    let end: Int
    if let start = from, start >= 0 {
      end = start + length - 1
    } else {
      return nil
    }

    return substring(from: from, to: end)
  }
}
