//
//  TrackCollectionViewCell.swift
//  MusicPlayer
//
//  Created by leejungchul on 2021/02/19.
//

import Foundation
import UIKit

class TrackCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var trackThumbnail: UIImageView!
    @IBOutlet weak var trackTitle: UILabel!
    @IBOutlet weak var trackArtist: UILabel!
    
    // 컬렉션 뷰 셀이 호출 될 때 호출되는 메소드
    override func awakeFromNib() {
        super.awakeFromNib()
        trackThumbnail.layer.cornerRadius = 4
        trackArtist.textColor = UIColor.systemGray2
    }
    
    func updateUI(item: Track?){
        // 곡 정보 표시하기
        guard let track = item else { return }
        trackThumbnail.image = track.artwork
        trackTitle.text = track.title
        trackArtist.text = track.artist
    }
    
    
}
