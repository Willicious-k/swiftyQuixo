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
  var sessionController: SessionController = SessionController()
  
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
    
    // manually setup game components
    makeSoldiers()
    
    // manually draw board
    calculateSizes()
    drawBoard()
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
        // inject SoldierData here
        targetCell.data = soldiers[i][j]
        
        soldierViews[i].append(targetCell)
        board.addSubview(targetCell)
      }
    }
  }
  
  private func makeSoldiers(){
    for i in 0..<5 {
      soldiers.append([])
      for j in 0..<5 {
        let targetSoldier = Soldier(location: (i, j), side: .none)
        soldiers[i].append(targetSoldier)
      }
    }
  }
}
