//
//  AcquaintanceModel.swift
//  SmartUseApp
//
//  Created by Владимир Ли on 23.05.2022.
//

import UIKit

struct Page {
    
    var title: String
    var text: String
    var imageName: String
}

extension Page {
    
    static func getData() -> [Page] {
        
        let acquaintanceData = [
            Page(
                title: "Привет!",
                text: "Добро пожаловать! Мы рады, что ты выбрал наше приложение. Сейчас мы расскажем, чем SmartUse может помочь тебе",
                imageName: "icon2"
            ),
            Page(
                title: "Начнем",
                text: "SmartUse предназначен для того, чтобы помочь тебе правильно оценивать свои траты на “нужные” покупки",
                imageName: "icon3"
            ),
            Page(
                title: "Задумайся",
                text: "Во сколько тебе обходится каждая “важная” вещь?",
                imageName: "icon10"
            ),
            Page(
                title: "Продолжай",
                text: "SmartUse покажет тебе, что не нужно менять “старый” вещь на “новую”. А так же подскажет, когда лучше один раз “переплатить”, чем постоянно покупать дешевое изделие",
                imageName: "icon2"
            ),
            Page(
                title: "Не останавливайся",
                text: "Во сколько тебе обходится каждая “важная” вещь? ",
                imageName: "icon1"
            )
        ]
        
        return acquaintanceData
    }
}
