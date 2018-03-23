//
//  MenuViewController.swift
//  swiftyQuixo
//
//  Created by 김성종 on 2018. 3. 23..
//  Copyright © 2018년 Willicious-k. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    // test script
    override func viewDidLoad() {
      super.viewDidLoad()
      let testCell = SoldierView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
      self.view.addSubview(testCell)
    }
}

// MARK: Segues
extension MenuViewController {
  @IBAction func forRewind(_ sender: UIStoryboardSegue) {
  }
}
