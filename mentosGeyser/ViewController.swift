//
//  ViewController.swift
//  mentosGeyser
//
//  Created by Takeru Yufune on 2020/08/04.
//  Copyright © 2020 Takeru Yufune. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController{
    
    let motionManager = CMMotionManager()

    @IBOutlet weak var accX: UILabel!
    @IBOutlet weak var accY: UILabel!
    @IBOutlet weak var accZ: UILabel!
    @IBOutlet weak var splash: UILabel!
    
    var x = 0.0
    var y = 0.0
    var z = 0.0
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        let screenWidth = self.view.bounds.width
        let screenHeight = self.view.bounds.height
        
        let testDraw = ObjectDraw(frame: CGRect(x: 0, y: 0,
                       width: screenWidth, height: screenHeight))
        self.view.addSubview(testDraw)
*/
        
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
    
    func outputAccelData(acceleration: CMAcceleration){
        // 加速度センサー [G]
        accX.text = String(format: "%06f", acceleration.x)
        accY.text = String(format: "%06f", acceleration.y)
        accZ.text = String(format: "%06f", acceleration.z)
        
        print(abs(z - acceleration.z))
        
        if abs(x - acceleration.x) > 0.3 || abs(y - acceleration.y) > 0.3 ||
        abs(z - acceleration.z) > 0.3{
            view.backgroundColor = UIColor.red
            //shake判定点数を付与
            count += 1
        } else {
            view.backgroundColor = UIColor.white
        }
        
        x = acceleration.x
        y = acceleration.y
        z = acceleration.z
        
        if count > 100{
            splash.text = "SPLASH!!"
        }
        
   }
    
    // センサー取得を止める場合
    func stopAccelerometer(){
       if (motionManager.isAccelerometerActive) {
           motionManager.stopAccelerometerUpdates()
       }
   }
    
    
    


}

