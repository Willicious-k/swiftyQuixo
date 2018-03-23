//
//  ViewController.swift
//  swiftyQuixo
//
//  Created by 김성종 on 2018. 3. 23..
//  Copyright © 2018년 Willicious-k. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
  // MARK: Properties
  @IBOutlet weak var board: UIView!
  var cubes: [SoldierView] = []
  var boardWidth: CGFloat = 0
  var boardHeight: CGFloat = 0
  var cubeSize: CGSize = CGSize()
  
//  var boardData
//  var viewCells
  
  // MARK: LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    claculateSizes()
    drawCells()
  }
  
  // MARK: helpers
  func claculateSizes() {
    boardWidth = board.frame.width
    boardHeight = board.frame.height
    
    let cellwidth = boardWidth / 5
    let cellheight = boardHeight / 5
    cubeSize = CGSize(width: cellwidth, height: cellheight)
  }
  
  func drawCells()  {
    var startPoint: CGPoint = CGPoint(x: 0, y: 0)
    for i in 0..<4 {
      for j in 0..<4 {
        let cell = SoldierView(frame: CGRect(origin: startPoint, size: cubeSize))
      }
    }
    
  }
}
