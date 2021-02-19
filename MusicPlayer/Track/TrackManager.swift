//
//  TrackManager.swift
//  MusicPlayer
//
//  Created by leejungchul on 2021/02/19.
//

import Foundation
import UIKit
import AVFoundation

class TrackManager {
    // 프로퍼티들 정의하기 (트랙, 앨범, 오늘의곡)
    var tracks: [AVPlayerItem] = []
    var albums: [Album] = []
    var todayTrack: AVPlayerItem?
    
    // 생성자 정의하기
    init() {
    }
    
    // 트랙 로드하기
    func loadTracks() -> [AVPlayerItem] {
        return []
    }
    
    // 인덱스에 맞는 트랙 로드하기
    func track(at index:Int) -> Track? {
        return nil
    }
    
    // 앨범 로딩메소드 구현
    func loadAlbums(tracks: [AVPlayerItem]) -> [Album] {
        return []
    }
    
    // 오늘의 트랙 랜덤으로 선택
    func loadOtherTodaysTrack(){
        
    }
}
