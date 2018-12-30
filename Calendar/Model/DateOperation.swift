//
//  DateOperation.swift
//  Chirashi-Pro
//
//  Created by Quentin Liardeaux on 9/19/18.
//  Copyright © 2018 Quentin Liardeaux. All rights reserved.
//

import Foundation;

public struct DateOperation
{
	public var year: Int = -1;
	public var month: Int = -1;
	public var day: Int = -1;
	public var weekDayPosition: Int = -1;
	public var stringDate: String = "";
	static public let daysForMonths = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

	public init(year: Int, month: Int, day: Int)
	{
		if (isDateValid(year, month, day)) {
			self.year = year;
			self.month = month;
			self.day = day;
			self.stringDate = "\(year)/\(month)/\(day)";
			if (self.year > 0 && self.month > 0 && self.day > 0) {
				findWeekDayPosition(stringDate: self.convertToStringFullDate()?.lowercased() ?? "");
			}
		}
	}

	public init(stringDate: String)
	{
		var splitDate = stringDate.split(separator: "/");

		if (!stringDate.contains(where: { ($0 < Character("0") || $0 > Character("9"))
			&& $0 != Character("/")}) && splitDate.count >= 3) {
			self.year = Int(splitDate[0]) ?? 0;
			self.month = Int(splitDate[1]) ?? 1;
			self.day = Int(splitDate[2]) ?? 1;
			self.weekDayPosition = 0;
			self.stringDate = "\(self.year)/\(self.month)/\(self.day)";
			findWeekDayPosition(stringDate: self.convertToStringFullDate()?.lowercased() ?? "");
		}
		if (!isDateValid(self.year, self.month, self.day)) {
			self.year = -1;
			self.month = -1;
			self.day = -1;
			self.weekDayPosition = -1;
			self.stringDate = "";
		}
	}

	public init(date: Date? = nil)
	{
		let date: Date = date ?? Date();
		let dateForm = DateFormatter();
		var splitDate: [Substring];
		
		dateForm.dateFormat = "YYYY/MM/dd";
		dateForm.locale = Locale(identifier: "fr_FR");
		dateForm.timeZone = TimeZone.current;
		dateForm.dateStyle = .short;
		splitDate = dateForm.string(from: date).split(separator: Character("/"));
		self.init(year: Int(splitDate[2]) ?? 0, month: (Int(splitDate[1]) ?? 1), day: Int(splitDate[0]) ?? 1);
	}

	private func isDateValid(_ year: Int, _ month: Int, _ days: Int) -> Bool
	{
		var daysForMonth: Int;

		if (year < 0) {
			return false
		}
		if (month < 1 || month > 12) {
			return false;
		}
		daysForMonth = findDays(for: month, in: year);
		if (days < 1 || days > daysForMonth) {
			return false;
		}
		return (true);
	}

	mutating func findWeekDayPosition(stringDate: String)
	{
		var i: Int = 0;

		for day in WeekDay.allCases {
			if ((stringDate.range(of: day.toFrench().lowercased())) != nil) {
				self.weekDayPosition = i;
				break;
			}
			i = i + 1;
		}
	}

	mutating public func add(days: Int)
	{
		var addMonth: Int = 1;
		var monthSum: Int = 0;
		var monthDayNb = findDays(for: self.month, in: self.year);

		if (days <= 0 || !isDateValid(self.year, self.month, self.day)) {
			return;
		}
		self.month -= 1;
		monthSum = DateOperation.daysForMonths[self.month % 12];
		self.day += days;
		while (self.day > monthSum) {
			if ((self.month + addMonth) % 12 == 0) {
				self.year = self.year + 1;
			}
			monthDayNb = findDays(for: (self.month + 1 + addMonth), in: self.year);
			monthSum += monthDayNb;
			addMonth = addMonth + 1;
		}
		if (self.month + addMonth % 12 == 0) {
			self.year = self.year + 1;
		}
		self.day -= (monthSum - monthDayNb);
		self.month = (self.month + addMonth - 1) % 12 + 1;
		self.stringDate = "\(self.year)/\(self.month)/\(self.day)";
		findWeekDayPosition(stringDate: self.convertToStringFullDate()?.lowercased() ?? "")
	}

	mutating public func add(months: Int)
	{
		var i: Int = 1;

		if (months < 0 || !isDateValid(self.year, self.month, self.day)) {
			return;
		}
		self.month -= 1;
		self.day = 1;
		if (months > 0) {
			self.month = (self.month + 1) % 12;
		}
		while (i < months) {
			if (self.month == 0) {
				self.year += 1;
			}
			self.month = (self.month + 1) % 12;
			i = i + 1;
		}
		if (self.month == 0) {
			self.year += 1;
		}
		self.month += 1;
		self.stringDate = "\(self.year)/\(self.month)/\(self.day)";
		findWeekDayPosition(stringDate: self.convertToStringFullDate()?.lowercased() ?? "")
	}

	mutating public func sub(days: Int)
	{
		var monthDays = findDays(for: self.month, in: self.year);
		var lastMonth: Int = 0;

		if (days <= 0 || !isDateValid(self.year, self.month, self.day)) {
			return;
		}
		self.month -= 1;
		self.day -= 1;
		for _ in 0 ..< days {
			if (self.day == 0) {
				lastMonth = self.month;
				self.month = ((self.month - 1) % 12 + 12) % 12;
				if (self.month == 11 && lastMonth == 0) {
					self.year -= 1;
				}
				monthDays = findDays(for: self.month + 1, in: self.year);
			}
			self.day = ((self.day - 1) % monthDays + monthDays) % monthDays;
		}
		self.day += 1;
		self.month += 1;
		self.stringDate = "\(self.year)/\(self.month)/\(self.day)";
		findWeekDayPosition(stringDate: self.convertToStringFullDate()?.lowercased() ?? "");
	}

