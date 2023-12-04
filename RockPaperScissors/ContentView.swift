//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Jan Grimm on 04.12.23.
//

import SwiftUI


struct ContentView: View {
    let moves = ["👊", "🤚", "✌️"]
    
    @State private var appMove = Int.random(in: 0..<3)
    @State private var shouldWin = Bool.random()
    
    @State private var score = 0
    @State private var questionCount = 1
    @State private var showingResults = false
    
    var body: some View {
        
        VStack {
            Spacer()
            
            Text("Computer has played")
                .font(.headline)
            
            Text(moves[appMove])
                .font(.system(size: 200))
            
            if shouldWin {
                Text("Which one wins?")
                    .foregroundStyle(.green)
                    .font(.title)
            } else {
                Text("Which one loses?")
                    .foregroundStyle(.red)
                    .font(.title)
            }
            
            HStack {
                ForEach(0..<3) { number in
                    Button(moves[number]) {
                        play(choice: number)
                    }
                    .font(.system(size: 80))
                }
            }
            
            Spacer()
            
            Text("Score: \(score)")
                .font(.subheadline)
            
            Spacer()
        }
        .alert("Game Over", isPresented: $showingResults) {
            Button("Play again", action: reset)
        } message: {
            Text("Your score was \(score)")
        }
    }
    
    func play(choice: Int) {
        let winningMoves = [1, 2, 0]
        let didWin: Bool
        
        if shouldWin {
            didWin = choice == winningMoves[appMove]
        } else {
            didWin = winningMoves[choice] == appMove
        }
        
        if didWin {
            score += 1
        } else {
            score -= 1
        }
        
        if questionCount == 10 {
            showingResults = true
        } else {
            appMove = Int.random(in: 0..<3)
            shouldWin = Bool.random()
            questionCount += 1
        }
    }
    
    func reset(){
        appMove = Int.random(in: 0..<3)
        shouldWin = Bool.random()
        questionCount = 1
        score = 0
    }
}

#Preview {
    ContentView()
}
