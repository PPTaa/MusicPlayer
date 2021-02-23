//
//  TrackCollectionHeaderView.swift
//  MusicPlayer
//
//  Created by leejungchul on 2021/02/23.
//

import Foundation
import UIKit
import AVFoundation

class TrackCollectionHeaderView: UICollectionReusableView {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var item: AVPlayerItem?
    var tapHandler: ((AVPlayerItem) -> Void)?
    
    override class func awakeFromNib() {
        super.awakeFromNib()
//        thumbnailImageView.layer.cornerRadius = 4
    }
    
    func update(with item: AVPlayerItem){
        // 헤더뷰 업데이트
        self.item = item
        guard let track = item.convertToTrack() else { return }
        
        self.thumbnailImageView.image = track.artwork
        self.descriptionLabel.text = "Today Editor's Pick is \(track.artist)' album - \(track.albumName), Let's Listen!"
    }
    @IBAction func cardTapped(_ sender: UIButton){
        // 탭 처리
        guard let todaysItem = item else { return }
        tapHandler?(todaysItem)
    }
    
}
