//
//  ViewController.swift
//  2017_11_10
//
//  Created by 石田一馬 on 2017/11/10.
//  Copyright © 2017年 HAL. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var countDownLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    
    var audioPlayerInstance : AVAudioPlayer! = nil  // 再生するサウンドのインスタンス
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let image = UIImage(named: "start.png")
        let image2 = UIImage(named: "stop.png")
        
        imageView.image = image
        imageView2.image = image2
        
        imageView.isUserInteractionEnabled = true
        imageView2.isUserInteractionEnabled = true
        
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ViewController.imageViewTapped(_:))))
        imageView2.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ViewController.imageViewTapped2(_:))))
        
        let settings = UserDefaults.standard
        
        settings.register(defaults: ["myKey":10])
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        count = 0
        _ = displayUpdate()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var timer : Timer?
    var count = 0
    
    @objc func imageViewTapped(_ sender: UITapGestureRecognizer) {
        print("start")
        //タイマー処理
        // サウンドファイルのパスを生成
        let soundFilePath = Bundle.main.path(forResource: "pi", ofType: "mp3")!
        let sound:URL = URL(fileURLWithPath: soundFilePath)
        // AVAudioPlayerのインスタンスを作成
        do {
            audioPlayerInstance = try AVAudioPlayer(contentsOf: sound, fileTypeHint:nil)
            audioPlayerInstance.play()
        } catch {
            print("AVAudioPlayerインスタンス作成失敗")
        }
        // バッファに保持していつでも再生できるようにする
        audioPlayerInstance.prepareToPlay()
        
        if let nowTimer = timer{
            
            if nowTimer.isValid == true{
                return
            }
            
        }
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector:
            #selector(self.timerInterrupt(_:)), userInfo: nil, repeats: true)
    }
    
    @objc func imageViewTapped2(_ sender: UITapGestureRecognizer) {
        print("stop")
        audioPlayerInstance.stop()
        if let nowTimer = timer{
            if nowTimer.isValid == true{
                nowTimer.invalidate()
            }
        }
    }
    
    @objc func timerInterrupt(_ timer:Timer){
        count += 1
        if displayUpdate() <= 0{
            count = 0
            timer.invalidate()
        }
    }
    
    func displayUpdate() -> Int{
        let settings = UserDefaults.standard
        let timerValue = settings.integer(forKey: "myKey")
        let remainCount = Class3.displayUpdate3(timerValue:timerValue,count:count)
        countDownLabel.text = "\(remainCount) seconds left"
        //カウント0を判定
        if(remainCount == 0){
            //タイマー処理
            // サウンドファイルのパスを生成
            let soundFilePath = Bundle.main.path(forResource: "aram", ofType: "mp3")!
            let sound:URL = URL(fileURLWithPath: soundFilePath)
            // AVAudioPlayerのインスタンスを作成
            do {
                audioPlayerInstance = try AVAudioPlayer(contentsOf: sound, fileTypeHint:nil)
                audioPlayerInstance.play()
            } catch {
                print("AVAudioPlayerインスタンス作成失敗")
            }
            // バッファに保持していつでも再生できるようにする
            audioPlayerInstance.prepareToPlay()
        }
        return remainCount
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "goSetting"){
            if let nowTimer = timer{
                if nowTimer.isValid == true{
                    nowTimer.invalidate()
                }
            }
        }
    }
    

}

