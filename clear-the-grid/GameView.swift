//
//  GameView.swift
//  clear-the-grid (a.k.a Merlin's MEGA Square)
//
//  Created by Alfred Broderick on 6/13/20.
//  Copyright © 2020 Alfred Broderick. All rights reserved.
//

import SwiftUI

struct GameView : View {
    @State private var gameGrid = [Bool](repeating: false, count: GameConfig.gridSize)
    @State private var showSplash = true;
    @State private var moveNumber = 0;
    
    let gameConfig = GameConfig()

    func restoreGame()
    {
        if moveNumber == 0 {
            randomize()
            saveGame()
        }
        else {
            loadGame()
        }
    }
    
    func randomize()
    {
        for _ in 0 ..< 100 {
            let x = Int.random(in: 0 ..< GameConfig.numberOfColumns)
            let y = Int.random(in: 0 ..< GameConfig.numberOfRows)
            flip(x, y)
        }
    }
    
    func flip(_ x: Int, _ y: Int) {
        flipN(x,   y)
        flipN(x-1, y)
        flipN(x+1, y)
        flipN(x,   y-1)
        flipN(x,   y+1)
    }
    
    func flipN(_ x: Int, _ y: Int) {
        if x < 0 ||
           y < 0 ||
           x >= GameConfig.numberOfColumns ||
           y >= GameConfig.numberOfRows {
            return
        }
        
        let p = x + (y * GameConfig.numberOfColumns)
        gameGrid[p].toggle()
    }
    
    func printGrid()
    {
        for y in 0 ..< GameConfig.numberOfRows {
            var row = ""
            for x in 0 ..< GameConfig.numberOfColumns {
                let p = x + (y * GameConfig.numberOfColumns)
                row += gameGrid[p] ? "* " : "_ "
            }
            print(row)
        }
    }
    
    func saveGame() {
        
    }
    
    func loadGame() {
        
    }
    
    func isWinner() -> Bool {
        return gameGrid.allSatisfy({$0 == gameGrid.first})
    }
    
    var body : some View {
        ZStack {
            VStack (spacing: 0.0) {
                ForEach(0 ..< GameConfig.numberOfRows, id:\.self) {
                    y in
                    HStack (spacing: 0.0) {
                        ForEach(0 ..< GameConfig.numberOfColumns, id:\.self) {
                            x in
                            Button(
                                action: {
                                    self.flip(x, y)
                                    self.printGrid()
                                    print("isWinner=\(self.isWinner())")
                            }) {
                                ButtonView(isOn: self.gameGrid[x + (y * GameConfig.numberOfColumns)])
                            }
                        }
                    }
                }
            }
            // splash screen
            ZStack {
                Color.systemBackground.edgesIgnoringSafeArea(.all)
                VStack {
                    Text("Merlin's MEGA Square")
                    //Image("MerlinsMagicSquare")
                    //    .resizable()
                    //    .frame(width:(400*0.7), height: (135*0.7))
                    //    .padding(.bottom, Screen.height/5)
                }
                //Spacer()
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.showSplash = false
                    self.restoreGame()
                }
            }
            .opacity(self.showSplash ? 1.0 : 0.0)
            .animation(.default)
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}