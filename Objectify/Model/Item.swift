//
//  Item.swift
//  Objectify
//
//  Created by ehsan sat on 4/22/20.
//  Copyright © 2020 ehsan sat. All rights reserved.
//

import Foundation

class Item {
    var sentenceText: String = ""
    var sentencePartType: String = ""
    var sentenceNumber: Double = 0.0
    var text: String = ""
    var keywordType: String = ""
    var mentions: Double = 0.0
    var sentimentPolarity: String = ""
    var sentimentResult: String = ""
    var sentimentValue: Double = 0.0
    var magnitude: Double = 0.0
    init(sentenceText: String, sentencePartType: String, sentenceNumber: Double, text: String, keywordType: String, mentions: Double, sentimentPolarity: String, sentimentResult: String, sentimentValue: Double, magnitude: Double) {
        self.sentenceText = sentenceText
        self.sentencePartType = sentencePartType
        self.sentenceNumber = sentenceNumber
        self.text = text
        self.keywordType = keywordType
        self.mentions = mentions
        self.sentimentPolarity = sentimentPolarity
        self.sentimentResult = sentimentResult
        self.sentimentValue = sentimentValue
        self.magnitude = magnitude
    }
}

