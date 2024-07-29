//
//  ViewController.swift
//  Connect 4
//
//  Created by student on 7/18/24.
//

import UIKit

class ViewController: UIViewController {
    var doubleArray: [[Placement]] = Array(repeating: [], count: 7)
    
    var turnCounter = 0
    var currentEmoji: String {
        if currentPlayerNumber == 1 {
            return "🔴"
        } else {
            return "🟡"
        }
    }
    var currentPlayerTitle: String {
        if currentPlayerNumber == 1 {
            return "Yellow is Choosing"
        } else {
            return "Red is Choosing"
        }
    }
    
    var currentPlayerWinner: String {
        if currentPlayerNumber == 1 {
            return "Red Wins!"
        } else {
            return "Yellow Wins!"
        }
    }
    
    var currentPlayerNumber: Int {
        if turnCounter % 2 == 0 {
            return 1
        } else {
            return 2
        }
    }
    
    @IBOutlet weak var currentPlayerWinnerTitle: UILabel!
    
    @IBOutlet weak var playerCurrent: UILabel!
    
    @IBOutlet weak var playAgain: UIButton!
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button6: UIButton!
    @IBOutlet weak var button7: UIButton!
    
    @IBOutlet var button1Placement: [UILabel] = []
    @IBOutlet var button2Placement: [UILabel] = []
    @IBOutlet var button3Placement: [UILabel] = []
    @IBOutlet var button4Placement: [UILabel] = []
    @IBOutlet var button5Placement: [UILabel] = []
    @IBOutlet var button6Placement: [UILabel] = []
    @IBOutlet var button7Placement: [UILabel] = []
    
    @IBAction func button1Action(_ sender: Any) {
        onButtonClick(index: 0, dots: button1Placement)
    }
    
    @IBAction func button2Action(_ sender: Any) {
        onButtonClick(index: 1, dots: button2Placement)
    }
    
    @IBAction func button3Action(_ sender: Any) {
        onButtonClick(index: 2, dots: button3Placement)
    }
    
    @IBAction func button4Action(_ sender: Any) {
        onButtonClick(index: 3, dots: button4Placement)
    }
    
    @IBAction func button5Action(_ sender: Any) {
        onButtonClick(index: 4, dots: button5Placement)
    }
    
    @IBAction func button6Action(_ sender: Any) {
        onButtonClick(index: 5, dots: button6Placement)
    }
    
    @IBAction func button7Action(_ sender: Any) {
        onButtonClick(index: 6, dots: button7Placement)
    }
    
    @IBAction func playAgainAction(_ sender: Any) {
        resetGame()
    }
    
    func onButtonClick(index: Int, dots: [UILabel]) {
        if doubleArray[index].count < 6 && playAgain.isHidden {
            let newPlacement = Placement(emoji: currentEmoji, playerNumber: currentPlayerNumber)
            doubleArray[index].append(newPlacement)
            dots[doubleArray[index].count - 1].text = currentEmoji
            playerCurrent.text = currentPlayerTitle
            dots[doubleArray[index].count - 1].isHidden = false
            checkWinner(index: index)
            turnCounter += 1
        } else {
            print("error")
        }
    }
    
    func checkWinner(index: Int) {
        if checkVertical(index: index) {
            endGame()
        } else if checkHorizontal(index: index) {
            endGame()
        } else if checkDiagonals(index: index) {
            endGame()
        }
    }
    
    // Reset everything
    func endGame() {
        currentPlayerWinnerTitle.text = currentPlayerWinner
        currentPlayerWinnerTitle.isHidden = false
        playAgain.isHidden = false
        playerCurrent.isHidden = true
    }
    
    func resetGame() {
        currentPlayerWinnerTitle.isHidden = true
        playAgain.isHidden = true
        playerCurrent.isHidden = false
        doubleArray = Array(repeating: [], count: 7)
        resetGrid()
    }
    
    func clearDots(dots: [UILabel]) {
        for dot in dots {
            dot.isHidden = true
        }
    }

