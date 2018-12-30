//
//  CollectionViewCell.swift
//  Calendar_Test
//
//  Created by Quentin Liardeaux on 6/11/18.
//  Copyright © 2018 Quentin Liardeaux. All rights reserved.
//

import UIKit

class CollectionViewCellHeader: UICollectionReusableView
{
	public var textLabel: UILabel?;
	
	override init(frame: CGRect)
	{
		super.init(frame: frame);
		self.textLabel = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height));
		self.addSubview(self.textLabel!);
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}

class CalendarCollectionViewCell: UICollectionViewCell
{
	public var calendarDayLabel: UILabel!
	public var date: DateOperation?;
	var selectionColors: (isTrue: UIColor?, isFalse: UIColor?) {
		didSet {
			updateColor();
		}
	}
	override public var isSelected: Bool {
		didSet {
			updateCellSelectionStyle();
		}
	}
	public var isInInterval: Bool = false {
		didSet {
			updateCellSelectionStyle();
		}
	}
	
	override public init(frame: CGRect)
	{
		super.init(frame: frame);
		initLabel();
	}
	
	required public init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented");
	}
	
	func initLabel()
	{
		let labelSize: CGFloat = 50;

		self.calendarDayLabel = UILabel();
		self.calendarDayLabel.frame = CGRect(x: (self.frame.width - labelSize) / 2, y: 0, width: labelSize, height: labelSize);
		self.calendarDayLabel.font = UIFont.systemFont(ofSize: 17);
		self.calendarDayLabel.layer.cornerRadius = labelSize / 2;
		self.calendarDayLabel.layer.masksToBounds = true;
		self.calendarDayLabel.textAlignment = NSTextAlignment.center;
		self.calendarDayLabel.translatesAutoresizingMaskIntoConstraints = false;
		self.addSubview(self.calendarDayLabel);
	}
	
	func updateCellSelectionStyle()
	{
		if (self.isSelected || self.isInInterval) {
			self.calendarDayLabel.backgroundColor = self.selectionColors.isFalse;
			self.calendarDayLabel.textColor = self.selectionColors.isTrue;
		} else {
			self.calendarDayLabel.backgroundColor = UIColor.clear;
			self.calendarDayLabel.textColor = self.selectionColors.isFalse;
		}
	}
	
	private func updateColor()
	{
		self.calendarDayLabel.textColor = self.selectionColors.isFalse;
	}
	
	override func prepareForReuse()
	{
		self.isUserInteractionEnabled = true;
		self.calendarDayLabel.backgroundColor = UIColor.clear;
		self.calendarDayLabel.textColor = self.selectionColors.isFalse;
		super.prepareForReuse();
	}
}

