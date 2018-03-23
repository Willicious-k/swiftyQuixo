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
    gameController.startGameLoop()
  }
  
  //MARK:- helpers
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
  
}

//MARK: selected Noti
extension GameViewController: SoldierViewDelegate {
  func selectedCell(_ sender: SoldierView) {
    if (sender.data.isSelected == true) {
      sender.face.text = sender.faceString[currentPlayer.rawValue]
    } else {
      sender.face.text = sender.faceString[Soldier.SoldierSide.none.rawValue]
    }
  }
}
