//
//  SoldierView.swift
//  swiftyQuixo
//
//  Created by 김성종 on 2018. 3. 23..
//  Copyright © 2018년 Willicious-k. All rights reserved.
//

import UIKit

protocol SoldierViewDelegate {
  func selectedCell(_ sender: SoldierView)
  func selectedTarget(_ sender: SoldierView)
}

class SoldierView: UIView {
  let faceString: [String] = [" ","✪","★"]
  
  var delegate: GameViewController?
  
  var face: UILabel!
  var tapRecognizer = UITapGestureRecognizer()
  
  // MARK: inits
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.frame = frame
    
    layer.cornerRadius = 28
    layer.borderWidth = 0.5
    layer.borderColor = UIColor(red: 168 / 255, green: 133 / 255, blue: 83 / 255, alpha: 1.0).cgColor
    layer.backgroundColor = UIColor(red: 168 / 255, green: 133 / 255, blue: 83 / 255, alpha: 1.0).cgColor
    
    face = UILabel(frame:CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
    face.textAlignment = .center
    
    addSubview(face)
  }
  
  // MARK: data injection
  var data: Soldier! {
    didSet {
      switch data.side {
      case .none:
        face.text = faceString[0]
      case .p1:
        face.text = faceString[1]
      case .p2:
        face.text = faceString[2]
      }
    }
  }
  
  //MARK: helpers
  func makeActive(player: Soldier.SoldierSide) {
    if isEdge() && (data.side == .none || data.side == player){
      layer.borderColor = UIColor(red: 255 / 255, green: 248 / 255, blue: 220 / 255, alpha: 1.0).cgColor
      self.backgroundColor = UIColor(red: 255 / 255, green: 248 / 255, blue: 220 / 255, alpha: 1.0)
      
      tapRecognizer.addTarget(self, action: #selector(self.selectCell(_:)))
      self.addGestureRecognizer(tapRecognizer)
    }
  }
  
  func makeTargetActive() {
    tapRecognizer.addTarget(self, action: #selector(self.selectTarget(_:)))
    self.addGestureRecognizer(tapRecognizer)
  }
  
  func isEdge() -> Bool {
    if (data.location.0 == 0 || data.location.0 == 4 || data.location.1 == 0 || data.location.1 == 4) {
      return true
    }
    return false
  }
  
  @objc func selectCell(_ sender: UITapGestureRecognizer) {
    delegate?.selectedCell(self)
  }
  
  @objc func selectTarget(_ sender: UITapGestureRecognizer) {
    delegate?.selectedTarget(self)
  }
}
