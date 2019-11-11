//
//  ViewController.swift
//  PomodoroElTimero
//
//  Created by Сергей Василенко on 11/11/2019.
//  Copyright © 2019 Sergey Vasilenko. All rights reserved.
//

import UIKit

public protocol MainScreenViewControllerProtocol where Self: UIViewController {
    func viewDidPressStartButton()
    func viewDidPressStopButton()
}

class MainScreenViewController: UIViewController {
    private var customView: MainScreenViewProtocol?

    override func loadView() {
        customView = MainScreenView(with: self)
        view = customView
    }
}

extension MainScreenViewController: MainScreenViewControllerProtocol {
    func viewDidPressStartButton() {
        customView?.isStartButtonHidden(true)
        customView?.isStopButtonHidden(false)
    }

    func viewDidPressStopButton() {
        customView?.isStartButtonHidden(false)
        customView?.isStopButtonHidden(true)
    }
}

