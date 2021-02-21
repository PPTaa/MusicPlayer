//
//  Extension&AVPlayerItem.swift
//  MusicPlayer
//
//  Created by leejungchul on 2021/02/21.
//

import AVFoundation
import UIKit

// 특적 클래스를 확장할때 익스텐션을 사용하여 제작
extension AVPlayerItem {
    func convertToTrack() -> Track? {
        // 곡의 음원의 메타데이터를 가져오는 것
        let metadataList = asset.metadata
        
        var trackTitle: String?
        var trackArtist: String?
        var trackAlbumName: String?
        var trackArtwork: UIImage?
        
        for metadata in metadataList {
            if let title = metadata.title {
                trackTitle = title
            }
            if let artist = metadata.artist {
                trackArtist = artist
            }
            if let albumName = metadata.albumName {
                trackAlbumName = albumName
            }
            if let artwork = metadata.artwork {
                trackArtwork = artwork
            }
        }
        guard let title = trackTitle,
              let artist = trackArtist,
              let albumName = trackAlbumName,
              let artwork = trackArtwork else {
            return nil
        }
        return Track(title: title, artist: artist, albumName: albumName, artwork: artwork)
    }
}
//파일의 메타데이터를 빼와서 변수로 저장하는 익스텐션
extension AVMetadataItem {
    var title: String? {
        guard let key = commonKey?.rawValue, key == "title" else { return nil }
        return stringValue
    }
    var artist: String? {
        guard let key = commonKey?.rawValue, key == "artist" else { return nil }
        return stringValue
    }
    var albumName: String? {
        guard let key = commonKey?.rawValue, key == "albumName" else { return nil }
        return stringValue
    }
    var artwork: UIImage? {
        guard let key = commonKey?.rawValue, key == "artwork", let data = dataValue, let image = UIImage(data: data) else { return nil }
        return image
    }
}

extension AVPlayer {
    // 곡의 재생중 여부에 대한 변수 확장 
    var isPlaying: Bool {
        guard self.currentItem != nil else { return false }
        return self.rate != 0
    }
}
