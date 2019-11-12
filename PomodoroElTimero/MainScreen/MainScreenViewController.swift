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

public enum TimerState {
    case notRunning
    case running
    case paused
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

    //MARK: - Other
    private func setButtonsWithState(_ state: TimerState) {
        switch state {
        case .notRunning:
            customView?.isStartButtonHidden(false)
            customView?.isPauseButtonHidden(true)
            customView?.isStopButtonHidden(true)
            customView?.isProceedButtonHidden(true)
        case .running:
            customView?.isStartButtonHidden(true)
            customView?.isPauseButtonHidden(false)
            customView?.isStopButtonHidden(false)
            customView?.isProceedButtonHidden(true)
        case .paused:
            customView?.isStartButtonHidden(true)
            customView?.isPauseButtonHidden(true)
            customView?.isStopButtonHidden(false)
            customView?.isProceedButtonHidden(false)
        }
    }
}

//MARK: - MainScreenViewControllerProtocol
extension MainScreenViewController: MainScreenViewControllerProtocol {
    func viewDidPressStartButton() {
        setButtonsWithState(.running)
        setupTimerWithInterval()
    }

    func viewDidPressStopButton() {
        setButtonsWithState(.notRunning)
        invalidateTimer()
        currentSessionTime = model.workSessionTime
        setViewTimer(with: currentSessionTime)
    }

    func viewDidPressPauseButton() {
        setButtonsWithState(.paused)
        invalidateTimer()
    }

    func viewDidPressProceedButton() {
        setButtonsWithState(.running)
        setupTimerWithInterval()
    }

    @objc func updateCurrentTime() {
        currentSessionTime = currentSessionTime - 1
        if currentSessionTime < 0 {
            currentSessionTime = model.workSessionTime
            invalidateTimer()
            setViewTimer(with: currentSessionTime)
            setButtonsWithState(.notRunning)
        } else {
            setViewTimer(with: currentSessionTime)
        }
    }
}

