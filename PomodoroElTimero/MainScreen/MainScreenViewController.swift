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
    func viewDidPressPauseButton()
    func viewDidPressProceedButton()
    func updateCurrentTime()
}

class MainScreenViewController: UIViewController {
    //MARK: - Properties
    private var customView: MainScreenViewProtocol?
    private let model = UserSettingsModel()
    private var currentSessionTime: Int = 0
    private var timer = Timer()


    //MARK: - Lifecycle
    override func loadView() {
        customView = MainScreenView(with: self)
        view = customView
    }

    override func viewDidLoad() {
        currentSessionTime = model.workSessionTime
        setViewTimer(with: currentSessionTime)
    }

    //MARK: - Timer
    private func setupTimerWithInterval() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateCurrentTime), userInfo: nil, repeats: true)
    }

    private func invalidateTimer() {
        timer.invalidate()
    }

    private func setViewTimer(with seconds: Int) {
        guard let customView = customView else { return }
        customView.setTimeLabelText(model.getFormattedTime(from: seconds))
    }
}

//MARK: - MainScreenViewControllerProtocol
extension MainScreenViewController: MainScreenViewControllerProtocol {
    func viewDidPressStartButton() {
        customView?.isStartButtonHidden(true)
        customView?.isPauseButtonHidden(false)
        customView?.isStopButtonHidden(false)
        setupTimerWithInterval()
    }

    func viewDidPressStopButton() {
        customView?.isStartButtonHidden(false)
        customView?.isStopButtonHidden(true)
        customView?.isPauseButtonHidden(true)
        customView?.isProceedButtonHidden(true)
        invalidateTimer()
        currentSessionTime = model.workSessionTime
        setViewTimer(with: currentSessionTime)
    }

    func viewDidPressPauseButton() {
        customView?.isPauseButtonHidden(true)
        customView?.isProceedButtonHidden(false)
        invalidateTimer()
    }

    func viewDidPressProceedButton() {
        customView?.isPauseButtonHidden(false)
        customView?.isProceedButtonHidden(true)
        setupTimerWithInterval()
    }

    @objc func updateCurrentTime() {
        currentSessionTime = currentSessionTime - 1
        setViewTimer(with: currentSessionTime)
    }
}

