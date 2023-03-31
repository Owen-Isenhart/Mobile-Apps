//
//  Results.swift
//  Trivia
//
//  Created by Isenhart, Owen E on 2/16/23.
//

import UIKit
class Results : UIViewController{
    var s: String = ""
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var btn: UIButton!
    override func viewDidLoad() {
        label.text = s
        btn.addTarget(self, action: #selector(hit(_:)), for: .touchUpInside)
    }
    @objc func hit(_ sender: UIButton){
        tabBarController?.selectedIndex = 0
        _ = navigationController?.popViewController(animated: true)
    }
    
}
