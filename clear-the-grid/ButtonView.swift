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
        return GameConfig.getButtonColor(colorIndex);
        //return (colorScheme != .dark) ? Color.black : Color.white
    }
    
    var bgColor : Color
    {
        let color = GameConfig.getButtonColor(colorIndex+1);
        return (colorScheme == .dark) ? color.opacity(0.9) : color.opacity(0.1)
    }
    
    var body : some View {
        return Rectangle()
            .fill(isFilled ? fgColor : bgColor)
            .frame(width:GameConfig.buttonSize, height:GameConfig.buttonSize)
            .overlay(Rectangle()
                .stroke(GameConfig.getStrokeColor(colorIndex), lineWidth: 2)
                .opacity(0.5))
            .blur(radius:1)
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView(isFilled: true, colorIndex: 0)
    }
}
