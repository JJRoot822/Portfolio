//
//  BookBucketColorExtensionTests.swift
//  BookBucketTests
//
//  Created by Joshua Root on 5/8/24.
//

import XCTest
import SwiftUI
@testable import BookBucket

final class BookBucketColorExtensionTests: XCTestCase {

    func test_colorForNameShouldReturnBlue() {
        let color = Color.color(forName: "Blue")
        
        XCTAssert(color == .blue)
    }
    
    func test_colorForNameShouldReturnNil() {
        let color = Color.color(forName: "blue")
        
        XCTAssertNil(color)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