    func resetGrid() {
        clearDots(dots: button1Placement)
        clearDots(dots: button2Placement)
        clearDots(dots: button3Placement)
        clearDots(dots: button4Placement)
        clearDots(dots: button5Placement)
        clearDots(dots: button6Placement)
        clearDots(dots: button7Placement)
    }
    
    func checkHorizontal(index: Int) -> Bool {
        let verticalIndex = doubleArray[index].count - 1
        
        for i in 0...doubleArray.count - 1 {
            if i >= 3 {
                if checkLeft(verticalIndex: verticalIndex, horizontalIndex: i) {
                    return true
                }
            }
        }
        
        return false
    }
    
    func checkLeft(verticalIndex: Int, horizontalIndex: Int) -> Bool {
        var streak = 0
        var tempHorizontalIndex = horizontalIndex
        
        for _ in 0...3 {
            if tempHorizontalIndex >= 0 && tempHorizontalIndex <= doubleArray.count && doubleArray[tempHorizontalIndex].count - 1 >= verticalIndex && doubleArray[tempHorizontalIndex][verticalIndex].playerNumber == currentPlayerNumber {
                print("H: \(tempHorizontalIndex), V: \(verticalIndex)")
                streak += 1
            } else {
                streak = 0
            }
            
            tempHorizontalIndex -= 1
        }
        
        return streak >= 4
    }
    
    func checkVertical(index: Int) -> Bool {
        var streak = 1
        let array = doubleArray[index]
        var reverseIndex = array.count - 2
        
        if array.count < 4 {
            return false
        }
        
        for _ in 0...2 {
            if array[reverseIndex].playerNumber == currentPlayerNumber {
                streak += 1
            } else {
                streak = 1
            }
            
            reverseIndex -= 1
        }
        
        return streak >= 4
    }
    
    func checkDiagonals(index: Int) -> Bool {
        return checkDiagonalLeftToRight(index: index) || checkDiagonalRightToLeft(index: index)
    }
    
    func checkDiagonalLeftToRight(index: Int) -> Bool {
        let verticalIndex = doubleArray[index].count - 1
        let horizontalIndex = index
        
        var streak = 0
        var i = horizontalIndex
        var j = verticalIndex
        
        while i >= 0 && j >= 0 {
            if doubleArray[i].count > j && doubleArray[i][j].playerNumber == currentPlayerNumber {
                streak += 1
            } else {
                streak = 0
            }
            
            if streak >= 4 {
                return true
            }
            
            i -= 1
            j -= 1
        }
        
        // Reset and check the other direction of this diagonal
        streak = 0
        i = horizontalIndex
        j = verticalIndex
        
        while i < doubleArray.count && j >= 0 {
            if doubleArray[i].count > j && doubleArray[i][j].playerNumber == currentPlayerNumber {
                streak += 1
            } else {
                streak = 0
            }
            
            if streak >= 4 {
                return true
            }
            
            i += 1
            j -= 1
        }
        
        return false
    }
    
    func checkDiagonalRightToLeft(index: Int) -> Bool {
        let verticalIndex = doubleArray[index].count - 1
        let horizontalIndex = index
        
        var streak = 0
        var i = horizontalIndex
        var j = verticalIndex
        
        while i >= 0 && j < doubleArray[i].count {
            if doubleArray[i][j].playerNumber == currentPlayerNumber {
                streak += 1
            } else {
                streak = 0
            }
            
            if streak >= 4 {
                return true
            }
            
            i -= 1
            j += 1
        }
        
        // Reset and check the other direction of this diagonal
        streak = 0
        i = horizontalIndex
        j = verticalIndex
        
        while i < doubleArray.count && j >= 0 {
            if doubleArray[i].count > j && doubleArray[i][j].playerNumber == currentPlayerNumber {
                streak += 1
            } else {
                streak = 0
            }
            
            if streak >= 4 {
                return true
            }
            
            i += 1
            j -= 1
        }
        
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

struct Placement {
    let emoji: String
    let playerNumber: Int
}
