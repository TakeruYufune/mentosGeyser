//
//  ViewController.swift
//  mentosGeyser
//
//  Created by Takeru Yufune on 2020/08/04.
//  Copyright © 2020 Hack'z inc.   All rights reserved.
//

import UIKit
import CoreMotion
import Lottie

class ViewController: UIViewController{
    
    let motionManager = CMMotionManager()


    @IBOutlet weak var box: UIView!
    
    @IBOutlet weak var accX: UILabel!
    @IBOutlet weak var accY: UILabel!
    @IBOutlet weak var accZ: UILabel!
    @IBOutlet weak var splash: UILabel!
    
    @IBAction func mentosSwitch(_ sender: UISwitch) {
        if sender.isOn{
            mentosAnimate()
        }
    }
    
    @IBOutlet weak var animationView: AnimationView!
    
    var x = 0.0
    var y = 0.0
    var z = 0.0
    var count = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    //Lottie------------------------------
        
        animationView!.frame = view.bounds
        animationView!.contentMode = .scaleAspectFit
        animationView!.animationSpeed = 1.0
        animationView!.play()
        
    //------------------------------------
        
        if motionManager.isAccelerometerAvailable {
            // intervalの設定 [sec]
            motionManager.accelerometerUpdateInterval = 0.05
            // センサー値の取得開始
            motionManager.startAccelerometerUpdates(
                to: OperationQueue.current!,
                withHandler: {(accelData: CMAccelerometerData?, errorOC: Error?) in
                    self.outputAccelData(acceleration: accelData!.acceleration)
            })
        
        }
        
        
    }
    
    private func splashAnimate() {
        UIView.animate(withDuration: 1.0, delay: 0, options: .curveLinear, animations: {
            self.box.frame.origin.y -= 10
        }, completion: nil)
    }
    
    func mentosAnimate() {
        animationView.removeFromSuperview()
        
        var mentosView: AnimationView?
        
        mentosView = .init(name: "mentos")
        mentosView!.frame = view.bounds
        mentosView!.contentMode = .scaleAspectFit
        mentosView!.animationSpeed = 1.5
        view.addSubview(mentosView!)
        mentosView!.play { finished in
            if finished{
                mentosView!.removeFromSuperview()
                self.stopAccelerometer()
                self.performSegue(withIdentifier: "splash", sender: nil)
            }
        }
        
    }
 
 
    
    func outputAccelData(acceleration: CMAcceleration){
        // 加速度センサー [G] 確認用
        /*
        accX.text = String(format: "%06f", acceleration.x)
        accY.text = String(format: "%06f", acceleration.y)
        accZ.text = String(format: "%06f", acceleration.z)
        */
        
        if abs(x - acceleration.x) > 0.3 || abs(y - acceleration.y) > 0.3 ||
        abs(z - acceleration.z) > 0.3{
            //デバッグ用の赤
            //view.backgroundColor = UIColor.red
            
            //shake判定点数を付与
            count += 1
            
            //画面外のboxを動かす
            splashAnimate()
        }
        /* デバッグ用
        else {
            view.backgroundColor = UIColor.white
        }
         */
        
        x = acceleration.x
        y = acceleration.y
        z = acceleration.z
        
        if count == 100{
            //splash.text = "SPLASH!!"
            stopAccelerometer()
            self.performSegue(withIdentifier: "splash", sender: nil)
        }
        
   }
    
    // センサー取得を止める場合
    func stopAccelerometer(){
       if (motionManager.isAccelerometerActive) {
           motionManager.stopAccelerometerUpdates()
       }
   }
    
    
    


}

