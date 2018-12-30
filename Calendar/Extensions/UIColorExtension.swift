//
//  UIColorExtension.swift
//  Calendar
//
//  Created by Quentin Liardeaux on 11/15/18.
//  Copyright © 2018 Quentin Liardeaux. All rights reserved.
//

import UIKit;

extension UIColor
{
	var colorComponent: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
		var red: CGFloat = 0;
		var blue: CGFloat = 0;
		var green: CGFloat = 0;
		var alpha: CGFloat = 0;
		
		getRed(&red, green: &green, blue: &blue, alpha: &alpha);
		return (red, green, blue, alpha);
	}
	
	var colorArray: [Double] {
		return [Double(self.colorComponent.red),
			Double(self.colorComponent.green),
			Double(self.colorComponent.blue),
			Double(self.colorComponent.alpha)];
	}
	
	func lighter(by percentage: CGFloat) -> UIColor
	{
		let red = self.colorComponent.red + ((1 - self.colorComponent.red) * percentage);
		let green = self.colorComponent.green + ((1 - self.colorComponent.green) * percentage);
		let blue = self.colorComponent.blue + ((1 - self.colorComponent.blue) * percentage);
		
		if (percentage > 1) {
			return (self);
		}
		return (UIColor(displayP3Red: red, green: green, blue: blue, alpha: self.colorComponent.alpha));
	}
	
	func darker(by percentage: CGFloat) -> UIColor
	{
		let red = self.colorComponent.red * percentage;
		let green = self.colorComponent.green * percentage;
		let blue = self.colorComponent.blue  * percentage;
		
		if (percentage > 1) {
			return (self);
		}
		return (UIColor(displayP3Red: red, green: green, blue: blue, alpha: self.colorComponent.alpha));
	}
	
	static func ==(lhs: UIColor, rhs: UIColor) -> Bool
	{
		if (lhs.colorComponent.red == rhs.colorComponent.red && lhs.colorComponent.green
			== rhs.colorComponent.green && lhs.colorComponent.blue
			== rhs.colorComponent.blue && lhs.colorComponent.alpha == rhs.colorComponent.alpha) {
			return (true);
		}
		return (false);
	}
	
	static func !=(lhs: UIColor, rhs: UIColor) -> Bool
	{
		if (lhs.colorComponent.red != rhs.colorComponent.red || lhs.colorComponent.green
			!= rhs.colorComponent.green || lhs.colorComponent.blue
			!= rhs.colorComponent.blue || lhs.colorComponent.alpha != rhs.colorComponent.alpha) {
			return (true);
		}
		return (false);
	}
}
