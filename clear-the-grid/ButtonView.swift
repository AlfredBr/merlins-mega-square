//
//  ButtonView.swift
//  clear-the-grid (a.k.a. Merlin's MEGA Square)
//
//  Created by Alfred Broderick on 6/14/20.
//  Copyright © 2020 Alfred Broderick. All rights reserved.
//

import SwiftUI

struct ButtonView : View {
    var isFilled : Bool
    var colorIndex : Int
    
    @Environment(\.colorScheme) var colorScheme    
    
    var gameConfig = GameConfig()
    
    var fgColor : Color
    {
        return (colorScheme != .dark) ? Color.black : Color.white
    }
    
    var bgColor : Color
    {
        return (colorScheme == .dark) ? Color.black : Color.white
    }
    
    var body : some View {
        return Rectangle()
            .fill(isFilled ? GameConfig.getButtonColor(colorIndex) : bgColor)
            .frame(width:GameConfig.buttonSize, height:GameConfig.buttonSize)
            .overlay(Rectangle()
                .stroke(GameConfig.getStrokeColor(colorIndex), lineWidth: 2)
                .opacity(0.5))
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView(isFilled: true, colorIndex: 0)
    }
}
