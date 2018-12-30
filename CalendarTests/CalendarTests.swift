//
//  CalendarTests.swift
//  CalendarTests
//
//  Created by Quentin Liardeaux on 11/15/18.
//  Copyright © 2018 Quentin Liardeaux. All rights reserved.
//

import XCTest
@testable import Calendar

class CalendarTests: XCTestCase
{
	private var date: DateOperation?;

	override func setUp()
	{
		date = DateOperation(stringDate: "2018/11/2");
	}

	override func tearDown()
	{
		date = nil;
	}

   	func testDateOperationRegularDate()
	{
		let date = DateOperation(stringDate: "2018/11/30")

		XCTAssertEqual(date.day, 30);
		XCTAssertEqual(date.month, 11);
		XCTAssertEqual(date.year, 2018);
		XCTAssertEqual(date.stringDate, "2018/11/30");
	}
	
	func testDateOperationWrongDate()
	{
		let date1 = DateOperation(stringDate: "2018/11/2018")
		let date2 = DateOperation(stringDate: "")
		let date3 = DateOperation(stringDate: "2018/11")
		
		XCTAssertEqual(date1.day, -1);
		XCTAssertEqual(date1.month, -1);
		XCTAssertEqual(date1.year, -1);
		XCTAssertEqual(date1.stringDate, "");
		
		XCTAssertEqual(date2.day, -1);
		XCTAssertEqual(date2.month, -1);
		XCTAssertEqual(date2.year, -1);
		XCTAssertEqual(date2.stringDate, "");

		XCTAssertEqual(date3.day, -1);
		XCTAssertEqual(date3.month, -1);
		XCTAssertEqual(date3.year, -1);
		XCTAssertEqual(date3.stringDate, "");
	}
	
	func testAddingDate()
	{
		var date4 = DateOperation(stringDate: "2018/11/2");
	
		date4.add(days: 365);
		XCTAssertEqual(date4.day, 2);
		XCTAssertEqual(date4.month, 11);
		XCTAssertEqual(date4.year, 2019);
		XCTAssertEqual(date4.stringDate, "2019/11/2");
	}
	
	func testSoustractDate()
	{
		var date4 = DateOperation(stringDate: "2018/11/2");
		
		date4.sub(days: 365);
		XCTAssertEqual(date4.day, 2);
		XCTAssertEqual(date4.month, 11);
		XCTAssertEqual(date4.year, 2017);
		XCTAssertEqual(date4.stringDate, "2017/11/2");
	}
	
	func testDate()
	{
		var date = DateOperation(date: Date());
		
		XCTAssertEqual(date.day, 26);
		XCTAssertEqual(date.month, 11);
		XCTAssertEqual(date.year, 2018);
	}

	func testPerformanceExample()
	{
		self.measure {
			date?.add(days: 365);
		}
	}
}
