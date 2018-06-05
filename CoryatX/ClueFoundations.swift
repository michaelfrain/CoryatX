//
//  ClueFoundations.swift
//  CoryatX
//
//  Created by Michael Frain on 6/5/18.
//  Copyright © 2018 Michael Frain. All rights reserved.
//

enum ResponseState {
    case unselected
    case correct
    case incorrect
    case unanswered
}

enum BaseClueValue: Int {
    case firstRound = 200
    case secondRound = 400
    
    static var valueArray = [BaseClueValue.firstRound, BaseClueValue.secondRound]
    
    fileprivate static func calculateClueValue(forPosition position: Int, inRound round: BaseClueValue) -> Int {
        // Position is 0-indexed, so to get the correct modulus we should add 1
        var modulus = (position + 1) % 5
        if modulus == 0 {
            modulus = 5
        }
        return ((position + 1) % 5) * round.rawValue
    }
}

protocol Answerable {
    var clueValue: Int { get set }
    var clueState: ResponseState { get set }
}

struct Clue: Answerable {
    var clueValue: Int
    var clueState: ResponseState
    
    init(atPosition position: Int, inState state: ResponseState = .unselected, inRound isFirstRound: Bool) {
        let round = isFirstRound ? BaseClueValue.firstRound : BaseClueValue.secondRound
        clueValue = BaseClueValue.calculateClueValue(forPosition: position, inRound: round)
        clueState = state
    }
}
