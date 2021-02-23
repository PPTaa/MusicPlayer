//
//  PlayerViewController.swift
//  MusicPlayer
//
//  Created by leejungchul on 2021/02/23.
//

import Foundation
import UIKit

class PlayerViewController: UIViewController {
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    
    @IBOutlet weak var timeSlider: UISlider!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var totalDurationLabel: UILabel!
}
