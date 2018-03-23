//
//  MenuViewController.swift
//  swiftyQuixo
//
//  Created by 김성종 on 2018. 3. 23..
//  Copyright © 2018년 Willicious-k. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
  // testBoard
  @IBOutlet weak var testBoard: UIView!
  
  var testBoardWidth: CGFloat = 0
  var testBoardHeight: CGFloat = 0
  var cellWidth: CGFloat = 0
  var cellHeight: CGFloat = 0
  var cellSize: CGSize = CGSize()
  
  
  // test script
  override func viewDidLoad() {
    super.viewDidLoad()
    calculateSizes()
    drawBoard()
  }
  
  //test helpers
  func calculateSizes() {
    testBoardWidth = testBoard.frame.width
    testBoardHeight = testBoard.frame.height
    
    cellWidth = testBoardWidth / 5
    cellHeight = testBoardHeight / 5
    cellSize = CGSize(width: cellWidth, height: cellHeight)
  }
  
  func drawBoard() {
    for i in 0..<5 {
      for j in 0..<5 {
        //MARK: 여백 왜 이러냐
        let testCell = SoldierView(frame: CGRect(x: CGFloat(i)*cellWidth + CGFloat(i+1)*6.2,
                                                 y: CGFloat(j)*cellHeight + CGFloat(j+1)*6.2,
                                                 width: cellWidth,
                                                 height: cellHeight))
        testBoard.addSubview(testCell)
      }
    }
    
  }
}

// MARK: Segues
extension MenuViewController {
  @IBAction func forRewind(_ sender: UIStoryboardSegue) {
  }
}
