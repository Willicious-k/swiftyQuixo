//
//  ViewController.swift
//  swiftyQuixo
//
//  Created by 김성종 on 2018. 3. 23..
//  Copyright © 2018년 Willicious-k. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
  // MARK: Data Properties
  var soldierViews: [[SoldierView]] = []
  var soldiers: [[Soldier]] = []
  
  //MARK: GamePlay Properties
  var gameController: GameController = GameController()
  var currentPlayer: Soldier.SoldierSide = .none
  var currentSelectedCell: SoldierView!
  var targetMovedCell: SoldierView!
  
  // MARK: drawable Properties
  @IBOutlet weak var board: UIView!
  var boardWidth: CGFloat = 0
  var boardHeight: CGFloat = 0
  var cellWidth: CGFloat = 0
  var cellHeight: CGFloat = 0
  var cellSize: CGSize = CGSize()
  
  // MARK:- LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    gameController.gameViewController = self
    
    // manually draw board
    calculateSizes()
    drawBoard()
    
    // connect views with data
    soldiers = gameController.makeSoldiers(boardFrame: board.frame)
    for i in 0..<5 {
      for j in 0..<5 {
        soldierViews[i][j].data = soldiers[i][j]
      }
    }
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    //Game Start animation here
    gameController.startTurn()
  }
  
  //MARK:- drawing helpers
  private func calculateSizes() {
    boardWidth = board.frame.width
    boardHeight = board.frame.height
    
    cellWidth = boardWidth / 5
    cellHeight = boardHeight / 5
    cellSize = CGSize(width: cellWidth, height: cellHeight)
  }
  
  private func drawBoard() {
    for i in 0..<5 {
      soldierViews.append([])
      for j in 0..<5 {
        //MARK: 타기종 여백 왜 이러냐
        let targetCell = SoldierView(frame: CGRect(x: CGFloat(i)*cellWidth + CGFloat(i+1)*6.2,
                                                   y: CGFloat(j)*cellHeight + CGFloat(j+1)*6.2,
                                                   width: cellWidth,
                                                   height: cellHeight))
        targetCell.delegate = self
        soldierViews[i].append(targetCell)
        board.addSubview(targetCell)
      }
    }
  }
  
  //MARK:- gamePlay
  func makeActive(for player: Soldier.SoldierSide) {
    for i in 0..<5 {
      for j in 0..<5 {
        soldierViews[i][j].makeActive(player: player)
      }
    }
    currentPlayer = player
  }
  
  func makeDeactive() {
    for i in 0..<5 {
      for j in 0..<5 {
        if (soldierViews[i][j] != currentSelectedCell) {
          soldierViews[i][j].backgroundColor = UIColor(red: 168 / 255, green: 133 / 255, blue: 83 / 255, alpha: 1.0)
          soldierViews[i][j].layer.borderColor = UIColor(red: 168 / 255, green: 133 / 255, blue: 83 / 255, alpha: 1.0).cgColor
        }
        // user lose tap control here
        soldierViews[i][j].tapRecognizer.removeTarget(soldierViews[i][j], action: #selector(soldierViews[i][j].selectCell(_:)))
        soldierViews[i][j].removeGestureRecognizer(soldierViews[i][j].tapRecognizer)
      }
    }
    displayCross(for: currentSelectedCell)
  }
  
  func displayCross(for cell: SoldierView) {
    for i in 0..<5 {
      soldierViews[i][cell.data.location.1].backgroundColor = UIColor(red: 188 / 255, green: 143 / 255, blue: 143 / 255, alpha: 1.0)
      soldierViews[i][cell.data.location.1].layer.borderColor = UIColor(red: 188 / 255, green: 143 / 255, blue: 143 / 255, alpha: 1.0).cgColor
      if (i != cell.data.location.0 && (i == 0 || i == 4)) {
        soldierViews[i][cell.data.location.1].backgroundColor = UIColor(red: 255 / 255, green: 248 / 255, blue: 220 / 255, alpha: 1.0)
        soldierViews[i][cell.data.location.1].layer.borderColor = UIColor(red: 255 / 255, green: 248 / 255, blue: 220 / 255, alpha: 1.0).cgColor
        soldierViews[i][cell.data.location.1].makeTargetActive()
      }
    }
    for j in 0..<5 {
      soldierViews[cell.data.location.0][j].backgroundColor = UIColor(red: 188 / 255, green: 143 / 255, blue: 143 / 255, alpha: 1.0)
      soldierViews[cell.data.location.0][j].layer.borderColor = UIColor(red: 188 / 255, green: 143 / 255, blue: 143 / 255, alpha: 1.0).cgColor
      if (j != cell.data.location.1 && (j == 0 || j == 4)) {
        soldierViews[cell.data.location.0][j].backgroundColor = UIColor(red: 255 / 255, green: 248 / 255, blue: 220 / 255, alpha: 1.0)
        soldierViews[cell.data.location.0][j].layer.borderColor = UIColor(red: 255 / 255, green: 248 / 255, blue: 220 / 255, alpha: 1.0).cgColor
        soldierViews[cell.data.location.0][j].makeTargetActive()
      }
    }
  }
  
  func reloadData() {
    for i in 0..<5 {
      for j in 0..<5 {
        soldierViews[i][j].data = soldiers[i][j]
      }
    }
    gameController.startTurn()
  }
  
  func finishGame(winner: Soldier.SoldierSide) {
    
  }

}

//MARK: cell selected delegate
extension GameViewController: SoldierViewDelegate {
  // MARK: maybe Multiple Select filter is required??
  func selectedCell(_ sender: SoldierView) {
    if (sender.data.isSelected == true) {
      sender.face.text = sender.faceString[Soldier.SoldierSide.none.rawValue]
      sender.data.isSelected = false
      currentSelectedCell = nil
    } else { // false, make selection
      sender.face.text = sender.faceString[currentPlayer.rawValue]
      sender.backgroundColor = .orange
      sender.layer.borderColor = UIColor.orange.cgColor
      sender.data.isSelected = true
      currentSelectedCell = sender
    }
    makeDeactive()
  }
  
  func selectedTarget(_ sender: SoldierView) {
    targetMovedCell = sender
    
    currentSelectedCell.face.text = sender.faceString[Soldier.SoldierSide.none.rawValue]
    
    for i in 0..<5 {
      for j in 0..<5 {
        soldierViews[i][j].backgroundColor = .white
        soldierViews[i][j].layer.borderColor = UIColor.black.cgColor
      }
    }
    
    gameController.playerMoved(from: currentSelectedCell.data, to: targetMovedCell.data)
  }
}
