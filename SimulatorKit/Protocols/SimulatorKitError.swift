//
//  SimulatorKitError.swift
//  SimulatorKit
//
//  Created by Tomasz on 04.09.21.
//

import Foundation

protocol SimulatorKitError: Error {
  var message: String { get }
}
