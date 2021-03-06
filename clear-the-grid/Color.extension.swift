//
//  Color.extension.swift
//  Magic Square
//
//  Created by Alfred Broderick on 4/14/20.
//  Copyright © 2020 Alfred Broderick. All rights reserved.
//

import SwiftUI

extension Color
{
    static var silver    : Color { return Color(.sRGB, red: 0.7, green: 0.7, blue: 0.7) }
    static var cyan      : Color { return Color(.sRGB, red: 0.0, green: 1.0, blue: 1.0) }
    static var magenta   : Color { return Color(.sRGB, red: 1.0, green: 0.0, blue: 1.0) }
    static var maroon    : Color { return Color(.sRGB, red: 0.5, green: 0.0, blue: 0.0) }
    static var olive     : Color { return Color(.sRGB, red: 0.5, green: 0.5, blue: 0.0) }
    static var lime      : Color { return Color(.sRGB, red: 0.0, green: 1.0, blue: 0.0) }
    static var teal      : Color { return Color(.sRGB, red: 0.0, green: 0.5, blue: 0.5) }
    static var gold      : Color { return Color(.sRGB, red: 0.8, green: 0.6, blue: 0.1) }
    static var navy      : Color { return Color(.sRGB, red: 0.0, green: 0.0, blue: 0.5) }
    static var forest    : Color { return Color(.sRGB, red: 34/256, green: 139/256, blue: 39/256) }
    static var brown     : Color { return Color(.sRGB, red: 205/256, green: 133/256, blue: 63/256) }
    static var wheat     : Color { return Color(.sRGB, red: 0.9764705896, green: 0.850980401, blue: 0.5490196347) }
    static var rose      : Color { return Color(.sRGB, red: 1, green: 0.5010663968, blue: 0.9396337981) }
    static var melon     : Color { return Color(.sRGB, red: 0.7373879231, green: 1, blue: 0.6828219775) }
    static var cabernet  : Color { return Color(.sRGB, red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719 ) }
    
    static var darkgray  : Color { return Color(.sRGB, red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961) }
    static var lightgray : Color { return Color(.sRGB, red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803) }
    
    static var systemBackground : Color { return Color(UIColor.systemBackground) }
    
    static let collection = [ Color.orange, Color.silver, Color.pink, Color.purple, Color.green, Color.blue, Color.gray,
                              Color.red, Color.yellow, Color.cyan, Color.magenta, Color.olive, Color.lime, Color.maroon,
                              Color.rose, Color.melon, Color.teal, Color.gold]
    
    static var random    : Color { return collection[Int.random(in: 0 ..< collection.count)] }
}
