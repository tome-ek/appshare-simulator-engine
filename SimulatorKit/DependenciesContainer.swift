//
//  DependenciesContainer.swift
//  SimulatorKit
//
//  Created by Tomasz on 04.09.21.
//

import Swinject

struct DependenciesContainer {
  static let shared = DependenciesContainer()

  func compositionRoot() -> SimulatorKit {
    return container.resolve(SimulatorKit.self)!
  }

  private let container = Container()

  private init() {
    registerDependencies()
  }

  private func registerDependencies() {
    container.register(SimulatorKit.self) {
      SimulatorKit(simulatorsService: $0.resolve(SimulatorsServicable.self)!)
    }

    container.register(ProcessProviding.self) { _ in
      ProcessProvider()
    }

    container.register(ShellCommandServicable.self) {
      ShellCommandService(processProvider: $0.resolve(ProcessProviding.self)!)
    }

    container.register(AccessibilityApplication.self) {
      AccessibilitySimulatorApplication(
        windowsProvider: $0
          .resolve(WindowsProvidable.self)!,
        simulatorAppProvider: $0.resolve(SimulatorAppProvidable.self)!
      )
    }
    
    container.register(SimulatorWindowsServicable.self) {
      SimulatorWindowsService(
        windowsProvider: $0.resolve(WindowsProvidable.self)!,
        app: $0.resolve(AccessibilityApplication.self)!
      )
    }

    container.register(SimulatorsFactory.self) {
      IOSSimulatorsFactory(
        shellCommandService: $0.resolve(ShellCommandServicable.self)!
      )
    }

    container.register(SimulatorsServicable.self) {
      SimulatorsService(
        simulatorsFactory: $0.resolve(SimulatorsFactory.self)!,
        simulatorWindowsService: $0.resolve(SimulatorWindowsServicable.self)!
      )
    }

    container.register(SimulatorAppProvidable.self) {
      SimulatorAppProvider(
        shellCommandService: $0.resolve(ShellCommandServicable.self)!
      )
    }

    container.register(EventParsable.self) { _ in EventParser() }

    container.register(WindowsProvidable.self) {
      WindowsProvider(
        windowsCopying: $0.resolve(CGWindowCopying.self)!
      )
    }

    container.register(CGWindowCopying.self) { _ in MacOSWindowsCopying() }
  }
}
