//
//  GameConfig.swift
//  clear-the-grid
//
//  Created by Alfred Broderick on 6/14/20.
//  Copyright © 2020 Alfred Broderick. All rights reserved.
//

import SwiftUI

struct GameConfig {
    static let numberOfColumns : Int = 7
    static let numberOfRows : Int = (Int(Screen.height) / (Int(Screen.width) / GameConfig.numberOfColumns)) - 1
    static let buttonSize : CGFloat = (CGFloat(Screen.width) / CGFloat(GameConfig.numberOfColumns)) - 2.0
    static let gridSize : Int = GameConfig.numberOfColumns * GameConfig.numberOfRows
    
    private static let buttonColors = [ Color.orange, Color.silver, Color.rose, Color.purple,
                                        Color.green, Color.blue, Color.red, Color.yellow,
                                        Color.cyan, Color.cabernet, Color.olive, Color.melon,
                                        Color.teal, Color.gold, Color.navy, Color.forest, Color.brown]

    private static let colorIndex : Int = Calendar.current.component(.second, from: Date()) % buttonColors.count
    
    var buttonColor : Color {
        return GameConfig.buttonColors[GameConfig.colorIndex]
    }
    
    var strokeColor : Color {
        switch buttonColor {
        
        case .lime,
             .orange,
             .pink,
             .yellow,
             .cyan,
             .teal,
             .silver,
             .gold,
             .magenta,
             .green,
             .rose,
             .melon:
            
            return .darkgray
            
        default:
            
            return .lightgray
        }
    }
}
