//
//  Processable.swift
//  SimulatorKit
//
//  Created by Tomasz on 04.09.21.
//

typealias TerminationStatus = Int32

protocol Processable {
  func start(_ callback: @escaping ((TerminationStatus) -> Void))

  var launchPath: String { get set }
  var arguments: [String] { get set }
}
