//
//  Week.swift
//  Calendar
//
//  Created by Quentin Liardeaux on 12/12/18.
//  Copyright © 2018 Quentin Liardeaux. All rights reserved.
//

import Foundation;

public struct Week {
	public var start: DateOperation;
	public var end: DateOperation;

	public init(start: DateOperation, end: DateOperation)
	{
		self.start = start;
		self.end = end;
	}
	
	public init(with date: DateOperation)
	{
		self.start = date;
		self.end = date;
		self.start.sub(days: date.weekDayPosition);
		self.end.add(days: 6 - date.weekDayPosition);
	}
	
	public mutating func add(week: Int)
	{
		self.start.add(days: 7);
		self.end.add(days: 7);
	}
	
	public mutating func sub(week: Int)
	{
		self.start.sub(days: 7);
		self.end.sub(days: 7);
	}
}
