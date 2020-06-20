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
    @State private var difficulty :Int = 5
    @State private var showSplash = true
    @State private var isGameOver = false
    @State private var showSettingsView = false
    @State private var colorIndex = 0
    @State private var numberOfRows = GameConfig.numberOfRows

    @Environment(\.colorScheme) var colorScheme
    
    let rowOptions : [String] = ["1", "3", "5", "7", "9", "11", "13"]
    let gameConfig = GameConfig()

    func restoreGame() {
        loadGame()
        print("moveNumber=\(moveNumber)")
        if moveNumber == 0 {
            randomize(self.difficulty)
        }
    }
    
    func randomize(_ difficulty : Int) {
        print("difficulty=\(difficulty)")
        print("new number of rows=\(rowOptions[difficulty])")

        numberOfRows = Int(rowOptions[difficulty]) ?? 13

        for i in 0 ..< GameConfig.gridSize {
            gameGrid[i] = false;
        }
        for _ in 0 ..< 100 {
            let x = Int.random(in: 0 ..< GameConfig.numberOfColumns)
            let y = Int.random(in: 0 ..< numberOfRows)
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
           y >= numberOfRows {
            return
        }
        
        let p = x + (y * GameConfig.numberOfColumns)
        gameGrid[p].toggle()
    }
    
    func printGrid() {
        for y in 0 ..< numberOfRows {
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
        UserDefaults.standard.set(difficulty, forKey: "difficulty")
    }
    
    func loadGame() {
        moveNumber = UserDefaults.standard.integer(forKey: "moveNumber")
        gameGrid = UserDefaults.standard.array(forKey: "gameGrid") as? [Bool] ?? [Bool](repeating: false, count: GameConfig.gridSize)
        difficulty = UserDefaults.standard.integer(forKey: "difficulty")
    }
    
    func isFilled(_ x: Int, _ y : Int) -> Bool {
        return self.gameGrid[x + (y * GameConfig.numberOfColumns)]
    }
    
    func isWinner() -> Bool {
        let section = gameGrid.prefix(GameConfig.numberOfColumns * numberOfRows)
        print(GameConfig.numberOfColumns)
        print(numberOfRows)
        print(section.count)
        return section.allSatisfy({$0 == gameGrid.first})
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
            VStack (spacing: 40.0) {
                HeaderView(showSettingsView: $showSettingsView)
                Spacer()
                Button(action: {
                    self.randomize(self.difficulty)
                    self.showSettingsView = false
                }){
                    Image("Shuffle")
                        .resizable(capInsets: EdgeInsets(top: 0.0,
                                                         leading: 0.0,
                                                         bottom: 0.0,
                                                         trailing: 0.0),
                                   resizingMode: .stretch)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: Screen.width/1.5)
                        .background((colorScheme == .dark ? Color.white : Color.black).opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: 8.0))
                }

                Button(action: {
                    self.difficulty = 0
                    self.randomize(self.difficulty)
                    self.showSettingsView = false
                }){
                    Image("StartOver")
                        .resizable(capInsets: EdgeInsets(top: 0.0,
                                                         leading: 0.0,
                                                         bottom: 0.0,
                                                         trailing: 0.0),
                                   resizingMode: .stretch)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: Screen.width/1.5)
                        .background((colorScheme == .dark ? Color.white : Color.black).opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: 8.0))
                }

                Button(action: {
                    self.showSettingsView = false
                }){
                    Image("GoBack")
                        .resizable(capInsets: EdgeInsets(top: 10.0,
                                                         leading: 0.0,
                                                         bottom: 0.0,
                                                         trailing: 0.0),
                                   resizingMode: .stretch)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: Screen.width/1.5)
                        .background((colorScheme == .dark ? Color.white : Color.black).opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: 8.0))
                    }
                Spacer()
            }
        }
        .opacity(self.showSettingsView ? 1.0 : 0.0)
        .animation(.default)
    }
    
    var winnerView : some View {
        ZStack {
            Color.systemBackground.edgesIgnoringSafeArea(.all)
            VStack (spacing: 0.0) {
                HeaderView(showSettingsView: $showSettingsView)
                Spacer()
                Text("Winner").font(.title)
                Spacer()
            }
        }
        .opacity(self.isGameOver ? 1.0 : 0.0)
        .animation(.default)
    }
    
    private func createButton(_ x: Int, _ y: Int, _ colorIndex: Int) -> Button<ButtonView> {
        return Button(
            action: {
                self.flip(x, y)
                //self.printGrid()
                self.moveNumber += 1
                self.isGameOver = self.isWinner()
                if (self.isGameOver) { self.moveNumber = 0 }
                self.saveGame()
                print("moveNumber=\(self.moveNumber), isGameOver=\(self.isGameOver)")
        }) {
            ButtonView(isFilled: self.isFilled(x, y), colorIndex: colorIndex)
        }
    }
    
    var playFieldView : some View {
        ZStack {
            Color.systemBackground.edgesIgnoringSafeArea(.all)
            VStack (spacing: 0.0) {
                HeaderView(showSettingsView: $showSettingsView)
                Spacer()
                ForEach(0 ..< numberOfRows, id:\.self) {
                    y in
                    HStack (spacing: 0.0) {
                        ForEach(0 ..< GameConfig.numberOfColumns, id:\.self) {
                            x in
                            self.createButton(x, y, self.colorIndex)
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
            winnerView
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
