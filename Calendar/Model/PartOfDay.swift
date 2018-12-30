//
//  PartOfDay.swift
//  Chirashi-Pro
//
//  Created by Quentin Liardeaux on 10/4/18.
//  Copyright © 2018 Quentin Liardeaux. All rights reserved.
//

import Foundation;

public enum PartOfDayEnum: String, CaseIterable {
	case NoPreference;
	case Morning;
	case Noon;
	case AfterNoon;
	case Evening;
	
	public func toFrench() -> String
	{
		switch self {
		case .NoPreference:
			return ("Pas de préférence");
		case .Morning:
			return ("Matinéé");
		case .Noon:
			return ("Midi");
		case .AfterNoon:
			return ("Après-Midi");
		case .Evening:
			return ("Soirée");
		}
	}
	
	public func interval() -> (start: Int, end: Int) // Arbitrary values
	{
		switch self {
		case .NoPreference:
			return ((start: 0, end: 1439)); // 12:00 am to 11:59 pm
		case .Morning:
			return ((start: 0, end: 720)); // 12:00 am to 12:00 pm
		case .Noon:
			return ((start: 720, end: 840)); // 12:00 pm to 2:00 pm
		case .AfterNoon:
			return ((start: 840, end: 1080)); // 2:00 pm to 6:00 pm
		case .Evening:
			return ((start: 1080, end: 1439)); // 6:00 pm to 11:59 pm
		}
	}
	
	static public func find(with timeValue: Int) -> PartOfDayEnum
	{
		for value in self.allCases {
			if value == .NoPreference {
				continue;
			} else if (timeValue > value.interval().start
				&& timeValue < value.interval().end) {
				return (value);
			}
		}
		return (self.NoPreference);
	}
}
