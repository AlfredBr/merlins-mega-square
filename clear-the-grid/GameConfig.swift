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
    static let numberOfRows : Int = 13 // (Int(Screen.height) / (Int(Screen.width) / GameConfig.numberOfColumns)) - 2
    static let buttonSize : CGFloat = (CGFloat(Screen.width) / CGFloat(GameConfig.numberOfColumns)) - 2.0
    static let gridSize : Int = GameConfig.numberOfColumns * GameConfig.numberOfRows
    static let gridHeight : CGFloat = CGFloat(GameConfig.numberOfRows) * buttonSize + CGFloat(GameConfig.numberOfRows)
    private static let buttonColors = [ Color.orange, Color.silver, Color.rose, Color.purple,
                                        Color.green, Color.blue, Color.red, Color.yellow,
                                        Color.cyan, Color.cabernet, Color.olive, Color.melon,
                                        Color.teal, Color.gold, Color.navy, Color.forest, Color.brown]

    static func getColorIndex() -> Int {
        return  Calendar.current.component(.second, from: Date()) % buttonColors.count
    }
    
    static func getButtonColor(_ colorIndex: Int) -> Color {
        return GameConfig.buttonColors[colorIndex]
    }
    
    static func getStrokeColor(_ colorIndex: Int) -> Color {
        let buttonColor = getButtonColor(colorIndex)
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
