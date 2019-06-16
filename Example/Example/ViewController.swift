//
//  ViewController.swift
//  Example
//
//  Created by Quentin Liardeaux on 6/16/19.
//  Copyright © 2019 Quentin Liardeaux. All rights reserved.
//

import UIKit
import QLCalendar

class ViewController: UIViewController {
 
    var menuView: UIView!
    var titleLabel: UILabel!
    var calendar: UICalendarView!

    override func viewDidLoad() {
        super.viewDidLoad()
        initCalendarView()
    }

    private func initCalendarView() {
        menuView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height * 0.1))
        menuView.backgroundColor = .blue
        view.addSubview(menuView)
        
        titleLabel = UILabel(frame: CGRect(x: view.frame.width * 0.05, y: menuView.frame.height / 2,
                                           width: view.frame.width, height: menuView.frame.height / 2))
        titleLabel.text = "Calendar"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 30)
        menuView.addSubview(titleLabel)
        
        calendar = UICalendarView(frame: CGRect(x: 0, y: menuView.frame.maxY, width: view.frame.width,
                                                height: view.frame.height - menuView.frame.height))
        calendar.backgroundColor = .white
        calendar.textColor = .blue
        calendar.delegate = self
        view.addSubview(calendar)
    }
}

extension ViewController: UICalendarViewDelegate
{
    func calendarView(set startDate: DateOperation?) {
        
    }
    
    func calendarView(update endDate: DateOperation?) {
        
    }
}
