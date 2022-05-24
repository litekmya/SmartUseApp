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
    var image: String
}

extension Page {
    
    static func getData() -> [Page] {
        
        let acquaintanceData = [
            Page(
                title: "Привет!",
                text: "Добро пожаловать! Мы рады, что ты выбрал наше приложение. Сейчас мы расскажем, чем SmartUse может помочь тебе",
                image: "star"
            ),
            Page(
                title: "Начнем",
                text: "SmartUse предназначен для того, чтобы помочь тебе правильно оценивать свои траты на “нужные” покупки",
                image: "star"
            ),
            Page(
                title: "Задумайся",
                text: "Во сколько тебе обходится каждая “важная” вещь?",
                image: "star"
            ),
            Page(
                title: "Продолжай",
                text: "SmartUse покажет тебе, что не нужно менять “старый” вещь на “новую”. А так же подскажет, когда лучше один раз “переплатить”, чем постоянно покупать дешевое изделие",
                image: "star"
            ),
            Page(
                title: "Не останавливайся",
                text: "Во сколько тебе обходится каждая “важная” вещь? ",
                image: "star"
            )
        ]
        
        return acquaintanceData
    }
}
