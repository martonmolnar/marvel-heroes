// Generated using Sourcery 1.0.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT



// Generated with SwiftyMocky 4.0.4

import SwiftyMocky
import XCTest
import Foundation
import Common
import Domain
import RxRelay
import RxSwift
import Core
import UI
@testable import Core
@testable import UI


// MARK: - Action

open class ActionMock: Action, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst

    private var queue = DispatchQueue(label: "com.swiftymocky.invocations", qos: .userInteractive)
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }






    fileprivate struct MethodType {
        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult { return .match }
        func intValue() -> Int { return 0 }
        func assertionName() -> String { return "" }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


    }

    public struct Verify {
        fileprivate var method: MethodType

    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        self.queue.sync { invocations.append(call) }
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }
    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        return matchingCalls(method.method, file: file, line: line).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

// MARK: - Coordinator

open class CoordinatorMock: Coordinator, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst

    private var queue = DispatchQueue(label: "com.swiftymocky.invocations", qos: .userInteractive)
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }

    public var navigator: NavigatorType {
		get {	invocations.append(.p_navigator_get); return __p_navigator ?? givenGetterValue(.p_navigator_get, "CoordinatorMock - stub value for navigator was not defined") }
	}
	private var __p_navigator: (NavigatorType)?





    open func start(payload: QueryParameters?) {
        addInvocation(.m_start__payload_payload(Parameter<QueryParameters?>.value(`payload`)))
		let perform = methodPerformValue(.m_start__payload_payload(Parameter<QueryParameters?>.value(`payload`))) as? (QueryParameters?) -> Void
		perform?(`payload`)
    }

    open func start() {
        addInvocation(.m_start)
		let perform = methodPerformValue(.m_start) as? () -> Void
		perform?()
    }


    fileprivate enum MethodType {
        case m_start__payload_payload(Parameter<QueryParameters?>)
        case m_start
        case p_navigator_get

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_start__payload_payload(let lhsPayload), .m_start__payload_payload(let rhsPayload)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsPayload, rhs: rhsPayload, with: matcher), lhsPayload, rhsPayload, "payload"))
				return Matcher.ComparisonResult(results)

            case (.m_start, .m_start): return .match
            case (.p_navigator_get,.p_navigator_get): return Matcher.ComparisonResult.match
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_start__payload_payload(p0): return p0.intValue
            case .m_start: return 0
            case .p_navigator_get: return 0
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_start__payload_payload: return ".start(payload:)"
            case .m_start: return ".start()"
            case .p_navigator_get: return "[get] .navigator"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }

        public static func navigator(getter defaultValue: NavigatorType...) -> PropertyStub {
            return Given(method: .p_navigator_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }

    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func start(payload: Parameter<QueryParameters?>) -> Verify { return Verify(method: .m_start__payload_payload(`payload`))}
        public static func start() -> Verify { return Verify(method: .m_start)}
        public static var navigator: Verify { return Verify(method: .p_navigator_get) }
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func start(payload: Parameter<QueryParameters?>, perform: @escaping (QueryParameters?) -> Void) -> Perform {
            return Perform(method: .m_start__payload_payload(`payload`), performs: perform)
        }
        public static func start(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_start, performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        self.queue.sync { invocations.append(call) }
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }
    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        return matchingCalls(method.method, file: file, line: line).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

// MARK: - DataBinder

open class DataBinderMock<Data>: DataBinder, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst

    private var queue = DispatchQueue(label: "com.swiftymocky.invocations", qos: .userInteractive)
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }





    open func bind() -> Data {
        addInvocation(.m_bind)
		let perform = methodPerformValue(.m_bind) as? () -> Void
		perform?()
		var __value: Data
		do {
		    __value = try methodReturnValue(.m_bind).casted()
		} catch {
			onFatalFailure("Stub return value not specified for bind(). Use given")
			Failure("Stub return value not specified for bind(). Use given")
		}
		return __value
    }

    open func setParameter(param: NavigationParameter) {
        addInvocation(.m_setParameter__param_param(Parameter<NavigationParameter>.value(`param`)))
		let perform = methodPerformValue(.m_setParameter__param_param(Parameter<NavigationParameter>.value(`param`))) as? (NavigationParameter) -> Void
		perform?(`param`)
    }


    fileprivate enum MethodType {
        case m_bind
        case m_setParameter__param_param(Parameter<NavigationParameter>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_bind, .m_bind): return .match

            case (.m_setParameter__param_param(let lhsParam), .m_setParameter__param_param(let rhsParam)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsParam, rhs: rhsParam, with: matcher), lhsParam, rhsParam, "param"))
				return Matcher.ComparisonResult(results)
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case .m_bind: return 0
            case let .m_setParameter__param_param(p0): return p0.intValue
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_bind: return ".bind()"
            case .m_setParameter__param_param: return ".setParameter(param:)"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func bind(willReturn: Data...) -> MethodStub {
            return Given(method: .m_bind, products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func bind(willProduce: (Stubber<Data>) -> Void) -> MethodStub {
            let willReturn: [Data] = []
			let given: Given = { return Given(method: .m_bind, products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Data).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func bind() -> Verify { return Verify(method: .m_bind)}
        public static func setParameter(param: Parameter<NavigationParameter>) -> Verify { return Verify(method: .m_setParameter__param_param(`param`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func bind(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_bind, performs: perform)
        }
        public static func setParameter(param: Parameter<NavigationParameter>, perform: @escaping (NavigationParameter) -> Void) -> Perform {
            return Perform(method: .m_setParameter__param_param(`param`), performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        self.queue.sync { invocations.append(call) }
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }
    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        return matchingCalls(method.method, file: file, line: line).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

// MARK: - DispatcherInterface

open class DispatcherInterfaceMock: DispatcherInterface, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst

    private var queue = DispatchQueue(label: "com.swiftymocky.invocations", qos: .userInteractive)
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }





    open func dispatch(_ action: Action) {
        addInvocation(.m_dispatch__action(Parameter<Action>.value(`action`)))
		let perform = methodPerformValue(.m_dispatch__action(Parameter<Action>.value(`action`))) as? (Action) -> Void
		perform?(`action`)
    }

    open func register<T: Store>(store: T) -> DispatchToken {
        addInvocation(.m_register__store_store(Parameter<T>.value(`store`).wrapAsGeneric()))
		let perform = methodPerformValue(.m_register__store_store(Parameter<T>.value(`store`).wrapAsGeneric())) as? (T) -> Void
		perform?(`store`)
		var __value: DispatchToken
		do {
		    __value = try methodReturnValue(.m_register__store_store(Parameter<T>.value(`store`).wrapAsGeneric())).casted()
		} catch {
			onFatalFailure("Stub return value not specified for register<T: Store>(store: T). Use given")
			Failure("Stub return value not specified for register<T: Store>(store: T). Use given")
		}
		return __value
    }

    open func unregister(token: DispatchToken?) {
        addInvocation(.m_unregister__token_token(Parameter<DispatchToken?>.value(`token`)))
		let perform = methodPerformValue(.m_unregister__token_token(Parameter<DispatchToken?>.value(`token`))) as? (DispatchToken?) -> Void
		perform?(`token`)
    }


    fileprivate enum MethodType {
        case m_dispatch__action(Parameter<Action>)
        case m_register__store_store(Parameter<GenericAttribute>)
        case m_unregister__token_token(Parameter<DispatchToken?>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_dispatch__action(let lhsAction), .m_dispatch__action(let rhsAction)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsAction, rhs: rhsAction, with: matcher), lhsAction, rhsAction, "_ action"))
				return Matcher.ComparisonResult(results)

            case (.m_register__store_store(let lhsStore), .m_register__store_store(let rhsStore)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsStore, rhs: rhsStore, with: matcher), lhsStore, rhsStore, "store"))
				return Matcher.ComparisonResult(results)

            case (.m_unregister__token_token(let lhsToken), .m_unregister__token_token(let rhsToken)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsToken, rhs: rhsToken, with: matcher), lhsToken, rhsToken, "token"))
				return Matcher.ComparisonResult(results)
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_dispatch__action(p0): return p0.intValue
            case let .m_register__store_store(p0): return p0.intValue
            case let .m_unregister__token_token(p0): return p0.intValue
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_dispatch__action: return ".dispatch(_:)"
            case .m_register__store_store: return ".register(store:)"
            case .m_unregister__token_token: return ".unregister(token:)"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func register<T: Store>(store: Parameter<T>, willReturn: DispatchToken...) -> MethodStub {
            return Given(method: .m_register__store_store(`store`.wrapAsGeneric()), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func register<T: Store>(store: Parameter<T>, willProduce: (Stubber<DispatchToken>) -> Void) -> MethodStub {
            let willReturn: [DispatchToken] = []
			let given: Given = { return Given(method: .m_register__store_store(`store`.wrapAsGeneric()), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (DispatchToken).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func dispatch(_ action: Parameter<Action>) -> Verify { return Verify(method: .m_dispatch__action(`action`))}
        public static func register<T>(store: Parameter<T>) -> Verify where T:Store { return Verify(method: .m_register__store_store(`store`.wrapAsGeneric()))}
        public static func unregister(token: Parameter<DispatchToken?>) -> Verify { return Verify(method: .m_unregister__token_token(`token`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func dispatch(_ action: Parameter<Action>, perform: @escaping (Action) -> Void) -> Perform {
            return Perform(method: .m_dispatch__action(`action`), performs: perform)
        }
        public static func register<T>(store: Parameter<T>, perform: @escaping (T) -> Void) -> Perform where T:Store {
            return Perform(method: .m_register__store_store(`store`.wrapAsGeneric()), performs: perform)
        }
        public static func unregister(token: Parameter<DispatchToken?>, perform: @escaping (DispatchToken?) -> Void) -> Perform {
            return Perform(method: .m_unregister__token_token(`token`), performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        self.queue.sync { invocations.append(call) }
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }
    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        return matchingCalls(method.method, file: file, line: line).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

// MARK: - EventListener

open class EventListenerMock<Events>: EventListener, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst

    private var queue = DispatchQueue(label: "com.swiftymocky.invocations", qos: .userInteractive)
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }





    open func listen(events: Events) {
        addInvocation(.m_listen__events_events(Parameter<Events>.value(`events`)))
		let perform = methodPerformValue(.m_listen__events_events(Parameter<Events>.value(`events`))) as? (Events) -> Void
		perform?(`events`)
    }

    open func setParameter(param: NavigationParameter) {
        addInvocation(.m_setParameter__param_param(Parameter<NavigationParameter>.value(`param`)))
		let perform = methodPerformValue(.m_setParameter__param_param(Parameter<NavigationParameter>.value(`param`))) as? (NavigationParameter) -> Void
		perform?(`param`)
    }


    fileprivate enum MethodType {
        case m_listen__events_events(Parameter<Events>)
        case m_setParameter__param_param(Parameter<NavigationParameter>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_listen__events_events(let lhsEvents), .m_listen__events_events(let rhsEvents)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsEvents, rhs: rhsEvents, with: matcher), lhsEvents, rhsEvents, "events"))
				return Matcher.ComparisonResult(results)

            case (.m_setParameter__param_param(let lhsParam), .m_setParameter__param_param(let rhsParam)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsParam, rhs: rhsParam, with: matcher), lhsParam, rhsParam, "param"))
				return Matcher.ComparisonResult(results)
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_listen__events_events(p0): return p0.intValue
            case let .m_setParameter__param_param(p0): return p0.intValue
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_listen__events_events: return ".listen(events:)"
            case .m_setParameter__param_param: return ".setParameter(param:)"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func listen(events: Parameter<Events>) -> Verify { return Verify(method: .m_listen__events_events(`events`))}
        public static func setParameter(param: Parameter<NavigationParameter>) -> Verify { return Verify(method: .m_setParameter__param_param(`param`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func listen(events: Parameter<Events>, perform: @escaping (Events) -> Void) -> Perform {
            return Perform(method: .m_listen__events_events(`events`), performs: perform)
        }
        public static func setParameter(param: Parameter<NavigationParameter>, perform: @escaping (NavigationParameter) -> Void) -> Perform {
            return Perform(method: .m_setParameter__param_param(`param`), performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        self.queue.sync { invocations.append(call) }
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }
    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        return matchingCalls(method.method, file: file, line: line).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

// MARK: - HeroDetailsUIMapperInterface

open class HeroDetailsUIMapperInterfaceMock: HeroDetailsUIMapperInterface, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst

    private var queue = DispatchQueue(label: "com.swiftymocky.invocations", qos: .userInteractive)
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }





    open func mapDetails(from hero: Observable<Hero>) -> HeroDetailsComponent.Data {
        addInvocation(.m_mapDetails__from_hero(Parameter<Observable<Hero>>.value(`hero`)))
		let perform = methodPerformValue(.m_mapDetails__from_hero(Parameter<Observable<Hero>>.value(`hero`))) as? (Observable<Hero>) -> Void
		perform?(`hero`)
		var __value: HeroDetailsComponent.Data
		do {
		    __value = try methodReturnValue(.m_mapDetails__from_hero(Parameter<Observable<Hero>>.value(`hero`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for mapDetails(from hero: Observable<Hero>). Use given")
			Failure("Stub return value not specified for mapDetails(from hero: Observable<Hero>). Use given")
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_mapDetails__from_hero(Parameter<Observable<Hero>>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_mapDetails__from_hero(let lhsHero), .m_mapDetails__from_hero(let rhsHero)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsHero, rhs: rhsHero, with: matcher), lhsHero, rhsHero, "from hero"))
				return Matcher.ComparisonResult(results)
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_mapDetails__from_hero(p0): return p0.intValue
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_mapDetails__from_hero: return ".mapDetails(from:)"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func mapDetails(from hero: Parameter<Observable<Hero>>, willReturn: HeroDetailsComponent.Data...) -> MethodStub {
            return Given(method: .m_mapDetails__from_hero(`hero`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func mapDetails(from hero: Parameter<Observable<Hero>>, willProduce: (Stubber<HeroDetailsComponent.Data>) -> Void) -> MethodStub {
            let willReturn: [HeroDetailsComponent.Data] = []
			let given: Given = { return Given(method: .m_mapDetails__from_hero(`hero`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (HeroDetailsComponent.Data).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func mapDetails(from hero: Parameter<Observable<Hero>>) -> Verify { return Verify(method: .m_mapDetails__from_hero(`hero`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func mapDetails(from hero: Parameter<Observable<Hero>>, perform: @escaping (Observable<Hero>) -> Void) -> Perform {
            return Perform(method: .m_mapDetails__from_hero(`hero`), performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        self.queue.sync { invocations.append(call) }
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }
    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        return matchingCalls(method.method, file: file, line: line).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

// MARK: - HeroListItemMapperInterface

open class HeroListItemMapperInterfaceMock: HeroListItemMapperInterface, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst

    private var queue = DispatchQueue(label: "com.swiftymocky.invocations", qos: .userInteractive)
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given
    public typealias InputModel = [HeroApiModel]
    public typealias OutputModel = [Hero]

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }





    open func map(from model: InputModel) -> OutputModel {
        addInvocation(.m_map__from_model(Parameter<InputModel>.value(`model`)))
		let perform = methodPerformValue(.m_map__from_model(Parameter<InputModel>.value(`model`))) as? (InputModel) -> Void
		perform?(`model`)
		var __value: OutputModel
		do {
		    __value = try methodReturnValue(.m_map__from_model(Parameter<InputModel>.value(`model`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for map(from model: InputModel). Use given")
			Failure("Stub return value not specified for map(from model: InputModel). Use given")
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_map__from_model(Parameter<InputModel>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_map__from_model(let lhsModel), .m_map__from_model(let rhsModel)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsModel, rhs: rhsModel, with: matcher), lhsModel, rhsModel, "from model"))
				return Matcher.ComparisonResult(results)
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_map__from_model(p0): return p0.intValue
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_map__from_model: return ".map(from:)"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func map(from model: Parameter<InputModel>, willReturn: OutputModel...) -> MethodStub {
            return Given(method: .m_map__from_model(`model`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func map(from model: Parameter<InputModel>, willProduce: (Stubber<OutputModel>) -> Void) -> MethodStub {
            let willReturn: [OutputModel] = []
			let given: Given = { return Given(method: .m_map__from_model(`model`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (OutputModel).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func map(from model: Parameter<InputModel>) -> Verify { return Verify(method: .m_map__from_model(`model`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func map(from model: Parameter<InputModel>, perform: @escaping (InputModel) -> Void) -> Perform {
            return Perform(method: .m_map__from_model(`model`), performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        self.queue.sync { invocations.append(call) }
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }
    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        return matchingCalls(method.method, file: file, line: line).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

// MARK: - HeroServiceInterface

open class HeroServiceInterfaceMock: HeroServiceInterface, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst

    private var queue = DispatchQueue(label: "com.swiftymocky.invocations", qos: .userInteractive)
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }





    open func getHeroes(searchText: String?) -> Single<Heroes.Hero.GetHeroesList.Response> {
        addInvocation(.m_getHeroes__searchText_searchText(Parameter<String?>.value(`searchText`)))
		let perform = methodPerformValue(.m_getHeroes__searchText_searchText(Parameter<String?>.value(`searchText`))) as? (String?) -> Void
		perform?(`searchText`)
		var __value: Single<Heroes.Hero.GetHeroesList.Response>
		do {
		    __value = try methodReturnValue(.m_getHeroes__searchText_searchText(Parameter<String?>.value(`searchText`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for getHeroes(searchText: String?). Use given")
			Failure("Stub return value not specified for getHeroes(searchText: String?). Use given")
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_getHeroes__searchText_searchText(Parameter<String?>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_getHeroes__searchText_searchText(let lhsSearchtext), .m_getHeroes__searchText_searchText(let rhsSearchtext)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsSearchtext, rhs: rhsSearchtext, with: matcher), lhsSearchtext, rhsSearchtext, "searchText"))
				return Matcher.ComparisonResult(results)
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_getHeroes__searchText_searchText(p0): return p0.intValue
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_getHeroes__searchText_searchText: return ".getHeroes(searchText:)"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func getHeroes(searchText: Parameter<String?>, willReturn: Single<Heroes.Hero.GetHeroesList.Response>...) -> MethodStub {
            return Given(method: .m_getHeroes__searchText_searchText(`searchText`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func getHeroes(searchText: Parameter<String?>, willProduce: (Stubber<Single<Heroes.Hero.GetHeroesList.Response>>) -> Void) -> MethodStub {
            let willReturn: [Single<Heroes.Hero.GetHeroesList.Response>] = []
			let given: Given = { return Given(method: .m_getHeroes__searchText_searchText(`searchText`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Single<Heroes.Hero.GetHeroesList.Response>).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func getHeroes(searchText: Parameter<String?>) -> Verify { return Verify(method: .m_getHeroes__searchText_searchText(`searchText`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func getHeroes(searchText: Parameter<String?>, perform: @escaping (String?) -> Void) -> Perform {
            return Perform(method: .m_getHeroes__searchText_searchText(`searchText`), performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        self.queue.sync { invocations.append(call) }
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }
    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        return matchingCalls(method.method, file: file, line: line).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

// MARK: - HeroesListCoordinatorInterface

open class HeroesListCoordinatorInterfaceMock: HeroesListCoordinatorInterface, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst

    private var queue = DispatchQueue(label: "com.swiftymocky.invocations", qos: .userInteractive)
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }

    public var navigator: NavigatorType {
		get {	invocations.append(.p_navigator_get); return __p_navigator ?? givenGetterValue(.p_navigator_get, "HeroesListCoordinatorInterfaceMock - stub value for navigator was not defined") }
	}
	private var __p_navigator: (NavigatorType)?





    open func didSelectHero(hero: Hero) {
        addInvocation(.m_didSelectHero__hero_hero(Parameter<Hero>.value(`hero`)))
		let perform = methodPerformValue(.m_didSelectHero__hero_hero(Parameter<Hero>.value(`hero`))) as? (Hero) -> Void
		perform?(`hero`)
    }

    open func start(payload: QueryParameters?) {
        addInvocation(.m_start__payload_payload(Parameter<QueryParameters?>.value(`payload`)))
		let perform = methodPerformValue(.m_start__payload_payload(Parameter<QueryParameters?>.value(`payload`))) as? (QueryParameters?) -> Void
		perform?(`payload`)
    }

    open func start() {
        addInvocation(.m_start)
		let perform = methodPerformValue(.m_start) as? () -> Void
		perform?()
    }


    fileprivate enum MethodType {
        case m_didSelectHero__hero_hero(Parameter<Hero>)
        case m_start__payload_payload(Parameter<QueryParameters?>)
        case m_start
        case p_navigator_get

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_didSelectHero__hero_hero(let lhsHero), .m_didSelectHero__hero_hero(let rhsHero)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsHero, rhs: rhsHero, with: matcher), lhsHero, rhsHero, "hero"))
				return Matcher.ComparisonResult(results)

            case (.m_start__payload_payload(let lhsPayload), .m_start__payload_payload(let rhsPayload)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsPayload, rhs: rhsPayload, with: matcher), lhsPayload, rhsPayload, "payload"))
				return Matcher.ComparisonResult(results)

            case (.m_start, .m_start): return .match
            case (.p_navigator_get,.p_navigator_get): return Matcher.ComparisonResult.match
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_didSelectHero__hero_hero(p0): return p0.intValue
            case let .m_start__payload_payload(p0): return p0.intValue
            case .m_start: return 0
            case .p_navigator_get: return 0
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_didSelectHero__hero_hero: return ".didSelectHero(hero:)"
            case .m_start__payload_payload: return ".start(payload:)"
            case .m_start: return ".start()"
            case .p_navigator_get: return "[get] .navigator"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }

        public static func navigator(getter defaultValue: NavigatorType...) -> PropertyStub {
            return Given(method: .p_navigator_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }

    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func didSelectHero(hero: Parameter<Hero>) -> Verify { return Verify(method: .m_didSelectHero__hero_hero(`hero`))}
        public static func start(payload: Parameter<QueryParameters?>) -> Verify { return Verify(method: .m_start__payload_payload(`payload`))}
        public static func start() -> Verify { return Verify(method: .m_start)}
        public static var navigator: Verify { return Verify(method: .p_navigator_get) }
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func didSelectHero(hero: Parameter<Hero>, perform: @escaping (Hero) -> Void) -> Perform {
            return Perform(method: .m_didSelectHero__hero_hero(`hero`), performs: perform)
        }
        public static func start(payload: Parameter<QueryParameters?>, perform: @escaping (QueryParameters?) -> Void) -> Perform {
            return Perform(method: .m_start__payload_payload(`payload`), performs: perform)
        }
        public static func start(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_start, performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        self.queue.sync { invocations.append(call) }
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }
    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        return matchingCalls(method.method, file: file, line: line).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

// MARK: - HeroesListItemUIMapperInterface

open class HeroesListItemUIMapperInterfaceMock: HeroesListItemUIMapperInterface, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst

    private var queue = DispatchQueue(label: "com.swiftymocky.invocations", qos: .userInteractive)
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }





    open func map(from state: HeroState) -> [HeroesCell.Data]? {
        addInvocation(.m_map__from_state(Parameter<HeroState>.value(`state`)))
		let perform = methodPerformValue(.m_map__from_state(Parameter<HeroState>.value(`state`))) as? (HeroState) -> Void
		perform?(`state`)
		var __value: [HeroesCell.Data]? = nil
		do {
		    __value = try methodReturnValue(.m_map__from_state(Parameter<HeroState>.value(`state`))).casted()
		} catch {
			// do nothing
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_map__from_state(Parameter<HeroState>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_map__from_state(let lhsState), .m_map__from_state(let rhsState)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsState, rhs: rhsState, with: matcher), lhsState, rhsState, "from state"))
				return Matcher.ComparisonResult(results)
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_map__from_state(p0): return p0.intValue
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_map__from_state: return ".map(from:)"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func map(from state: Parameter<HeroState>, willReturn: [HeroesCell.Data]?...) -> MethodStub {
            return Given(method: .m_map__from_state(`state`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func map(from state: Parameter<HeroState>, willProduce: (Stubber<[HeroesCell.Data]?>) -> Void) -> MethodStub {
            let willReturn: [[HeroesCell.Data]?] = []
			let given: Given = { return Given(method: .m_map__from_state(`state`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: ([HeroesCell.Data]?).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func map(from state: Parameter<HeroState>) -> Verify { return Verify(method: .m_map__from_state(`state`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func map(from state: Parameter<HeroState>, perform: @escaping (HeroState) -> Void) -> Perform {
            return Perform(method: .m_map__from_state(`state`), performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        self.queue.sync { invocations.append(call) }
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }
    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        return matchingCalls(method.method, file: file, line: line).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

// MARK: - HeroesStoreInterface

open class HeroesStoreInterfaceMock: HeroesStoreInterface, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst

    private var queue = DispatchQueue(label: "com.swiftymocky.invocations", qos: .userInteractive)
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given
    public typealias BoundedContext = HeroState

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }





    open func setDispatchToken(_ token: DispatchToken?, onDeinit: @escaping () -> Void) {
        addInvocation(.m_setDispatchToken__tokenonDeinit_onDeinit(Parameter<DispatchToken?>.value(`token`), Parameter<() -> Void>.value(`onDeinit`)))
		let perform = methodPerformValue(.m_setDispatchToken__tokenonDeinit_onDeinit(Parameter<DispatchToken?>.value(`token`), Parameter<() -> Void>.value(`onDeinit`))) as? (DispatchToken?, @escaping () -> Void) -> Void
		perform?(`token`, `onDeinit`)
    }

    open func dispatchToken() -> DispatchToken? {
        addInvocation(.m_dispatchToken)
		let perform = methodPerformValue(.m_dispatchToken) as? () -> Void
		perform?()
		var __value: DispatchToken? = nil
		do {
		    __value = try methodReturnValue(.m_dispatchToken).casted()
		} catch {
			// do nothing
		}
		return __value
    }

    open func getState() -> Observable<BoundedContext> {
        addInvocation(.m_getState)
		let perform = methodPerformValue(.m_getState) as? () -> Void
		perform?()
		var __value: Observable<BoundedContext>
		do {
		    __value = try methodReturnValue(.m_getState).casted()
		} catch {
			onFatalFailure("Stub return value not specified for getState(). Use given")
			Failure("Stub return value not specified for getState(). Use given")
		}
		return __value
    }

    open func reduce() -> Reducer {
        addInvocation(.m_reduce)
		let perform = methodPerformValue(.m_reduce) as? () -> Void
		perform?()
		var __value: Reducer
		do {
		    __value = try methodReturnValue(.m_reduce).casted()
		} catch {
			onFatalFailure("Stub return value not specified for reduce(). Use given")
			Failure("Stub return value not specified for reduce(). Use given")
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_setDispatchToken__tokenonDeinit_onDeinit(Parameter<DispatchToken?>, Parameter<() -> Void>)
        case m_dispatchToken
        case m_getState
        case m_reduce

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_setDispatchToken__tokenonDeinit_onDeinit(let lhsToken, let lhsOndeinit), .m_setDispatchToken__tokenonDeinit_onDeinit(let rhsToken, let rhsOndeinit)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsToken, rhs: rhsToken, with: matcher), lhsToken, rhsToken, "_ token"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsOndeinit, rhs: rhsOndeinit, with: matcher), lhsOndeinit, rhsOndeinit, "onDeinit"))
				return Matcher.ComparisonResult(results)

            case (.m_dispatchToken, .m_dispatchToken): return .match

            case (.m_getState, .m_getState): return .match

            case (.m_reduce, .m_reduce): return .match
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_setDispatchToken__tokenonDeinit_onDeinit(p0, p1): return p0.intValue + p1.intValue
            case .m_dispatchToken: return 0
            case .m_getState: return 0
            case .m_reduce: return 0
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_setDispatchToken__tokenonDeinit_onDeinit: return ".setDispatchToken(_:onDeinit:)"
            case .m_dispatchToken: return ".dispatchToken()"
            case .m_getState: return ".getState()"
            case .m_reduce: return ".reduce()"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func dispatchToken(willReturn: DispatchToken?...) -> MethodStub {
            return Given(method: .m_dispatchToken, products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func getState(willReturn: Observable<BoundedContext>...) -> MethodStub {
            return Given(method: .m_getState, products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func reduce(willReturn: Reducer...) -> MethodStub {
            return Given(method: .m_reduce, products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func dispatchToken(willProduce: (Stubber<DispatchToken?>) -> Void) -> MethodStub {
            let willReturn: [DispatchToken?] = []
			let given: Given = { return Given(method: .m_dispatchToken, products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (DispatchToken?).self)
			willProduce(stubber)
			return given
        }
        public static func getState(willProduce: (Stubber<Observable<BoundedContext>>) -> Void) -> MethodStub {
            let willReturn: [Observable<BoundedContext>] = []
			let given: Given = { return Given(method: .m_getState, products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Observable<BoundedContext>).self)
			willProduce(stubber)
			return given
        }
        public static func reduce(willProduce: (Stubber<Reducer>) -> Void) -> MethodStub {
            let willReturn: [Reducer] = []
			let given: Given = { return Given(method: .m_reduce, products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Reducer).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func setDispatchToken(_ token: Parameter<DispatchToken?>, onDeinit: Parameter<() -> Void>) -> Verify { return Verify(method: .m_setDispatchToken__tokenonDeinit_onDeinit(`token`, `onDeinit`))}
        public static func dispatchToken() -> Verify { return Verify(method: .m_dispatchToken)}
        public static func getState() -> Verify { return Verify(method: .m_getState)}
        public static func reduce() -> Verify { return Verify(method: .m_reduce)}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func setDispatchToken(_ token: Parameter<DispatchToken?>, onDeinit: Parameter<() -> Void>, perform: @escaping (DispatchToken?, @escaping () -> Void) -> Void) -> Perform {
            return Perform(method: .m_setDispatchToken__tokenonDeinit_onDeinit(`token`, `onDeinit`), performs: perform)
        }
        public static func dispatchToken(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_dispatchToken, performs: perform)
        }
        public static func getState(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_getState, performs: perform)
        }
        public static func reduce(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_reduce, performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        self.queue.sync { invocations.append(call) }
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }
    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        return matchingCalls(method.method, file: file, line: line).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

// MARK: - LoadHeroDetailsUseCaseInterface

open class LoadHeroDetailsUseCaseInterfaceMock: LoadHeroDetailsUseCaseInterface, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst

    private var queue = DispatchQueue(label: "com.swiftymocky.invocations", qos: .userInteractive)
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }





    open func execute(hero: Hero) {
        addInvocation(.m_execute__hero_hero(Parameter<Hero>.value(`hero`)))
		let perform = methodPerformValue(.m_execute__hero_hero(Parameter<Hero>.value(`hero`))) as? (Hero) -> Void
		perform?(`hero`)
    }

    open func execute() {
        addInvocation(.m_execute)
		let perform = methodPerformValue(.m_execute) as? () -> Void
		perform?()
    }


    fileprivate enum MethodType {
        case m_execute__hero_hero(Parameter<Hero>)
        case m_execute

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_execute__hero_hero(let lhsHero), .m_execute__hero_hero(let rhsHero)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsHero, rhs: rhsHero, with: matcher), lhsHero, rhsHero, "hero"))
				return Matcher.ComparisonResult(results)

            case (.m_execute, .m_execute): return .match
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_execute__hero_hero(p0): return p0.intValue
            case .m_execute: return 0
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_execute__hero_hero: return ".execute(hero:)"
            case .m_execute: return ".execute()"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func execute(hero: Parameter<Hero>) -> Verify { return Verify(method: .m_execute__hero_hero(`hero`))}
        public static func execute() -> Verify { return Verify(method: .m_execute)}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func execute(hero: Parameter<Hero>, perform: @escaping (Hero) -> Void) -> Perform {
            return Perform(method: .m_execute__hero_hero(`hero`), performs: perform)
        }
        public static func execute(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_execute, performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        self.queue.sync { invocations.append(call) }
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }
    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        return matchingCalls(method.method, file: file, line: line).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

// MARK: - LoadHeroesUseCaseInterface

open class LoadHeroesUseCaseInterfaceMock: LoadHeroesUseCaseInterface, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst

    private var queue = DispatchQueue(label: "com.swiftymocky.invocations", qos: .userInteractive)
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }





    open func execute(with searchText: String?) {
        addInvocation(.m_execute__with_searchText(Parameter<String?>.value(`searchText`)))
		let perform = methodPerformValue(.m_execute__with_searchText(Parameter<String?>.value(`searchText`))) as? (String?) -> Void
		perform?(`searchText`)
    }

    open func execute() {
        addInvocation(.m_execute)
		let perform = methodPerformValue(.m_execute) as? () -> Void
		perform?()
    }


    fileprivate enum MethodType {
        case m_execute__with_searchText(Parameter<String?>)
        case m_execute

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_execute__with_searchText(let lhsSearchtext), .m_execute__with_searchText(let rhsSearchtext)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsSearchtext, rhs: rhsSearchtext, with: matcher), lhsSearchtext, rhsSearchtext, "with searchText"))
				return Matcher.ComparisonResult(results)

            case (.m_execute, .m_execute): return .match
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_execute__with_searchText(p0): return p0.intValue
            case .m_execute: return 0
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_execute__with_searchText: return ".execute(with:)"
            case .m_execute: return ".execute()"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func execute(with searchText: Parameter<String?>) -> Verify { return Verify(method: .m_execute__with_searchText(`searchText`))}
        public static func execute() -> Verify { return Verify(method: .m_execute)}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func execute(with searchText: Parameter<String?>, perform: @escaping (String?) -> Void) -> Perform {
            return Perform(method: .m_execute__with_searchText(`searchText`), performs: perform)
        }
        public static func execute(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_execute, performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        self.queue.sync { invocations.append(call) }
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }
    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        return matchingCalls(method.method, file: file, line: line).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

// MARK: - Mapper

open class MapperMock<InputModel,OutputModel>: Mapper, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst

    private var queue = DispatchQueue(label: "com.swiftymocky.invocations", qos: .userInteractive)
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }





    open func map(from model: InputModel) -> OutputModel {
        addInvocation(.m_map__from_model(Parameter<InputModel>.value(`model`)))
		let perform = methodPerformValue(.m_map__from_model(Parameter<InputModel>.value(`model`))) as? (InputModel) -> Void
		perform?(`model`)
		var __value: OutputModel
		do {
		    __value = try methodReturnValue(.m_map__from_model(Parameter<InputModel>.value(`model`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for map(from model: InputModel). Use given")
			Failure("Stub return value not specified for map(from model: InputModel). Use given")
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_map__from_model(Parameter<InputModel>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_map__from_model(let lhsModel), .m_map__from_model(let rhsModel)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsModel, rhs: rhsModel, with: matcher), lhsModel, rhsModel, "from model"))
				return Matcher.ComparisonResult(results)
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_map__from_model(p0): return p0.intValue
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_map__from_model: return ".map(from:)"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func map(from model: Parameter<InputModel>, willReturn: OutputModel...) -> MethodStub {
            return Given(method: .m_map__from_model(`model`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func map(from model: Parameter<InputModel>, willProduce: (Stubber<OutputModel>) -> Void) -> MethodStub {
            let willReturn: [OutputModel] = []
			let given: Given = { return Given(method: .m_map__from_model(`model`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (OutputModel).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func map(from model: Parameter<InputModel>) -> Verify { return Verify(method: .m_map__from_model(`model`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func map(from model: Parameter<InputModel>, perform: @escaping (InputModel) -> Void) -> Perform {
            return Perform(method: .m_map__from_model(`model`), performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        self.queue.sync { invocations.append(call) }
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }
    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        return matchingCalls(method.method, file: file, line: line).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

// MARK: - NavigatorType

open class NavigatorTypeMock: NavigatorType, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst

    private var queue = DispatchQueue(label: "com.swiftymocky.invocations", qos: .userInteractive)
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }

    public var navigationController: UINavigationController? {
		get {	invocations.append(.p_navigationController_get); return __p_navigationController ?? optionalGivenGetterValue(.p_navigationController_get, "NavigatorTypeMock - stub value for navigationController was not defined") }
	}
	private var __p_navigationController: (UINavigationController)?

    public var currentViewController: UIViewController? {
		get {	invocations.append(.p_currentViewController_get); return __p_currentViewController ?? optionalGivenGetterValue(.p_currentViewController_get, "NavigatorTypeMock - stub value for currentViewController was not defined") }
	}
	private var __p_currentViewController: (UIViewController)?

    public var isCurrentViewControllerInModal: Bool {
		get {	invocations.append(.p_isCurrentViewControllerInModal_get); return __p_isCurrentViewControllerInModal ?? givenGetterValue(.p_isCurrentViewControllerInModal_get, "NavigatorTypeMock - stub value for isCurrentViewControllerInModal was not defined") }
	}
	private var __p_isCurrentViewControllerInModal: (Bool)?





    open func setCurrentViewController(viewController: UIViewController) {
        addInvocation(.m_setCurrentViewController__viewController_viewController(Parameter<UIViewController>.value(`viewController`)))
		let perform = methodPerformValue(.m_setCurrentViewController__viewController_viewController(Parameter<UIViewController>.value(`viewController`))) as? (UIViewController) -> Void
		perform?(`viewController`)
    }

    open func transition<T: UIViewController>(to type: T.Type, transition: ScreenTransitionType, animated: Bool) {
        addInvocation(.m_transition__to_typetransition_transitionanimated_animated(Parameter<T.Type>.value(`type`).wrapAsGeneric(), Parameter<ScreenTransitionType>.value(`transition`), Parameter<Bool>.value(`animated`)))
		let perform = methodPerformValue(.m_transition__to_typetransition_transitionanimated_animated(Parameter<T.Type>.value(`type`).wrapAsGeneric(), Parameter<ScreenTransitionType>.value(`transition`), Parameter<Bool>.value(`animated`))) as? (T.Type, ScreenTransitionType, Bool) -> Void
		perform?(`type`, `transition`, `animated`)
    }

    open func transition<T: UIViewController>(to type: T.Type,
                                         name: String?,
                                         transition: ScreenTransitionType,
                                         animated: Bool) {
        addInvocation(.m_transition__to_typename_nametransition_transitionanimated_animated(Parameter<T.Type>.value(`type`).wrapAsGeneric(), Parameter<String?>.value(`name`), Parameter<ScreenTransitionType>.value(`transition`), Parameter<Bool>.value(`animated`)))
		let perform = methodPerformValue(.m_transition__to_typename_nametransition_transitionanimated_animated(Parameter<T.Type>.value(`type`).wrapAsGeneric(), Parameter<String?>.value(`name`), Parameter<ScreenTransitionType>.value(`transition`), Parameter<Bool>.value(`animated`))) as? (T.Type, String?, ScreenTransitionType, Bool) -> Void
		perform?(`type`, `name`, `transition`, `animated`)
    }

    open func transition<T: Parameterizable>(to type: T.Type, transition: ScreenTransitionType) {
        addInvocation(.m_transition__to_typetransition_transition(Parameter<T.Type>.value(`type`).wrapAsGeneric(), Parameter<ScreenTransitionType>.value(`transition`)))
		let perform = methodPerformValue(.m_transition__to_typetransition_transition(Parameter<T.Type>.value(`type`).wrapAsGeneric(), Parameter<ScreenTransitionType>.value(`transition`))) as? (T.Type, ScreenTransitionType) -> Void
		perform?(`type`, `transition`)
    }

    open func transition<T: Parameterizable>(to type: T.Type, transition: ScreenTransitionType, animated: Bool, with parameter: NavigationParameter?) {
        addInvocation(.m_transition__to_typetransition_transitionanimated_animatedwith_parameter(Parameter<T.Type>.value(`type`).wrapAsGeneric(), Parameter<ScreenTransitionType>.value(`transition`), Parameter<Bool>.value(`animated`), Parameter<NavigationParameter?>.value(`parameter`)))
		let perform = methodPerformValue(.m_transition__to_typetransition_transitionanimated_animatedwith_parameter(Parameter<T.Type>.value(`type`).wrapAsGeneric(), Parameter<ScreenTransitionType>.value(`transition`), Parameter<Bool>.value(`animated`), Parameter<NavigationParameter?>.value(`parameter`))) as? (T.Type, ScreenTransitionType, Bool, NavigationParameter?) -> Void
		perform?(`type`, `transition`, `animated`, `parameter`)
    }

    open func transition<T: Parameterizable>(to type: T.Type,
                                        transition: ScreenTransitionType,
                                        with parameter: NavigationParameter?) {
        addInvocation(.m_transition__to_typetransition_transitionwith_parameter(Parameter<T.Type>.value(`type`).wrapAsGeneric(), Parameter<ScreenTransitionType>.value(`transition`), Parameter<NavigationParameter?>.value(`parameter`)))
		let perform = methodPerformValue(.m_transition__to_typetransition_transitionwith_parameter(Parameter<T.Type>.value(`type`).wrapAsGeneric(), Parameter<ScreenTransitionType>.value(`transition`), Parameter<NavigationParameter?>.value(`parameter`))) as? (T.Type, ScreenTransitionType, NavigationParameter?) -> Void
		perform?(`type`, `transition`, `parameter`)
    }

    open func transition<T: Parameterizable>(to type: T.Type,
                                        name: String?,
                                        transition: ScreenTransitionType,
                                        with parameter: NavigationParameter?) {
        addInvocation(.m_transition__to_typename_nametransition_transitionwith_parameter(Parameter<T.Type>.value(`type`).wrapAsGeneric(), Parameter<String?>.value(`name`), Parameter<ScreenTransitionType>.value(`transition`), Parameter<NavigationParameter?>.value(`parameter`)))
		let perform = methodPerformValue(.m_transition__to_typename_nametransition_transitionwith_parameter(Parameter<T.Type>.value(`type`).wrapAsGeneric(), Parameter<String?>.value(`name`), Parameter<ScreenTransitionType>.value(`transition`), Parameter<NavigationParameter?>.value(`parameter`))) as? (T.Type, String?, ScreenTransitionType, NavigationParameter?) -> Void
		perform?(`type`, `name`, `transition`, `parameter`)
    }

    open func transition<T: Parameterizable>(to type: T.Type,
                                        argument: String,
                                        transition: ScreenTransitionType,
                                        with parameter: NavigationParameter?) {
        addInvocation(.m_transition__to_typeargument_argumenttransition_transitionwith_parameter(Parameter<T.Type>.value(`type`).wrapAsGeneric(), Parameter<String>.value(`argument`), Parameter<ScreenTransitionType>.value(`transition`), Parameter<NavigationParameter?>.value(`parameter`)))
		let perform = methodPerformValue(.m_transition__to_typeargument_argumenttransition_transitionwith_parameter(Parameter<T.Type>.value(`type`).wrapAsGeneric(), Parameter<String>.value(`argument`), Parameter<ScreenTransitionType>.value(`transition`), Parameter<NavigationParameter?>.value(`parameter`))) as? (T.Type, String, ScreenTransitionType, NavigationParameter?) -> Void
		perform?(`type`, `argument`, `transition`, `parameter`)
    }

    open func pop<T: Parameterizable>(to type: T.Type, animated: Bool, with parameter: NavigationParameter?) {
        addInvocation(.m_pop__to_typeanimated_animatedwith_parameter(Parameter<T.Type>.value(`type`).wrapAsGeneric(), Parameter<Bool>.value(`animated`), Parameter<NavigationParameter?>.value(`parameter`)))
		let perform = methodPerformValue(.m_pop__to_typeanimated_animatedwith_parameter(Parameter<T.Type>.value(`type`).wrapAsGeneric(), Parameter<Bool>.value(`animated`), Parameter<NavigationParameter?>.value(`parameter`))) as? (T.Type, Bool, NavigationParameter?) -> Void
		perform?(`type`, `animated`, `parameter`)
    }

    open func dismiss(animated: Bool, completion: (() -> Void)?) {
        addInvocation(.m_dismiss__animated_animatedcompletion_completion(Parameter<Bool>.value(`animated`), Parameter<(() -> Void)?>.any))
		let perform = methodPerformValue(.m_dismiss__animated_animatedcompletion_completion(Parameter<Bool>.value(`animated`), Parameter<(() -> Void)?>.any)) as? (Bool, (() -> Void)?) -> Void
		perform?(`animated`, `completion`)
    }

    open func dismissAndPush<T: Parameterizable>(type: T.Type, animated: Bool, with parameter: NavigationParameter?) {
        addInvocation(.m_dismissAndPush__type_typeanimated_animatedwith_parameter(Parameter<T.Type>.value(`type`).wrapAsGeneric(), Parameter<Bool>.value(`animated`), Parameter<NavigationParameter?>.value(`parameter`)))
		let perform = methodPerformValue(.m_dismissAndPush__type_typeanimated_animatedwith_parameter(Parameter<T.Type>.value(`type`).wrapAsGeneric(), Parameter<Bool>.value(`animated`), Parameter<NavigationParameter?>.value(`parameter`))) as? (T.Type, Bool, NavigationParameter?) -> Void
		perform?(`type`, `animated`, `parameter`)
    }

    open func dismissAndPresent<T: Parameterizable>(type: T.Type, animated: Bool, with parameter: NavigationParameter?) {
        addInvocation(.m_dismissAndPresent__type_typeanimated_animatedwith_parameter(Parameter<T.Type>.value(`type`).wrapAsGeneric(), Parameter<Bool>.value(`animated`), Parameter<NavigationParameter?>.value(`parameter`)))
		let perform = methodPerformValue(.m_dismissAndPresent__type_typeanimated_animatedwith_parameter(Parameter<T.Type>.value(`type`).wrapAsGeneric(), Parameter<Bool>.value(`animated`), Parameter<NavigationParameter?>.value(`parameter`))) as? (T.Type, Bool, NavigationParameter?) -> Void
		perform?(`type`, `animated`, `parameter`)
    }

    open func dissmissAndPop(animated: Bool, with parameter: NavigationParameter?) {
        addInvocation(.m_dissmissAndPop__animated_animatedwith_parameter(Parameter<Bool>.value(`animated`), Parameter<NavigationParameter?>.value(`parameter`)))
		let perform = methodPerformValue(.m_dissmissAndPop__animated_animatedwith_parameter(Parameter<Bool>.value(`animated`), Parameter<NavigationParameter?>.value(`parameter`))) as? (Bool, NavigationParameter?) -> Void
		perform?(`animated`, `parameter`)
    }

    open func pop(animated: Bool, with parameter: NavigationParameter?) {
        addInvocation(.m_pop__animated_animatedwith_parameter(Parameter<Bool>.value(`animated`), Parameter<NavigationParameter?>.value(`parameter`)))
		let perform = methodPerformValue(.m_pop__animated_animatedwith_parameter(Parameter<Bool>.value(`animated`), Parameter<NavigationParameter?>.value(`parameter`))) as? (Bool, NavigationParameter?) -> Void
		perform?(`animated`, `parameter`)
    }

    open func setCurrentNavigationController(_ navigationController: UINavigationController) {
        addInvocation(.m_setCurrentNavigationController__navigationController(Parameter<UINavigationController>.value(`navigationController`)))
		let perform = methodPerformValue(.m_setCurrentNavigationController__navigationController(Parameter<UINavigationController>.value(`navigationController`))) as? (UINavigationController) -> Void
		perform?(`navigationController`)
    }

    open func navigateToUrl(_ url: URL) {
        addInvocation(.m_navigateToUrl__url(Parameter<URL>.value(`url`)))
		let perform = methodPerformValue(.m_navigateToUrl__url(Parameter<URL>.value(`url`))) as? (URL) -> Void
		perform?(`url`)
    }

    open func pop(animated: Bool = true) {
        addInvocation(.m_pop__animated_animated(Parameter<Bool>.value(`animated`)))
		let perform = methodPerformValue(.m_pop__animated_animated(Parameter<Bool>.value(`animated`))) as? (Bool) -> Void
		perform?(`animated`)
    }


    fileprivate enum MethodType {
        case m_setCurrentViewController__viewController_viewController(Parameter<UIViewController>)
        case m_transition__to_typetransition_transitionanimated_animated(Parameter<GenericAttribute>, Parameter<ScreenTransitionType>, Parameter<Bool>)
        case m_transition__to_typename_nametransition_transitionanimated_animated(Parameter<GenericAttribute>, Parameter<String?>, Parameter<ScreenTransitionType>, Parameter<Bool>)
        case m_transition__to_typetransition_transition(Parameter<GenericAttribute>, Parameter<ScreenTransitionType>)
        case m_transition__to_typetransition_transitionanimated_animatedwith_parameter(Parameter<GenericAttribute>, Parameter<ScreenTransitionType>, Parameter<Bool>, Parameter<NavigationParameter?>)
        case m_transition__to_typetransition_transitionwith_parameter(Parameter<GenericAttribute>, Parameter<ScreenTransitionType>, Parameter<NavigationParameter?>)
        case m_transition__to_typename_nametransition_transitionwith_parameter(Parameter<GenericAttribute>, Parameter<String?>, Parameter<ScreenTransitionType>, Parameter<NavigationParameter?>)
        case m_transition__to_typeargument_argumenttransition_transitionwith_parameter(Parameter<GenericAttribute>, Parameter<String>, Parameter<ScreenTransitionType>, Parameter<NavigationParameter?>)
        case m_pop__to_typeanimated_animatedwith_parameter(Parameter<GenericAttribute>, Parameter<Bool>, Parameter<NavigationParameter?>)
        case m_dismiss__animated_animatedcompletion_completion(Parameter<Bool>, Parameter<(() -> Void)?>)
        case m_dismissAndPush__type_typeanimated_animatedwith_parameter(Parameter<GenericAttribute>, Parameter<Bool>, Parameter<NavigationParameter?>)
        case m_dismissAndPresent__type_typeanimated_animatedwith_parameter(Parameter<GenericAttribute>, Parameter<Bool>, Parameter<NavigationParameter?>)
        case m_dissmissAndPop__animated_animatedwith_parameter(Parameter<Bool>, Parameter<NavigationParameter?>)
        case m_pop__animated_animatedwith_parameter(Parameter<Bool>, Parameter<NavigationParameter?>)
        case m_setCurrentNavigationController__navigationController(Parameter<UINavigationController>)
        case m_navigateToUrl__url(Parameter<URL>)
        case m_pop__animated_animated(Parameter<Bool>)
        case p_navigationController_get
        case p_currentViewController_get
        case p_isCurrentViewControllerInModal_get

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_setCurrentViewController__viewController_viewController(let lhsViewcontroller), .m_setCurrentViewController__viewController_viewController(let rhsViewcontroller)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsViewcontroller, rhs: rhsViewcontroller, with: matcher), lhsViewcontroller, rhsViewcontroller, "viewController"))
				return Matcher.ComparisonResult(results)

            case (.m_transition__to_typetransition_transitionanimated_animated(let lhsType, let lhsTransition, let lhsAnimated), .m_transition__to_typetransition_transitionanimated_animated(let rhsType, let rhsTransition, let rhsAnimated)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsType, rhs: rhsType, with: matcher), lhsType, rhsType, "to type"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsTransition, rhs: rhsTransition, with: matcher), lhsTransition, rhsTransition, "transition"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsAnimated, rhs: rhsAnimated, with: matcher), lhsAnimated, rhsAnimated, "animated"))
				return Matcher.ComparisonResult(results)

            case (.m_transition__to_typename_nametransition_transitionanimated_animated(let lhsType, let lhsName, let lhsTransition, let lhsAnimated), .m_transition__to_typename_nametransition_transitionanimated_animated(let rhsType, let rhsName, let rhsTransition, let rhsAnimated)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsType, rhs: rhsType, with: matcher), lhsType, rhsType, "to type"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsName, rhs: rhsName, with: matcher), lhsName, rhsName, "name"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsTransition, rhs: rhsTransition, with: matcher), lhsTransition, rhsTransition, "transition"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsAnimated, rhs: rhsAnimated, with: matcher), lhsAnimated, rhsAnimated, "animated"))
				return Matcher.ComparisonResult(results)

            case (.m_transition__to_typetransition_transition(let lhsType, let lhsTransition), .m_transition__to_typetransition_transition(let rhsType, let rhsTransition)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsType, rhs: rhsType, with: matcher), lhsType, rhsType, "to type"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsTransition, rhs: rhsTransition, with: matcher), lhsTransition, rhsTransition, "transition"))
				return Matcher.ComparisonResult(results)

            case (.m_transition__to_typetransition_transitionanimated_animatedwith_parameter(let lhsType, let lhsTransition, let lhsAnimated, let lhsParameter), .m_transition__to_typetransition_transitionanimated_animatedwith_parameter(let rhsType, let rhsTransition, let rhsAnimated, let rhsParameter)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsType, rhs: rhsType, with: matcher), lhsType, rhsType, "to type"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsTransition, rhs: rhsTransition, with: matcher), lhsTransition, rhsTransition, "transition"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsAnimated, rhs: rhsAnimated, with: matcher), lhsAnimated, rhsAnimated, "animated"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsParameter, rhs: rhsParameter, with: matcher), lhsParameter, rhsParameter, "with parameter"))
				return Matcher.ComparisonResult(results)

            case (.m_transition__to_typetransition_transitionwith_parameter(let lhsType, let lhsTransition, let lhsParameter), .m_transition__to_typetransition_transitionwith_parameter(let rhsType, let rhsTransition, let rhsParameter)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsType, rhs: rhsType, with: matcher), lhsType, rhsType, "to type"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsTransition, rhs: rhsTransition, with: matcher), lhsTransition, rhsTransition, "transition"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsParameter, rhs: rhsParameter, with: matcher), lhsParameter, rhsParameter, "with parameter"))
				return Matcher.ComparisonResult(results)

            case (.m_transition__to_typename_nametransition_transitionwith_parameter(let lhsType, let lhsName, let lhsTransition, let lhsParameter), .m_transition__to_typename_nametransition_transitionwith_parameter(let rhsType, let rhsName, let rhsTransition, let rhsParameter)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsType, rhs: rhsType, with: matcher), lhsType, rhsType, "to type"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsName, rhs: rhsName, with: matcher), lhsName, rhsName, "name"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsTransition, rhs: rhsTransition, with: matcher), lhsTransition, rhsTransition, "transition"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsParameter, rhs: rhsParameter, with: matcher), lhsParameter, rhsParameter, "with parameter"))
				return Matcher.ComparisonResult(results)

            case (.m_transition__to_typeargument_argumenttransition_transitionwith_parameter(let lhsType, let lhsArgument, let lhsTransition, let lhsParameter), .m_transition__to_typeargument_argumenttransition_transitionwith_parameter(let rhsType, let rhsArgument, let rhsTransition, let rhsParameter)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsType, rhs: rhsType, with: matcher), lhsType, rhsType, "to type"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsArgument, rhs: rhsArgument, with: matcher), lhsArgument, rhsArgument, "argument"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsTransition, rhs: rhsTransition, with: matcher), lhsTransition, rhsTransition, "transition"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsParameter, rhs: rhsParameter, with: matcher), lhsParameter, rhsParameter, "with parameter"))
				return Matcher.ComparisonResult(results)

            case (.m_pop__to_typeanimated_animatedwith_parameter(let lhsType, let lhsAnimated, let lhsParameter), .m_pop__to_typeanimated_animatedwith_parameter(let rhsType, let rhsAnimated, let rhsParameter)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsType, rhs: rhsType, with: matcher), lhsType, rhsType, "to type"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsAnimated, rhs: rhsAnimated, with: matcher), lhsAnimated, rhsAnimated, "animated"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsParameter, rhs: rhsParameter, with: matcher), lhsParameter, rhsParameter, "with parameter"))
				return Matcher.ComparisonResult(results)

            case (.m_dismiss__animated_animatedcompletion_completion(let lhsAnimated, let lhsCompletion), .m_dismiss__animated_animatedcompletion_completion(let rhsAnimated, let rhsCompletion)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsAnimated, rhs: rhsAnimated, with: matcher), lhsAnimated, rhsAnimated, "animated"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsCompletion, rhs: rhsCompletion, with: matcher), lhsCompletion, rhsCompletion, "completion"))
				return Matcher.ComparisonResult(results)

            case (.m_dismissAndPush__type_typeanimated_animatedwith_parameter(let lhsType, let lhsAnimated, let lhsParameter), .m_dismissAndPush__type_typeanimated_animatedwith_parameter(let rhsType, let rhsAnimated, let rhsParameter)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsType, rhs: rhsType, with: matcher), lhsType, rhsType, "type"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsAnimated, rhs: rhsAnimated, with: matcher), lhsAnimated, rhsAnimated, "animated"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsParameter, rhs: rhsParameter, with: matcher), lhsParameter, rhsParameter, "with parameter"))
				return Matcher.ComparisonResult(results)

            case (.m_dismissAndPresent__type_typeanimated_animatedwith_parameter(let lhsType, let lhsAnimated, let lhsParameter), .m_dismissAndPresent__type_typeanimated_animatedwith_parameter(let rhsType, let rhsAnimated, let rhsParameter)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsType, rhs: rhsType, with: matcher), lhsType, rhsType, "type"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsAnimated, rhs: rhsAnimated, with: matcher), lhsAnimated, rhsAnimated, "animated"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsParameter, rhs: rhsParameter, with: matcher), lhsParameter, rhsParameter, "with parameter"))
				return Matcher.ComparisonResult(results)

            case (.m_dissmissAndPop__animated_animatedwith_parameter(let lhsAnimated, let lhsParameter), .m_dissmissAndPop__animated_animatedwith_parameter(let rhsAnimated, let rhsParameter)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsAnimated, rhs: rhsAnimated, with: matcher), lhsAnimated, rhsAnimated, "animated"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsParameter, rhs: rhsParameter, with: matcher), lhsParameter, rhsParameter, "with parameter"))
				return Matcher.ComparisonResult(results)

            case (.m_pop__animated_animatedwith_parameter(let lhsAnimated, let lhsParameter), .m_pop__animated_animatedwith_parameter(let rhsAnimated, let rhsParameter)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsAnimated, rhs: rhsAnimated, with: matcher), lhsAnimated, rhsAnimated, "animated"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsParameter, rhs: rhsParameter, with: matcher), lhsParameter, rhsParameter, "with parameter"))
				return Matcher.ComparisonResult(results)

            case (.m_setCurrentNavigationController__navigationController(let lhsNavigationcontroller), .m_setCurrentNavigationController__navigationController(let rhsNavigationcontroller)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsNavigationcontroller, rhs: rhsNavigationcontroller, with: matcher), lhsNavigationcontroller, rhsNavigationcontroller, "_ navigationController"))
				return Matcher.ComparisonResult(results)

            case (.m_navigateToUrl__url(let lhsUrl), .m_navigateToUrl__url(let rhsUrl)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsUrl, rhs: rhsUrl, with: matcher), lhsUrl, rhsUrl, "_ url"))
				return Matcher.ComparisonResult(results)

            case (.m_pop__animated_animated(let lhsAnimated), .m_pop__animated_animated(let rhsAnimated)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsAnimated, rhs: rhsAnimated, with: matcher), lhsAnimated, rhsAnimated, "animated"))
				return Matcher.ComparisonResult(results)
            case (.p_navigationController_get,.p_navigationController_get): return Matcher.ComparisonResult.match
            case (.p_currentViewController_get,.p_currentViewController_get): return Matcher.ComparisonResult.match
            case (.p_isCurrentViewControllerInModal_get,.p_isCurrentViewControllerInModal_get): return Matcher.ComparisonResult.match
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_setCurrentViewController__viewController_viewController(p0): return p0.intValue
            case let .m_transition__to_typetransition_transitionanimated_animated(p0, p1, p2): return p0.intValue + p1.intValue + p2.intValue
            case let .m_transition__to_typename_nametransition_transitionanimated_animated(p0, p1, p2, p3): return p0.intValue + p1.intValue + p2.intValue + p3.intValue
            case let .m_transition__to_typetransition_transition(p0, p1): return p0.intValue + p1.intValue
            case let .m_transition__to_typetransition_transitionanimated_animatedwith_parameter(p0, p1, p2, p3): return p0.intValue + p1.intValue + p2.intValue + p3.intValue
            case let .m_transition__to_typetransition_transitionwith_parameter(p0, p1, p2): return p0.intValue + p1.intValue + p2.intValue
            case let .m_transition__to_typename_nametransition_transitionwith_parameter(p0, p1, p2, p3): return p0.intValue + p1.intValue + p2.intValue + p3.intValue
            case let .m_transition__to_typeargument_argumenttransition_transitionwith_parameter(p0, p1, p2, p3): return p0.intValue + p1.intValue + p2.intValue + p3.intValue
            case let .m_pop__to_typeanimated_animatedwith_parameter(p0, p1, p2): return p0.intValue + p1.intValue + p2.intValue
            case let .m_dismiss__animated_animatedcompletion_completion(p0, p1): return p0.intValue + p1.intValue
            case let .m_dismissAndPush__type_typeanimated_animatedwith_parameter(p0, p1, p2): return p0.intValue + p1.intValue + p2.intValue
            case let .m_dismissAndPresent__type_typeanimated_animatedwith_parameter(p0, p1, p2): return p0.intValue + p1.intValue + p2.intValue
            case let .m_dissmissAndPop__animated_animatedwith_parameter(p0, p1): return p0.intValue + p1.intValue
            case let .m_pop__animated_animatedwith_parameter(p0, p1): return p0.intValue + p1.intValue
            case let .m_setCurrentNavigationController__navigationController(p0): return p0.intValue
            case let .m_navigateToUrl__url(p0): return p0.intValue
            case let .m_pop__animated_animated(p0): return p0.intValue
            case .p_navigationController_get: return 0
            case .p_currentViewController_get: return 0
            case .p_isCurrentViewControllerInModal_get: return 0
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_setCurrentViewController__viewController_viewController: return ".setCurrentViewController(viewController:)"
            case .m_transition__to_typetransition_transitionanimated_animated: return ".transition(to:transition:animated:)"
            case .m_transition__to_typename_nametransition_transitionanimated_animated: return ".transition(to:name:transition:animated:)"
            case .m_transition__to_typetransition_transition: return ".transition(to:transition:)"
            case .m_transition__to_typetransition_transitionanimated_animatedwith_parameter: return ".transition(to:transition:animated:with:)"
            case .m_transition__to_typetransition_transitionwith_parameter: return ".transition(to:transition:with:)"
            case .m_transition__to_typename_nametransition_transitionwith_parameter: return ".transition(to:name:transition:with:)"
            case .m_transition__to_typeargument_argumenttransition_transitionwith_parameter: return ".transition(to:argument:transition:with:)"
            case .m_pop__to_typeanimated_animatedwith_parameter: return ".pop(to:animated:with:)"
            case .m_dismiss__animated_animatedcompletion_completion: return ".dismiss(animated:completion:)"
            case .m_dismissAndPush__type_typeanimated_animatedwith_parameter: return ".dismissAndPush(type:animated:with:)"
            case .m_dismissAndPresent__type_typeanimated_animatedwith_parameter: return ".dismissAndPresent(type:animated:with:)"
            case .m_dissmissAndPop__animated_animatedwith_parameter: return ".dissmissAndPop(animated:with:)"
            case .m_pop__animated_animatedwith_parameter: return ".pop(animated:with:)"
            case .m_setCurrentNavigationController__navigationController: return ".setCurrentNavigationController(_:)"
            case .m_navigateToUrl__url: return ".navigateToUrl(_:)"
            case .m_pop__animated_animated: return ".pop(animated:)"
            case .p_navigationController_get: return "[get] .navigationController"
            case .p_currentViewController_get: return "[get] .currentViewController"
            case .p_isCurrentViewControllerInModal_get: return "[get] .isCurrentViewControllerInModal"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }

        public static func navigationController(getter defaultValue: UINavigationController?...) -> PropertyStub {
            return Given(method: .p_navigationController_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }
        public static func currentViewController(getter defaultValue: UIViewController?...) -> PropertyStub {
            return Given(method: .p_currentViewController_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }
        public static func isCurrentViewControllerInModal(getter defaultValue: Bool...) -> PropertyStub {
            return Given(method: .p_isCurrentViewControllerInModal_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }

    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func setCurrentViewController(viewController: Parameter<UIViewController>) -> Verify { return Verify(method: .m_setCurrentViewController__viewController_viewController(`viewController`))}
        public static func transition<T>(to type: Parameter<T.Type>, transition: Parameter<ScreenTransitionType>, animated: Parameter<Bool>) -> Verify where T:UIViewController { return Verify(method: .m_transition__to_typetransition_transitionanimated_animated(`type`.wrapAsGeneric(), `transition`, `animated`))}
        public static func transition<T>(to type: Parameter<T.Type>, name: Parameter<String?>, transition: Parameter<ScreenTransitionType>, animated: Parameter<Bool>) -> Verify where T:UIViewController { return Verify(method: .m_transition__to_typename_nametransition_transitionanimated_animated(`type`.wrapAsGeneric(), `name`, `transition`, `animated`))}
        public static func transition<T>(to type: Parameter<T.Type>, transition: Parameter<ScreenTransitionType>) -> Verify where T:Parameterizable { return Verify(method: .m_transition__to_typetransition_transition(`type`.wrapAsGeneric(), `transition`))}
        public static func transition<T>(to type: Parameter<T.Type>, transition: Parameter<ScreenTransitionType>, animated: Parameter<Bool>, with parameter: Parameter<NavigationParameter?>) -> Verify where T:Parameterizable { return Verify(method: .m_transition__to_typetransition_transitionanimated_animatedwith_parameter(`type`.wrapAsGeneric(), `transition`, `animated`, `parameter`))}
        public static func transition<T>(to type: Parameter<T.Type>, transition: Parameter<ScreenTransitionType>, with parameter: Parameter<NavigationParameter?>) -> Verify where T:Parameterizable { return Verify(method: .m_transition__to_typetransition_transitionwith_parameter(`type`.wrapAsGeneric(), `transition`, `parameter`))}
        public static func transition<T>(to type: Parameter<T.Type>, name: Parameter<String?>, transition: Parameter<ScreenTransitionType>, with parameter: Parameter<NavigationParameter?>) -> Verify where T:Parameterizable { return Verify(method: .m_transition__to_typename_nametransition_transitionwith_parameter(`type`.wrapAsGeneric(), `name`, `transition`, `parameter`))}
        public static func transition<T>(to type: Parameter<T.Type>, argument: Parameter<String>, transition: Parameter<ScreenTransitionType>, with parameter: Parameter<NavigationParameter?>) -> Verify where T:Parameterizable { return Verify(method: .m_transition__to_typeargument_argumenttransition_transitionwith_parameter(`type`.wrapAsGeneric(), `argument`, `transition`, `parameter`))}
        public static func pop<T>(to type: Parameter<T.Type>, animated: Parameter<Bool>, with parameter: Parameter<NavigationParameter?>) -> Verify where T:Parameterizable { return Verify(method: .m_pop__to_typeanimated_animatedwith_parameter(`type`.wrapAsGeneric(), `animated`, `parameter`))}
        public static func dismiss(animated: Parameter<Bool>, completion: Parameter<(() -> Void)?>) -> Verify { return Verify(method: .m_dismiss__animated_animatedcompletion_completion(`animated`, `completion`))}
        public static func dismissAndPush<T>(type: Parameter<T.Type>, animated: Parameter<Bool>, with parameter: Parameter<NavigationParameter?>) -> Verify where T:Parameterizable { return Verify(method: .m_dismissAndPush__type_typeanimated_animatedwith_parameter(`type`.wrapAsGeneric(), `animated`, `parameter`))}
        public static func dismissAndPresent<T>(type: Parameter<T.Type>, animated: Parameter<Bool>, with parameter: Parameter<NavigationParameter?>) -> Verify where T:Parameterizable { return Verify(method: .m_dismissAndPresent__type_typeanimated_animatedwith_parameter(`type`.wrapAsGeneric(), `animated`, `parameter`))}
        public static func dissmissAndPop(animated: Parameter<Bool>, with parameter: Parameter<NavigationParameter?>) -> Verify { return Verify(method: .m_dissmissAndPop__animated_animatedwith_parameter(`animated`, `parameter`))}
        public static func pop(animated: Parameter<Bool>, with parameter: Parameter<NavigationParameter?>) -> Verify { return Verify(method: .m_pop__animated_animatedwith_parameter(`animated`, `parameter`))}
        public static func setCurrentNavigationController(_ navigationController: Parameter<UINavigationController>) -> Verify { return Verify(method: .m_setCurrentNavigationController__navigationController(`navigationController`))}
        public static func navigateToUrl(_ url: Parameter<URL>) -> Verify { return Verify(method: .m_navigateToUrl__url(`url`))}
        public static func pop(animated: Parameter<Bool>) -> Verify { return Verify(method: .m_pop__animated_animated(`animated`))}
        public static var navigationController: Verify { return Verify(method: .p_navigationController_get) }
        public static var currentViewController: Verify { return Verify(method: .p_currentViewController_get) }
        public static var isCurrentViewControllerInModal: Verify { return Verify(method: .p_isCurrentViewControllerInModal_get) }
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func setCurrentViewController(viewController: Parameter<UIViewController>, perform: @escaping (UIViewController) -> Void) -> Perform {
            return Perform(method: .m_setCurrentViewController__viewController_viewController(`viewController`), performs: perform)
        }
        public static func transition<T>(to type: Parameter<T.Type>, transition: Parameter<ScreenTransitionType>, animated: Parameter<Bool>, perform: @escaping (T.Type, ScreenTransitionType, Bool) -> Void) -> Perform where T:UIViewController {
            return Perform(method: .m_transition__to_typetransition_transitionanimated_animated(`type`.wrapAsGeneric(), `transition`, `animated`), performs: perform)
        }
        public static func transition<T>(to type: Parameter<T.Type>, name: Parameter<String?>, transition: Parameter<ScreenTransitionType>, animated: Parameter<Bool>, perform: @escaping (T.Type, String?, ScreenTransitionType, Bool) -> Void) -> Perform where T:UIViewController {
            return Perform(method: .m_transition__to_typename_nametransition_transitionanimated_animated(`type`.wrapAsGeneric(), `name`, `transition`, `animated`), performs: perform)
        }
        public static func transition<T>(to type: Parameter<T.Type>, transition: Parameter<ScreenTransitionType>, perform: @escaping (T.Type, ScreenTransitionType) -> Void) -> Perform where T:Parameterizable {
            return Perform(method: .m_transition__to_typetransition_transition(`type`.wrapAsGeneric(), `transition`), performs: perform)
        }
        public static func transition<T>(to type: Parameter<T.Type>, transition: Parameter<ScreenTransitionType>, animated: Parameter<Bool>, with parameter: Parameter<NavigationParameter?>, perform: @escaping (T.Type, ScreenTransitionType, Bool, NavigationParameter?) -> Void) -> Perform where T:Parameterizable {
            return Perform(method: .m_transition__to_typetransition_transitionanimated_animatedwith_parameter(`type`.wrapAsGeneric(), `transition`, `animated`, `parameter`), performs: perform)
        }
        public static func transition<T>(to type: Parameter<T.Type>, transition: Parameter<ScreenTransitionType>, with parameter: Parameter<NavigationParameter?>, perform: @escaping (T.Type, ScreenTransitionType, NavigationParameter?) -> Void) -> Perform where T:Parameterizable {
            return Perform(method: .m_transition__to_typetransition_transitionwith_parameter(`type`.wrapAsGeneric(), `transition`, `parameter`), performs: perform)
        }
        public static func transition<T>(to type: Parameter<T.Type>, name: Parameter<String?>, transition: Parameter<ScreenTransitionType>, with parameter: Parameter<NavigationParameter?>, perform: @escaping (T.Type, String?, ScreenTransitionType, NavigationParameter?) -> Void) -> Perform where T:Parameterizable {
            return Perform(method: .m_transition__to_typename_nametransition_transitionwith_parameter(`type`.wrapAsGeneric(), `name`, `transition`, `parameter`), performs: perform)
        }
        public static func transition<T>(to type: Parameter<T.Type>, argument: Parameter<String>, transition: Parameter<ScreenTransitionType>, with parameter: Parameter<NavigationParameter?>, perform: @escaping (T.Type, String, ScreenTransitionType, NavigationParameter?) -> Void) -> Perform where T:Parameterizable {
            return Perform(method: .m_transition__to_typeargument_argumenttransition_transitionwith_parameter(`type`.wrapAsGeneric(), `argument`, `transition`, `parameter`), performs: perform)
        }
        public static func pop<T>(to type: Parameter<T.Type>, animated: Parameter<Bool>, with parameter: Parameter<NavigationParameter?>, perform: @escaping (T.Type, Bool, NavigationParameter?) -> Void) -> Perform where T:Parameterizable {
            return Perform(method: .m_pop__to_typeanimated_animatedwith_parameter(`type`.wrapAsGeneric(), `animated`, `parameter`), performs: perform)
        }
        public static func dismiss(animated: Parameter<Bool>, completion: Parameter<(() -> Void)?>, perform: @escaping (Bool, (() -> Void)?) -> Void) -> Perform {
            return Perform(method: .m_dismiss__animated_animatedcompletion_completion(`animated`, `completion`), performs: perform)
        }
        public static func dismissAndPush<T>(type: Parameter<T.Type>, animated: Parameter<Bool>, with parameter: Parameter<NavigationParameter?>, perform: @escaping (T.Type, Bool, NavigationParameter?) -> Void) -> Perform where T:Parameterizable {
            return Perform(method: .m_dismissAndPush__type_typeanimated_animatedwith_parameter(`type`.wrapAsGeneric(), `animated`, `parameter`), performs: perform)
        }
        public static func dismissAndPresent<T>(type: Parameter<T.Type>, animated: Parameter<Bool>, with parameter: Parameter<NavigationParameter?>, perform: @escaping (T.Type, Bool, NavigationParameter?) -> Void) -> Perform where T:Parameterizable {
            return Perform(method: .m_dismissAndPresent__type_typeanimated_animatedwith_parameter(`type`.wrapAsGeneric(), `animated`, `parameter`), performs: perform)
        }
        public static func dissmissAndPop(animated: Parameter<Bool>, with parameter: Parameter<NavigationParameter?>, perform: @escaping (Bool, NavigationParameter?) -> Void) -> Perform {
            return Perform(method: .m_dissmissAndPop__animated_animatedwith_parameter(`animated`, `parameter`), performs: perform)
        }
        public static func pop(animated: Parameter<Bool>, with parameter: Parameter<NavigationParameter?>, perform: @escaping (Bool, NavigationParameter?) -> Void) -> Perform {
            return Perform(method: .m_pop__animated_animatedwith_parameter(`animated`, `parameter`), performs: perform)
        }
        public static func setCurrentNavigationController(_ navigationController: Parameter<UINavigationController>, perform: @escaping (UINavigationController) -> Void) -> Perform {
            return Perform(method: .m_setCurrentNavigationController__navigationController(`navigationController`), performs: perform)
        }
        public static func navigateToUrl(_ url: Parameter<URL>, perform: @escaping (URL) -> Void) -> Perform {
            return Perform(method: .m_navigateToUrl__url(`url`), performs: perform)
        }
        public static func pop(animated: Parameter<Bool>, perform: @escaping (Bool) -> Void) -> Perform {
            return Perform(method: .m_pop__animated_animated(`animated`), performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        self.queue.sync { invocations.append(call) }
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }
    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        return matchingCalls(method.method, file: file, line: line).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

// MARK: - SchedulerProviderInterface

open class SchedulerProviderInterfaceMock: SchedulerProviderInterface, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst

    private var queue = DispatchQueue(label: "com.swiftymocky.invocations", qos: .userInteractive)
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }

    public var mainScheduler: SchedulerType {
		get {	invocations.append(.p_mainScheduler_get); return __p_mainScheduler ?? givenGetterValue(.p_mainScheduler_get, "SchedulerProviderInterfaceMock - stub value for mainScheduler was not defined") }
	}
	private var __p_mainScheduler: (SchedulerType)?






    fileprivate enum MethodType {
        case p_mainScheduler_get

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {            case (.p_mainScheduler_get,.p_mainScheduler_get): return Matcher.ComparisonResult.match
            }
        }

        func intValue() -> Int {
            switch self {
            case .p_mainScheduler_get: return 0
            }
        }
        func assertionName() -> String {
            switch self {
            case .p_mainScheduler_get: return "[get] .mainScheduler"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }

        public static func mainScheduler(getter defaultValue: SchedulerType...) -> PropertyStub {
            return Given(method: .p_mainScheduler_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }

    }

    public struct Verify {
        fileprivate var method: MethodType

        public static var mainScheduler: Verify { return Verify(method: .p_mainScheduler_get) }
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        self.queue.sync { invocations.append(call) }
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }
    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        return matchingCalls(method.method, file: file, line: line).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

// MARK: - Store

open class StoreMock<BoundedContext>: Store, Mock where BoundedContext: State {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst

    private var queue = DispatchQueue(label: "com.swiftymocky.invocations", qos: .userInteractive)
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }





    open func setDispatchToken(_ token: DispatchToken?, onDeinit: @escaping () -> Void) {
        addInvocation(.m_setDispatchToken__tokenonDeinit_onDeinit(Parameter<DispatchToken?>.value(`token`), Parameter<() -> Void>.value(`onDeinit`)))
		let perform = methodPerformValue(.m_setDispatchToken__tokenonDeinit_onDeinit(Parameter<DispatchToken?>.value(`token`), Parameter<() -> Void>.value(`onDeinit`))) as? (DispatchToken?, @escaping () -> Void) -> Void
		perform?(`token`, `onDeinit`)
    }

    open func dispatchToken() -> DispatchToken? {
        addInvocation(.m_dispatchToken)
		let perform = methodPerformValue(.m_dispatchToken) as? () -> Void
		perform?()
		var __value: DispatchToken? = nil
		do {
		    __value = try methodReturnValue(.m_dispatchToken).casted()
		} catch {
			// do nothing
		}
		return __value
    }

    open func getState() -> Observable<BoundedContext> {
        addInvocation(.m_getState)
		let perform = methodPerformValue(.m_getState) as? () -> Void
		perform?()
		var __value: Observable<BoundedContext>
		do {
		    __value = try methodReturnValue(.m_getState).casted()
		} catch {
			onFatalFailure("Stub return value not specified for getState(). Use given")
			Failure("Stub return value not specified for getState(). Use given")
		}
		return __value
    }

    open func reduce() -> Reducer {
        addInvocation(.m_reduce)
		let perform = methodPerformValue(.m_reduce) as? () -> Void
		perform?()
		var __value: Reducer
		do {
		    __value = try methodReturnValue(.m_reduce).casted()
		} catch {
			onFatalFailure("Stub return value not specified for reduce(). Use given")
			Failure("Stub return value not specified for reduce(). Use given")
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_setDispatchToken__tokenonDeinit_onDeinit(Parameter<DispatchToken?>, Parameter<() -> Void>)
        case m_dispatchToken
        case m_getState
        case m_reduce

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_setDispatchToken__tokenonDeinit_onDeinit(let lhsToken, let lhsOndeinit), .m_setDispatchToken__tokenonDeinit_onDeinit(let rhsToken, let rhsOndeinit)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsToken, rhs: rhsToken, with: matcher), lhsToken, rhsToken, "_ token"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsOndeinit, rhs: rhsOndeinit, with: matcher), lhsOndeinit, rhsOndeinit, "onDeinit"))
				return Matcher.ComparisonResult(results)

            case (.m_dispatchToken, .m_dispatchToken): return .match

            case (.m_getState, .m_getState): return .match

            case (.m_reduce, .m_reduce): return .match
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_setDispatchToken__tokenonDeinit_onDeinit(p0, p1): return p0.intValue + p1.intValue
            case .m_dispatchToken: return 0
            case .m_getState: return 0
            case .m_reduce: return 0
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_setDispatchToken__tokenonDeinit_onDeinit: return ".setDispatchToken(_:onDeinit:)"
            case .m_dispatchToken: return ".dispatchToken()"
            case .m_getState: return ".getState()"
            case .m_reduce: return ".reduce()"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func dispatchToken(willReturn: DispatchToken?...) -> MethodStub {
            return Given(method: .m_dispatchToken, products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func getState(willReturn: Observable<BoundedContext>...) -> MethodStub {
            return Given(method: .m_getState, products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func reduce(willReturn: Reducer...) -> MethodStub {
            return Given(method: .m_reduce, products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func dispatchToken(willProduce: (Stubber<DispatchToken?>) -> Void) -> MethodStub {
            let willReturn: [DispatchToken?] = []
			let given: Given = { return Given(method: .m_dispatchToken, products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (DispatchToken?).self)
			willProduce(stubber)
			return given
        }
        public static func getState(willProduce: (Stubber<Observable<BoundedContext>>) -> Void) -> MethodStub {
            let willReturn: [Observable<BoundedContext>] = []
			let given: Given = { return Given(method: .m_getState, products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Observable<BoundedContext>).self)
			willProduce(stubber)
			return given
        }
        public static func reduce(willProduce: (Stubber<Reducer>) -> Void) -> MethodStub {
            let willReturn: [Reducer] = []
			let given: Given = { return Given(method: .m_reduce, products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Reducer).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func setDispatchToken(_ token: Parameter<DispatchToken?>, onDeinit: Parameter<() -> Void>) -> Verify { return Verify(method: .m_setDispatchToken__tokenonDeinit_onDeinit(`token`, `onDeinit`))}
        public static func dispatchToken() -> Verify { return Verify(method: .m_dispatchToken)}
        public static func getState() -> Verify { return Verify(method: .m_getState)}
        public static func reduce() -> Verify { return Verify(method: .m_reduce)}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func setDispatchToken(_ token: Parameter<DispatchToken?>, onDeinit: Parameter<() -> Void>, perform: @escaping (DispatchToken?, @escaping () -> Void) -> Void) -> Perform {
            return Perform(method: .m_setDispatchToken__tokenonDeinit_onDeinit(`token`, `onDeinit`), performs: perform)
        }
        public static func dispatchToken(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_dispatchToken, performs: perform)
        }
        public static func getState(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_getState, performs: perform)
        }
        public static func reduce(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_reduce, performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        self.queue.sync { invocations.append(call) }
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }
    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        return matchingCalls(method.method, file: file, line: line).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

// MARK: - UseCase

open class UseCaseMock: UseCase, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst

    private var queue = DispatchQueue(label: "com.swiftymocky.invocations", qos: .userInteractive)
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }





    open func execute() {
        addInvocation(.m_execute)
		let perform = methodPerformValue(.m_execute) as? () -> Void
		perform?()
    }


    fileprivate enum MethodType {
        case m_execute

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_execute, .m_execute): return .match
            }
        }

        func intValue() -> Int {
            switch self {
            case .m_execute: return 0
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_execute: return ".execute()"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func execute() -> Verify { return Verify(method: .m_execute)}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func execute(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_execute, performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        self.queue.sync { invocations.append(call) }
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }
    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        return matchingCalls(method.method, file: file, line: line).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

