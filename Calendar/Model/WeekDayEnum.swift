//
//  WeekDayEnum.swift
//  Calendar
//
//  Created by Quentin Liardeaux on 11/15/18.
//  Copyright © 2018 Quentin Liardeaux. All rights reserved.
//

import Foundation;

public enum WeekDay: String, CaseIterable {
	case Monday;
	case Tuesday;
	case Wednesday;
	case Thursday;
	case Friday;
	case Saturday;
	case Sunday;
	
	public func toFrench() -> String
	{
		switch self {
		case .Monday:
			return ("Lundi");
		case .Tuesday:
			return ("Mardi");
		case .Wednesday:
			return ("Mercredi");
		case .Thursday:
			return ("Jeudi");
		case .Friday:
			return ("Vendredi");
		case .Saturday:
			return ("Samedi");
		case .Sunday:
			return ("Dimanche");
		}
	}
	
	public func toShortFrench() -> String
	{
		switch self {
		case .Monday:
			return ("lun.");
		case .Tuesday:
			return ("mar.");
		case .Wednesday:
			return ("mer");
		case .Thursday:
			return ("jeu.");
		case .Friday:
			return ("ven.");
		case .Saturday:
			return ("sam.");
		case .Sunday:
			return ("dim.");
		}
	}
}
