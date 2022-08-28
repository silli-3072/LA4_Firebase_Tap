//
//  ViewController.swift
//  Firebase_Tap
//
//  Created by 春田実利 on 2022/08/23.
//

import UIKit
import Firebase
import FirebaseFirestore

class ViewController: UIViewController {
    
    let firestore = Firestore.firestore()
    
    // タップ数を表示するLabelの変数を準備する
    @IBOutlet var countLabel: UILabel!
    // TAPボタンの変数を準備する
    @IBOutlet var tapButton: UIButton!
    // タップを数える変数を準備する
    var tapCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tapButton.layer.cornerRadius = 125
        
        firestore.collection("counts").document("share").addSnapshotListener { snapshot, error in
            if error != nil {
                print("エラーが発生しました")
                print(error)
                return
            }
            let data = snapshot?.data()
            if data == nil {
                print("データがありません")
                return
            }
            let count = data!["count"] as? Int
            if count == nil {
                print("countという対応する値がありません")
                return
            }
            self.tapCount = count!
            self.countLabel.text = String(count!)
        }
    }
    // TAPボタンがタップされたときに
    @IBAction func tapTapButton() {
        // タップを数える変数にプラス1する
        tapCount += 1
        // タップされた数をLabelに反映する
        countLabel.text = String(tapCount)
        
        firestore.collection("counts").document("share").setData(["count": tapCount])
    }
    
}


