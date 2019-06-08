//
//  ViewController.swift
//  OMIKUJI
//
//  Created by 吉田力 on 2019/06/08.
//  Copyright © 2019 吉田力. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {
    var resultAudioPlayer : AVAudioPlayer = AVAudioPlayer()
    
    @IBOutlet weak var stickView: UIView!
    @IBOutlet weak var stickLabel: UILabel!
    @IBOutlet weak var stickHeight: NSLayoutConstraint!
    @IBOutlet weak var stickBottomMargin: NSLayoutConstraint!
    @IBOutlet weak var overView: UIView!
    @IBOutlet weak var bigLabel: UILabel!
    let resultTexts: [String] = [
        "大吉",
        "中吉",
        "小吉",
        "吉",
        "末吉",
        "凶",
        "大凶"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSound()
        // Do any additional setup after loading the view.
    }
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion != UIEvent.EventSubtype.motionShake || overView.isHidden == false{
            //シェイクモーション以外では動作しないようにする。
            
            //UInt32---ランダム関数
            //arc4random_uniform ゼロから引数まで
            //return
            return
        }
        let resultNum = Int( arc4random_uniform(UInt32(resultTexts.count)) )
        stickLabel.text = resultTexts[resultNum]
        
        //一秒の間にアニメーション
        //もし必要ならいい感じでアニメーションするよ
        //アニメーションしたあとの処理はcompletion
        stickBottomMargin.constant = stickHeight.constant * -1
        UIView.animate(withDuration: 1, animations: {
            self.view.layoutIfNeeded()
        },completion:{(finished: Bool) in
            self.bigLabel.text = self.stickLabel.text
            self.overView.isHidden = false
            self.resultAudioPlayer.play()
        })
    }
    
    @IBAction func tapRetryButton(_ sender: Any) {
        overView.isHidden = true
        stickBottomMargin.constant = 0
    }
    func setupSound(){
        if let sound = Bundle.main.path(forResource:"drum", ofType:".mp3"){
            //try! 例外処理
            //
            resultAudioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound))
            resultAudioPlayer.prepareToPlay()
    }
    }
}




