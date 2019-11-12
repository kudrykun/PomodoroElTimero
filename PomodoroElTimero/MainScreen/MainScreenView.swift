//
//  MainScreenView.swift
//  PomodoroElTimero
//
//  Created by Сергей Василенко on 11/11/2019.
//  Copyright © 2019 Sergey Vasilenko. All rights reserved.
//

import UIKit

public protocol MainScreenViewProtocol where Self: UIView {
    func isStartButtonHidden(_ value: Bool)
    func isStopButtonHidden(_ value: Bool)
    func setTimeLabelText(_ text: String?)
}

class MainScreenView: UIView {
    private weak var viewController: MainScreenViewControllerProtocol?

    //MARK: - Subviews
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "00 : 00"
        label.font = UIFont.systemFont(ofSize: 50.0, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let startSessionButton: UIButton = {
        let button = UIButton()
        button.setTitle("Старт", for: .normal)
        button.backgroundColor = .red
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(startButtonPressed), for: .touchUpInside)
        return button
    }()

    private let stopSessionButton: UIButton = {
        let button = UIButton()
        button.setTitle("Стоп", for: .normal)
        button.backgroundColor = .red
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(stopButtonPressed), for: .touchUpInside)
        return button
    }()

    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("init?(coder:) was not implemented!")
    }

    public init(with viewController: MainScreenViewControllerProtocol) {
        super.init(frame: .zero)
        setupView()
        setupSubviews()
        self.viewController = viewController
    }

    //MARK: - Views Setup
    private func setupView() {
        backgroundColor = .white
    }

    private func setupSubviews() {
        addSubview(timeLabel)
        addSubview(startSessionButton)

        stopSessionButton.isHidden = true
        addSubview(stopSessionButton)
    }

    //MARK: - Constraints
    override func layoutSubviews() {
        setTimeLabelConstraints()
        setStartSessionButtonConstraints()
        setStopSessionButtonConstraints()
    }

    private func setTimeLabelConstraints() {
        timeLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        timeLabel.bottomAnchor.constraint(equalTo: self.centerYAnchor, constant: -10).isActive = true
        timeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        timeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
    }

    private func setStartSessionButtonConstraints() {
        startSessionButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        startSessionButton.topAnchor.constraint(equalTo: self.centerYAnchor, constant: 10).isActive = true
        startSessionButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/4).isActive = true
    }

    private func setStopSessionButtonConstraints() {
        stopSessionButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        stopSessionButton.topAnchor.constraint(equalTo: self.centerYAnchor, constant: 10).isActive = true
        stopSessionButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/4).isActive = true
    }

    //MARK: - Actions
    @objc private func startButtonPressed() {
        viewController?.viewDidPressStartButton()
    }

    @objc private func stopButtonPressed() {
        viewController?.viewDidPressStopButton()
    }

}

//MARK: - MainScreenViewProtocol
extension MainScreenView: MainScreenViewProtocol {
    func isStartButtonHidden(_ value: Bool) {
        startSessionButton.isHidden = value
    }

    func isStopButtonHidden(_ value: Bool) {
        stopSessionButton.isHidden = value
    }

    func setTimeLabelText(_ text: String?) {
        timeLabel.text = text
    }
}
