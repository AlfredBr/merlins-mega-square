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
    @State private var moveNumber = 0
    @State private var difficultySelection :Int? = 0
    @State private var showSplash = true
    @State private var isGameOver = false
    @State private var showSettingsView = false
    @State private var colorIndex = 0

    let rowOptions : [String] = ["3", "5", "7", "9", "11", "13"]
    let gameConfig = GameConfig()

    func restoreGame() {
        loadGame()

        if moveNumber == 0 {
            randomize()
            saveGame()
        }
    }
    
    func randomize() {
        for i in 0 ..< GameConfig.gridSize {
            gameGrid[i] = false;
        }
        for _ in 0 ..< 100 {
            let x = Int.random(in: 0 ..< GameConfig.numberOfColumns)
            let y = Int.random(in: 0 ..< GameConfig.numberOfRows)
            flip(x, y)
        }
        moveNumber = 0
        colorIndex = GameConfig.getColorIndex()
        saveGame()
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
    
    func printGrid() {
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
        UserDefaults.standard.set(moveNumber, forKey: "moveNumber")
        UserDefaults.standard.set(gameGrid, forKey: "gameGrid")
    }
    
    func loadGame() {
        moveNumber = UserDefaults.standard.integer(forKey: "moveNumber")
        gameGrid = UserDefaults.standard.array(forKey: "gameGrid") as? [Bool] ?? [Bool](repeating: false, count: GameConfig.gridSize)
    }
    
    func isFilled(_ x: Int, _ y : Int) -> Bool {
        return self.gameGrid[x + (y * GameConfig.numberOfColumns)]
    }
    
    func isWinner() -> Bool {
        return gameGrid.allSatisfy({$0 == gameGrid.first})
    }
    
    var splashScreenView: some View {
        ZStack {
            Color.systemBackground.edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                Image("MerlinsMegaSquare (Phone)")
                Spacer()
                Button("Privacy Policy") {
                    if let url = URL(string: "https://raw.githubusercontent.com/AlfredBr/merlins-mega-square/master/PRIVACY.md")
                    {
                        UIApplication.shared.open(url)
                    }
                }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.showSplash = false
                self.restoreGame()
            }
        }
        .opacity(self.showSplash ? 1.0 : 0.0)
        .animation(.default)
    }
    
    var settingsView : some View {
        ZStack {
            Color.systemBackground.edgesIgnoringSafeArea(.all)
            VStack (spacing: 0.0) {
                HeaderView(showSettingsView: $showSettingsView)
                Spacer()
                SimplePickerView(prompt:"Choose number of rows", options: rowOptions, selectedIndex: $difficultySelection)
                Button(action: {
                    self.randomize()
                    self.showSettingsView = false
                }){
                    Text("Start New Game")
                        .font(.title)
                        .padding(.vertical, 5).padding(.horizontal, 8)
                        .background(Color.blue)
                        .foregroundColor(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 8.0))
                }
                Spacer()
                Button(action: {
                    self.showSettingsView = false
                }){
                    Text("Resume Game")
                        .font(.title)
                        .padding(.vertical, 5).padding(.horizontal, 8)
                        .background(Color.blue)
                        .foregroundColor(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 8.0))
                }
                Spacer()
            }
        }
        .opacity(self.showSettingsView ? 1.0 : 0.0)
        .animation(.default)
    }
    
    var playFieldView : some View {
        ZStack {
            Color.systemBackground.edgesIgnoringSafeArea(.all)
            VStack (spacing: 0.0) {
                HeaderView(showSettingsView: $showSettingsView)
                Spacer()
                ForEach(0 ..< GameConfig.numberOfRows, id:\.self) {
                    y in
                    HStack (spacing: 0.0) {
                        ForEach(0 ..< GameConfig.numberOfColumns, id:\.self) {
                            x in
                            Button(
                                action: {
                                    self.flip(x, y)
                                    self.printGrid()
                                    self.moveNumber += 1
                                    self.isGameOver = self.isWinner()
                                    if (self.isGameOver) { self.moveNumber = 0 }
                                    self.saveGame()
                                    //print("moveNumber=\(self.moveNumber), isWinner=\(self.isWinner())")
                            }) {
                                ButtonView(isFilled: self.isFilled(x, y), colorIndex: self.colorIndex)
                            }
                        }
                    }
                }
                Spacer()
            }
        }
    }
    
    var body : some View {
        ZStack {
            playFieldView
            splashScreenView
            settingsView
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
