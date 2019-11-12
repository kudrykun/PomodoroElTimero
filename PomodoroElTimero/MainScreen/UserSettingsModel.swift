//
//  UserSettingsModel.swift
//  PomodoroElTimero
//
//  Created by Сергей Василенко on 11/11/2019.
//  Copyright © 2019 Sergey Vasilenko. All rights reserved.
//

import Foundation

class UserSettingsModel {
    public private(set) var workSessionTime: Int = 10 //TODO: Заменить на 1500 перед коммитом
    private var restSessionTime: Int = 5  //TODO: Заменить на 300 перед коммитом

    public func getFormattedTime(from seconds: Int) -> String? {
        guard seconds >= 0 else { return nil }
        guard seconds < 3600 else { return nil }
        let secondsFromSeconds = seconds % 60
        let stringSeconds = secondsFromSeconds >= 10 ? "\(secondsFromSeconds)" : "0\(secondsFromSeconds)"
        let minutesFromSeconds = seconds / 60
        let stringMinutes = minutesFromSeconds >= 10 ? "\(minutesFromSeconds)" : "0\(minutesFromSeconds)"
        return "\(stringMinutes) : \(stringSeconds)"
    }
}
