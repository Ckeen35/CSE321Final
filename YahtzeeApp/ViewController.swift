//
//  ViewController.swift
//  YahtzeeApp
//
//  Created by user218013 on 5/8/22.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {
    // helper variables
    var finalScore = 0;
    var turnCount = 1;
    var rollCount = 1;
    var upperScores:[Int] = [0, 0, 0, 0, 0, 0, 0];
    var lowerScores:[Int] = [0, 0, 0, 0, 0, 0, 0, 0];
    // dice array in the format [dice value, selected?]
    // NOTE: for selected?, 0 = not selected, 1 = selected
    // if a die is not selected it is rolled again, unless the rollCount = 3
    var dice:[[Int]] = [[1, 0], [1, 0], [1, 0], [1, 0], [1, 0]]
    
    
    // IBOutlets for dice
    @IBOutlet weak var Die1: UIButton!
    @IBOutlet weak var Die2: UIButton!
    @IBOutlet weak var Die3: UIButton!
    @IBOutlet weak var Die4: UIButton!
    @IBOutlet weak var Die5: UIButton!
    @IBOutlet weak var RollBtn: UIButton!
    
    // IBOutlets for scoring buttons
    @IBOutlet weak var Score1sBtn: UIButton!
    @IBOutlet weak var Score2sBtn: UIButton!
    @IBOutlet weak var Score3sBtn: UIButton!
    @IBOutlet weak var Score4sBtn: UIButton!
    @IBOutlet weak var Score5sBtn: UIButton!
    @IBOutlet weak var Score6sBtn: UIButton!
    @IBOutlet weak var threeOfAKindBtn: UIButton!
    @IBOutlet weak var FourOfAKindBtn: UIButton!
    @IBOutlet weak var FullHouseBtn: UIButton!
    @IBOutlet weak var SmallStraightBtn: UIButton!
    @IBOutlet weak var LargeStraightBtn: UIButton!
    @IBOutlet weak var YahtzeeBtn: UIButton!
    @IBOutlet weak var ChanceBtn: UIButton!
    @IBOutlet weak var BonusYahtzeeBtn: UIButton!
    
    // IBOutlets for displaying scores
    @IBOutlet weak var UpperSectionScoreLabel: UILabel!
    @IBOutlet weak var LowerSectionScoreLabel: UILabel!
    @IBOutlet weak var TotalScoreLabel: UILabel!
    
    // other connections
    @IBOutlet weak var NextTurnBtn: UIButton!
    @IBOutlet weak var TurnCounter: UILabel!
    // calculate scores for each section
    func totalUpper() -> Int {
        var result = 0;
        for i in 0...5 {
            result += upperScores[i];
        }
        return result;
    }
    
    func totalLower() -> Int {
        var result = 0;
        for i in 0...7 {
            result += lowerScores[i];
        }
        return result;
    }
    
    func totalScore() -> Int {
        return totalUpper() + totalLower();
    }
    
    // check what the longest sequence in the dice roll is
    func longestSequence() -> Int {
        let diceNums:[Int] = [dice[0][0], dice[1][0], dice[2][0], dice[3][0], dice[4][0]];
        var longestStreak = 0;
        
        for die in diceNums {
            var currentNum = die;
            var currentStreak = 1;
            while (diceNums.contains(currentNum + 1)) {
                currentNum += 1;
                currentStreak += 1;
            }
            longestStreak = max(longestStreak, currentStreak);
        }
        return longestStreak;
    }
    
    // roll single die
    func rollDie() -> Int {
        let num = Int.random(in: 1..<7);
        return num;
    }
    
    func numEach() -> Array<Int> {
        var numEach:[Int] = [0, 0, 0, 0, 0, 0];
        for i in 0...4 {
            if (dice[i][0] == 1) {
                numEach[0] += 1;
            }
            if (dice[i][0] == 2) {
                numEach[1] += 1;
            }
            if (dice[i][0] == 3) {
                numEach[2] += 1;
            }
            if (dice[i][0] == 4) {
                numEach[3] += 1;
            }
            if (dice[i][0] == 5) {
                numEach[4] += 1;
            }
            if (dice[i][0] == 6) {
                numEach[5] += 1;
            }
        }
        return numEach;
    }
    
    // roll all dice
    @IBAction func rollDice(_ sender: UIButton) {
        if (turnCount > 13){
            return;
        }
        if (rollCount > 3){
            return;
        }
        if (dice[0][1] == 0){
            dice[0][0] = Int(rollDie());
            Die1.setTitle(String(dice[0][0]), for: .normal);
        }
        if (dice[1][1] == 0){
            dice[1][0] = Int(rollDie());
            Die2.setTitle(String(dice[1][0]), for: .normal);
        }
        if (dice[2][1] == 0){
            dice[2][0] = Int(rollDie());
            Die3.setTitle(String(dice[2][0]), for: .normal);
        }
        if (dice[3][1] == 0){
            dice[3][0] = Int(rollDie());
            Die4.setTitle(String(dice[3][0]), for: .normal);
        }
        if (dice[4][1] == 0){
            dice[4][0] = Int(rollDie());
            Die5.setTitle(String(dice[4][0]), for: .normal)
        }
        rollCount += 1;
        return;
    }
    
    // select dice
    @IBAction func selectDie1(_ sender: UIButton) {
        if (dice[0][1] == 0) {
            dice[0][1] = 1;
            Die1.setTitleColor(UIColor.red, for: .normal);
            return;
        }
        if (dice[0][1] == 1) {
            dice[0][1] = 0;
            Die1.setTitleColor(UIColor.black, for: .normal);
            return;
        }
    }
    @IBAction func selectDie2(_ sender: UIButton) {
        if (dice[1][1] == 0) {
            Die2.setTitleColor(UIColor.red, for: .normal);
            dice[1][1] = 1;
            return;
        }
        if (dice[1][1] == 1) {
            Die2.setTitleColor(UIColor.black, for: .normal);
            dice[1][1] = 0;
            return;
        }
    }
    @IBAction func selectDie3(_ sender: UIButton) {
        if (dice[2][1] == 0) {
            Die3.setTitleColor(UIColor.red, for: .normal);
            dice[2][1] = 1;
            return;
        }
        if (dice[2][1] == 1) {
            Die3.setTitleColor(UIColor.black, for: .normal);
            dice[2][1] = 0;
            return;
        }
    }
    @IBAction func selectDie4(_ sender: UIButton) {
        if (dice[3][1] == 0) {
            Die4.setTitleColor(UIColor.red, for: .normal);
            dice[3][1] = 1;
            return;
        }
        if (dice[3][1] == 1) {
            Die4.setTitleColor(UIColor.black, for: .normal);
            dice[3][1] = 0;
            return;
        }
    }
    @IBAction func selectDie5(_ sender: UIButton) {
        if (dice[4][1] == 0) {
            Die5.setTitleColor(UIColor.red, for: .normal);
            dice[4][1] = 1;
            return;
        }
        if (dice[4][1] == 1) {
            Die5.setTitleColor(UIColor.black, for: .normal);
            dice[4][1] = 0;
            return;
        }
    }
    
    // go to next turn
    @IBAction func goToNextTurn(_ sender: UIButton) {
        dice[0][1] = 0;
        dice[1][1] = 0;
        dice[2][1] = 0;
        dice[3][1] = 0;
        dice[4][1] = 0;
        Die1.setTitleColor(UIColor.black, for: .normal);
        Die2.setTitleColor(UIColor.black, for: .normal);
        Die3.setTitleColor(UIColor.black, for: .normal);
        Die4.setTitleColor(UIColor.black, for: .normal);
        Die5.setTitleColor(UIColor.black, for: .normal);
        if (turnCount == 13){
            finalScore = totalScore();
            let endGameVC = self.storyboard?.instantiateViewController(withIdentifier: "EndGameViewController") as! EndGameViewController;
            self.navigationController?.pushViewController(endGameVC, animated: true);
            self.present(endGameVC, animated: true, completion: nil);
            return;
        } else {
            turnCount += 1;
            rollCount = 1;
            self.rollDice(UIButton());
        }
        TurnCounter.text = String(turnCount);
        return;
    }
    
    // Upper Section Scoring Options
    @IBAction func ScoreOnes(_ sender: UIButton) {
        if (upperScores[0] != 0){
            return;
        }
        var score = 0;
        for i in 0...4 {
            if (dice[i][0] == 1) {
                score += 1;
            }
        }
        upperScores[0] = score;
        UpperSectionScoreLabel.text = String(totalUpper());
        if (totalUpper() > 63) {
            upperScores[6] = 35
        }
        TotalScoreLabel.text = String(totalScore());
        Score1sBtn.backgroundColor = UIColor.gray;
        goToNextTurn(UIButton());
    }
    @IBAction func ScoreTwos(_ sender: UIButton) {
        if (upperScores[1] != 0){
            return;
        }
        var score = 0;
        for i in 0...4 {
            if (dice[i][0] == 2) {
                score += 2;
            }
        }
        upperScores[1] = score;
        UpperSectionScoreLabel.text = String(totalUpper());
        if (totalUpper() > 63) {
            upperScores[6] = 35
        }
        TotalScoreLabel.text = String(totalScore());
        Score2sBtn.backgroundColor = UIColor.gray;
        goToNextTurn(UIButton());
    }
    @IBAction func ScoreThrees(_ sender: UIButton) {
        if (upperScores[2] != 0){
            return;
        }
        var score = 0;
        for i in 0...4 {
            if (dice[i][0] == 3) {
                score += 3;
            }
        }
        upperScores[2] = score;
        UpperSectionScoreLabel.text = String(totalUpper());
        if (totalUpper() > 63) {
            upperScores[6] = 35
        }
        TotalScoreLabel.text = String(totalScore());
        Score3sBtn.backgroundColor = UIColor.gray;
        goToNextTurn(UIButton());
    }
    @IBAction func ScoreFours(_ sender: UIButton) {
        if (upperScores[3] != 0){
            return;
        }
        var score = 0;
        for i in 0...4 {
            if (dice[i][0] == 4) {
                score += 4;
            }
        }
        upperScores[3] = score;
        UpperSectionScoreLabel.text = String(totalUpper());
        if (totalUpper() > 63) {
            upperScores[6] = 35
        }
        TotalScoreLabel.text = String(totalScore());
        Score4sBtn.backgroundColor = UIColor.gray;
        goToNextTurn(UIButton());
    }
    @IBAction func ScoreFives(_ sender: UIButton) {
        if (upperScores[4] != 0){
            return;
        }
        var score = 0;
        for i in 0...4 {
            if (dice[i][0] == 5) {
                score += 5;
            }
        }
        upperScores[4] = score;
        UpperSectionScoreLabel.text = String(totalUpper());
        if (totalUpper() > 63) {
            upperScores[6] = 35
        }
        TotalScoreLabel.text = String(totalScore());
        Score5sBtn.backgroundColor = UIColor.gray;
        goToNextTurn(UIButton());
    }
    @IBAction func ScoreSixes(_ sender: UIButton) {
        if (upperScores[5] != 0){
            return;
        }
        var score = 0;
        for i in 0...4 {
            if (dice[i][0] == 6) {
                score += 6;
            }
        }
        upperScores[5] = score;
        UpperSectionScoreLabel.text = String(totalUpper());
        if (totalUpper() > 63) {
            upperScores[6] = 35
        }
        TotalScoreLabel.text = String(totalScore());
        Score6sBtn.backgroundColor = UIColor.gray;
        goToNextTurn(UIButton());
    }
    
    // Lower Section Scoring Options
    @IBAction func ScoreThreeOfAKind(_ sender: UIButton) {
        if (lowerScores[0] != 0) {
            return;
        }
        let numEa = numEach();
        var score = 0;
        if (numEa.contains(3)){
            score = dice[0][0] + dice[1][0] + dice[2][0] + dice[3][0] + dice[4][0];
        }
        lowerScores[0] = score;
        LowerSectionScoreLabel.text = String(totalLower());
        TotalScoreLabel.text = String(totalScore());
        threeOfAKindBtn.backgroundColor = UIColor.gray;
        goToNextTurn(UIButton());
    }
    @IBAction func ScoreFourOfAKind(_ sender: UIButton) {
        if (lowerScores[1] != 0) {
            return;
        }
        let numEa = numEach();
        var score = 0;
        if (numEa.contains(4)){
            score = dice[0][0] + dice[1][0] + dice[2][0] + dice[3][0] + dice[4][0];
        }
        lowerScores[1] = score;
        LowerSectionScoreLabel.text = String(totalLower());
        TotalScoreLabel.text = String(totalScore());
        FourOfAKindBtn.backgroundColor = UIColor.gray;
        goToNextTurn(UIButton());
    }
    @IBAction func ScoreFullHouse(_ sender: UIButton) {
        if (lowerScores[2] != 0) {
            return;
        }
        let numEa = numEach();
        if (numEa.contains(3) && numEa.contains(2)){
            lowerScores[2] = 25;
            LowerSectionScoreLabel.text = String(totalLower());
            TotalScoreLabel.text = String(totalScore());
        }
        FullHouseBtn.backgroundColor = UIColor.gray;
        goToNextTurn(UIButton());
    }
    @IBAction func ScoreSmallStraight(_ sender: UIButton) {
        if (lowerScores[3] != 0) {
            return;
        }
        var score = 0;
        if (longestSequence() == 4) {
            score = 30;
        }
        lowerScores[3] = score;
        LowerSectionScoreLabel.text = String(totalLower());
        TotalScoreLabel.text = String(totalScore());
        SmallStraightBtn.backgroundColor = UIColor.gray;
        goToNextTurn(UIButton());
    }
    @IBAction func ScoreLargeStraight(_ sender: UIButton) {
        if (lowerScores[4] != 0) {
            return;
        }
        var score = 0;
        if (longestSequence() == 5) {
            score = 40;
        }
        lowerScores[4] = score;
        LowerSectionScoreLabel.text = String(totalLower());
        TotalScoreLabel.text = String(totalScore());
        LargeStraightBtn.backgroundColor = UIColor.gray;
        goToNextTurn(UIButton());
    }
    @IBAction func ScoreYahtzee(_ sender: UIButton) {
        if (lowerScores[5] != 0) {
            return;
        }
        let numEa = numEach();
        var score = 0;
        if (numEa.contains(5)) {
            score = 100;
        }
        lowerScores[5] = score;
        LowerSectionScoreLabel.text = String(totalLower());
        TotalScoreLabel.text = String(totalScore());
        YahtzeeBtn.backgroundColor = UIColor.gray;
        goToNextTurn(UIButton());
    }
    @IBAction func ScoreChance(_ sender: UIButton) {
        if (lowerScores[6] != 0) {
            return;
        }
        let score = dice[0][0] + dice[1][0] + dice[2][0] + dice[3][0] + dice[4][0];
        lowerScores[6] = score;
        LowerSectionScoreLabel.text = String(totalLower());
        TotalScoreLabel.text = String(totalScore());
        ChanceBtn.backgroundColor = UIColor.gray;
        goToNextTurn(UIButton());
    }
    @IBAction func ScoreBonusYahtzee(_ sender: UIButton) {
        if (lowerScores[5] == 0) {
            return;
        }
        let numEa = numEach();
        var score = 0;
        if (numEa.contains(5)) {
            score = 100;
        }
        lowerScores[7] = score;
        LowerSectionScoreLabel.text = String(totalLower());
        TotalScoreLabel.text = String(totalScore());
        BonusYahtzeeBtn.backgroundColor = UIColor.gray;
        goToNextTurn(UIButton());
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

