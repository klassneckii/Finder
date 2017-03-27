//
//  JSONDeserializerTests.swift
//  Finder
//
//  Created by Dmitry Parzhetsky on 24/03/2017.
//  Copyright © 2017 klassneckii prod. All rights reserved.
//

import XCTest

class JSONDeserializerTests: XCTestCase {
    
    var deserializer: JSONDeserializer!
    
    override func setUp() {
        super.setUp()
        deserializer = JSONDeserializer()
    }
    
    override func tearDown() {
        deserializer = nil
        super.tearDown()
    }
    
    func testThatDeserializerConvertsObject() {
        // given
        let object = ["TestedKey" : 42]
        let data = try! JSONSerialization.data(withJSONObject: object,
                                               options: JSONSerialization.WritingOptions.prettyPrinted)
        // when
        let deserializedObject = try! deserializer.deserialize(data: data)
        
        // then
        let dict = deserializedObject as! [String: Int]
        XCTAssertTrue(dict["TestedKey"] == 42)
    }
}
