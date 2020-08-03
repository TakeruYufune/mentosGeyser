//
//  SubViewController.swift
//  mentosGeyser
//
//  Created by Takeru Yufune on 2020/08/04.
//  Copyright © 2020 Takeru Yufune. All rights reserved.
//

import UIKit
import Lottie

class SubViewController: UIViewController {
    
    //Lottie用
    private var animationView: AnimationView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Lottie------------------------------
            animationView = .init(name: "splash2")
            
            animationView!.frame = view.bounds
            //animationView!.contentMode = .scaleAspectFit
            animationView!.loopMode = .loop
            animationView!.animationSpeed = 2.5
            view.addSubview(animationView!)
            animationView!.play()
            
        //------------------------------------
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
