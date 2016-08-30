import XCTest

import GameBroTests

var tests = Array<XCTestCaseEntry>()
tests.append(contentsOf: GameBroTests.allTests())
XCTMain(tests)
