//
//  YoutubeTestVC.swift
//  Concertrip
//
//  Created by 양어진 on 24/12/2018.
//  Copyright © 2018 양어진. All rights reserved.
//

import UIKit
import YouTubePlayer_Swift

class YoutubeTestVC: UIViewController {
    
    @IBOutlet var videoPlayer: YouTubePlayerView!

    override func viewDidLoad() {
        super.viewDidLoad()

        videoPlayer.loadVideoID("nM0xDI5R50E")
        
    }
}
