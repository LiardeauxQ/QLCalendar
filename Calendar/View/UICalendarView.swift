//
//  UICalendarView.swift
//  Calendar_Test
//
//  Created by Quentin Liardeaux on 6/11/18.
//  Copyright © 2018 Quentin Liardeaux. All rights reserved.
//

import UIKit;

public protocol UICalendarViewDelegate: class {
	func calendarView(set startDate: DateOperation?);
	func calendarView(update endDate: DateOperation?);
}

public class UICalendarView: UIView
{
	private var weekBar: WeekBarView!;
	private var currentYear: Int = 0;
	private var currentMonth: Int = 0;
	private var collectionView: UICollectionView!;
	public var textColor: UIColor {
		get {
			return (self.weekBar.textColor);
		}
		set {
			self.weekBar.textColor = newValue;
		}
	}
	private var currentDate: DateOperation!;
	private var startDate: DateOperation?;
	private var endDate: DateOperation?;
	public weak var delegate: UICalendarViewDelegate?;
	private var numberOfSections: Int = 12;
	public var isDatesReset: Bool = false {
		didSet {
			resetDates();
		}
	}

	override public init(frame: CGRect)
	{
		super.init(frame: frame);
		self.currentDate = DateOperation();
		initWeekBar();
		initCollectionView()
	}

	required public init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
	
	func initWeekBar()
	{
		self.weekBar = WeekBarView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 30));
		self.weekBar.backgroundColor = self.backgroundColor;
		self.addSubview(self.weekBar);
	}
	
	func initCollectionView()
	{
		let screenWidth = self.frame.width;
		let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout();
		
		layout.sectionInset = UIEdgeInsets.zero;
		layout.minimumInteritemSpacing = 0;
		layout.minimumLineSpacing = 0;
		layout.itemSize = CGSize(width: screenWidth / 7, height: 50);
		self.collectionView = UICollectionView(frame: CGRect(x: 0, y: self.weekBar.frame.height, width: screenWidth, height: self.frame.height), collectionViewLayout: layout);
		self.collectionView.backgroundColor = self.backgroundColor;
		self.collectionView.isUserInteractionEnabled = true;
		self.collectionView.isMultipleTouchEnabled = true;
		self.collectionView.delegate = self;
		self.collectionView.dataSource = self;
		self.collectionView.register(CalendarCollectionViewCell.self, forCellWithReuseIdentifier: "calendarCollectionViewCell");
		self.collectionView.register(CollectionViewCellHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "Header");
		self.addSubview(self.collectionView);
	}
	
	func resetDates()
	{
		if (self.isDatesReset == true) {
			self.startDate = nil;
			self.endDate = nil;
			self.delegate?.calendarView(set: self.startDate);
			self.delegate?.calendarView(update: self.endDate);
			self.collectionView.reloadData();
		}
	}
}

extension UICalendarView: UICollectionViewDataSource,
	UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
	public func numberOfSections(in collectionView: UICollectionView) -> Int
	{
		return (self.numberOfSections);
	}
	
	public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
	{
		return (40);
	}
	
	public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize
	{
		return (CGSize(width: self.frame.width, height: 50));
	}
	
	public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView
	{
		if (kind == UICollectionView.elementKindSectionHeader) {
			if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath) as? CollectionViewCellHeader {

				sectionHeader.textLabel?.text =
					MonthEnum.allCases[((self.currentDate.month - 1)
						+ indexPath.section) % 12].rawValue;
				sectionHeader.textLabel?.textColor = self.textColor;
				return (sectionHeader);
			}
		}
		return UICollectionReusableView();
	}
	
	public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
	{
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "calendarCollectionViewCell", for: indexPath) as? CalendarCollectionViewCell else {
			fatalError("The dequeue reusable cell is not an instance of CollectionViewCell");
		}
		var stockDate = self.currentDate!;
		let deltaDay: Int;

		stockDate.add(months: indexPath.section);
		deltaDay = stockDate.weekDayPosition;
		cell.isHidden = true;
		cell.selectionColors = (isTrue: self.backgroundColor, isFalse: self.textColor);
		if (indexPath.item >= stockDate.weekDayPosition && stockDate.day == 1) {
			if (indexPath.item - deltaDay < stockDate.findDays(for: stockDate.month, in: stockDate.year)) {
				stockDate.add(days: indexPath.item - deltaDay);
				initCell(cell, stockDate);
			}
		}
		return (cell);
	}
	
	func initCell(_ cell: CalendarCollectionViewCell, _ date: DateOperation)
	{
		cell.isHidden = false;
		cell.date = date;
		cell.calendarDayLabel.text = String(date.day);
		cell.isInInterval = false;
		if (date < self.currentDate!) {
			cell.isUserInteractionEnabled = false;
			if (self.textColor == UIColor.white) {
				cell.calendarDayLabel.textColor = self.textColor.darker(by: 0.7);
			} else {
				cell.calendarDayLabel.textColor = self.textColor.lighter(by: 0.3);
			}
		}
		if let start = self.startDate {
			if (date < start) {
				cell.isUserInteractionEnabled = false;
			}
			if (date == start) {
				cell.isInInterval = true;
			}
			if let end = self.endDate {
				if (date >= start && date <= end) {
					cell.isInInterval = true;
				}
			}
		}
	}
	
	public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
	{
		guard let cell = collectionView.cellForItem(at: indexPath) as? CalendarCollectionViewCell else {
			return;
		}

		if (self.startDate == nil) {
			self.startDate = cell.date;
			self.delegate?.calendarView(set: self.startDate);
			self.collectionView.reloadData();
		} else {
			self.endDate = cell.date;
			self.delegate?.calendarView(update: self.endDate);
			self.collectionView.reloadData();
		}
	}
	
	public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
	{
		return CGSize(width: computeCellWidth(cellNb: 7, spacing: 0), height: 50);
	}
	
	func computeCellWidth(cellNb: CGFloat, spacing: CGFloat) -> CGFloat
	{
		return ((self.frame.width - ((spacing * cellNb) + 1)) / cellNb);
	}
}