	mutating public func sub(months: Int)
	{
		var lastMonth: Int = 0;

		if (months < 0 || !isDateValid(self.year, self.month, self.day)) {
			return;
		}
		self.month -= 1;
		self.day = 1;
		for _ in 0 ..< months {
			lastMonth = self.month
			self.month = ((self.month - 1) % 12 + 12) % 12;
			if (self.month == 11 && lastMonth == 0) {
				self.year -= 1;
			}
		}
		self.month += 1;
		self.stringDate = "\(self.year)/\(self.month)/\(self.day)";
		findWeekDayPosition(stringDate: self.convertToStringFullDate()?.lowercased() ?? "")
	}

	public func findDays(for month: Int, in year: Int) -> Int
	{
		var monthDays: Int

		monthDays = DateOperation.daysForMonths[(month - 1) % 12];
		if (((year % 4 == 0 && year % 100 != 0)
			|| (year % 400 == 0)) && month == 2) {
			monthDays = 29;
		}
		return (monthDays);
	}

	public func convertToStringFullDate() -> String?
	{
		let dateForm = DateFormatter();
		let stringDate = "\(self.year)/\(self.month)/\(self.day)";

		if (!isDateValid(self.year, self.month, self.day)) {
			return (nil);
		}
		dateForm.dateFormat = "YYYY/MM/dd";
		if let date = dateForm.date(from: stringDate) {
			dateForm.locale = Locale(identifier: "fr_FR");
			dateForm.timeZone = TimeZone.current;
			dateForm.dateStyle = .full;
			return (dateForm.string(from: date));
		}
		return (nil);
	}

	public func convertToStringShortDate() -> String?
	{
		let fullStringDate = self.convertToStringFullDate();
		guard let splitStringDate = fullStringDate?.split(separator: " ") else {
			return (nil);
		};
		var i: Int = 0;

		for stringWeekDay in WeekDay.allCases {
			if (splitStringDate[0].lowercased() == stringWeekDay.toFrench().lowercased()) {
				return ("\(WeekDay.allCases[i].toShortFrench()) \(splitStringDate[1])");
			}
			i = i + 1;
		}
		return (nil);
	}

	public func convertToStringMonthDate() -> String?
	{
		let fullStringDate = self.convertToStringFullDate();
		guard let splitStringDate = fullStringDate?.split(separator: " ") else {
			return (nil);
		};

		if (splitStringDate.count == 4) {
			return ("\(splitStringDate[1]) \(splitStringDate[2]) \(splitStringDate[3])");
		}
		return (nil);
	}

	static public func convertToLong(stringDate: String) -> String?
	{
		let dateForm = DateFormatter();

		dateForm.dateFormat = "YYYY/MM/dd";
		if let date = dateForm.date(from: stringDate) {
			var splitDate: [Substring];
			
			dateForm.locale = Locale(identifier: "fr_FR");
			dateForm.timeZone = TimeZone.current;
			dateForm.dateStyle = .full;
			splitDate = dateForm.string(from: date).split(separator: Character(" "));
			return ("\(splitDate[0]) \(splitDate[1]) \(splitDate[2])".capitalized);
		}
		return (nil);
	}

	// Date Operators

	static public func ==(lhs: DateOperation, rhs: DateOperation) -> Bool
	{
		if (lhs.year == rhs.year && lhs.month == rhs.month && lhs.day == rhs.day) {
			return (true);
		}
		return (false);
	}

	static public func !=(lhs: DateOperation, rhs: DateOperation) -> Bool
	{
		if (lhs.year != rhs.year || lhs.month != rhs.month || lhs.day != rhs.day) {
			return (true);
		}
		return (false);
	}

	static public func <(lhs: DateOperation, rhs: DateOperation) -> Bool
	{
		if (lhs.year < rhs.year) {
			return (true);
		} else if (lhs.year == rhs.year) {
			if (lhs.month < rhs.month) {
				return (true);
			} else if (lhs.month == rhs.month) {
				if (lhs.day < rhs.day) {
					return (true);
				}
			}
		}
		return (false);
	}

	static public func >(lhs: DateOperation, rhs: DateOperation) -> Bool
	{
		if (lhs.year > rhs.year) {
			return (true);
		} else if (lhs.year == rhs.year) {
			if (lhs.month > rhs.month) {
				return (true);
			} else if (lhs.month == rhs.month) {
				if (lhs.day > rhs.day) {
					return (true);
				}
			}
		}
		return (false);
	}

	static public func <=(lhs: DateOperation, rhs: DateOperation) -> Bool
	{
		if (lhs.year < rhs.year) {
			return (true);
		} else if (lhs.year == rhs.year) {
			if (lhs.month < rhs.month) {
				return (true);
			} else if (lhs.month == rhs.month) {
				if (lhs.day <= rhs.day) {
					return (true);
				}
			}
		}
		return (false);
	}

	static public func >=(lhs: DateOperation, rhs: DateOperation) -> Bool
	{
		if (lhs.year > rhs.year) {
			return (true);
		} else if (lhs.year == rhs.year) {
			if (lhs.month > rhs.month) {
				return (true);
			} else if (lhs.month == rhs.month) {
				if (lhs.day >= rhs.day) {
					return (true);
				}
			}
		}
		return (false);
	}
}
