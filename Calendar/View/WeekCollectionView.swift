//
//  WeekCollectionView.swift
//  Chirashi-Pro
//
//  Created by Quentin Liardeaux on 9/26/18.
//  Copyright © 2018 Quentin Liardeaux. All rights reserved.
//

import Foundation;
import UIKit;

class WeekBarView: UIView
{
	var weekCollectionView: UICollectionView!;
	let weekDayString = ["L", "M", "M", "J", "V", "S", "D"];
	public var textColor: UIColor = UIColor.black {
		didSet {
			self.weekCollectionView.reloadData();
		}
	}

	override public init(frame: CGRect)
	{
		super.init(frame: frame);
		initWeekBar();
	}
	
	required public init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
	
	public func initWeekBar()
	{
		let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
		
		layout.sectionInset = UIEdgeInsets.zero;
		layout.minimumInteritemSpacing = 0
		layout.itemSize = CGSize(width: self.frame.width / 7, height: self.frame.height)
		self.weekCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height), collectionViewLayout: layout)
		self.weekCollectionView.dataSource = self
		self.weekCollectionView.delegate = self
		self.weekCollectionView.register(WeekCollectionCell.self, forCellWithReuseIdentifier: "weekCollectionCell")
		self.weekCollectionView.isScrollEnabled = false;
		self.weekCollectionView.backgroundColor = self.backgroundColor;
		self.addSubview(self.weekCollectionView)
	}
}

extension WeekBarView: UICollectionViewDelegate, UICollectionViewDataSource
{
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
	{
		return (7);
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
	{
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "weekCollectionCell", for: indexPath) as? WeekCollectionCell else {
			fatalError("The dequeue reusable cell is not an instance of WeekCollectionCell");
		}

		cell.weekLabel.text = weekDayString[indexPath.row];
		cell.weekLabel.textColor = self.textColor;
		return (cell);
	}
}

fileprivate class WeekCollectionCell: UICollectionViewCell
{
	public var weekLabel: UILabel!;
	
	override init(frame: CGRect)
	{
		super.init(frame: frame);
		initLabel();
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented");
	}
	
	func initLabel()
	{
		self.weekLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height));
		self.weekLabel.backgroundColor = UIColor.clear;
		self.weekLabel.font = UIFont.systemFont(ofSize: 17);
		self.weekLabel.textAlignment = NSTextAlignment.center;
		self.weekLabel.translatesAutoresizingMaskIntoConstraints = false;
		self.addSubview(self.weekLabel);
	}
}
