//
//  SimplePlayer.swift
//  MusicPlayer
//
//  Created by leejungchul on 2021/02/24.
//

import Foundation
import AVFoundation

class SimplePlayer {
    // 싱글톤 만들기, 왜만드는가?
    static let shared = SimplePlayer()
    
    private let player = AVPlayer()
    
    private let trackManager:TrackManager = TrackManager()
    
    var nowPlayingIdx: Int?
    
    var currentTime: Double {
        // CurrentTime 구하기
        return player.currentItem?.currentTime().seconds ?? 0
    }
    
    var totalDurationTime: Double{
        // totalDurationTime 구하기
        return player.currentItem?.duration.seconds ?? 0
    }
    
    var isPlaying: Bool {
        // isPlaying 구하기 (extension으로 구현)
        return player.isPlaying
    }
    
    var currentItem: AVPlayerItem?{
        // currentItem 구하기
        return player.currentItem
    }
    
    init() {
        
    }
    
    func pause(){
        // 일시정지 구현
        player.pause()
    }
    
    func play(at index: Int) {
        // 재생 구현
        player.play()
    }
    func seek(to time: CMTime) {
        // 탐색 구현
        player.seek(to: time)
    }
    func forward(at idx:Int){
        // 다음곡 구현
        self.nowPlayingIdx = idx
        let item = trackManager.tracks[idx]
        replaceCurrentItem(with: item, idx: idx)
    }
    func backward(at idx:Int){
        // 이전곡 구현
        self.nowPlayingIdx = idx
        let item = trackManager.tracks[idx]
        replaceCurrentItem(with: item, idx: idx)
        
    }
    func replaceCurrentItem(with item:AVPlayerItem?, idx:Int?) {
        // replaceCurrentItem 구현 들어오는 아이템은 바꿈
        player.replaceCurrentItem(with: item)
        self.nowPlayingIdx = idx
        print(self.nowPlayingIdx)
    }
    func addPeriodicTimeObserver(forInterval: CMTime, queue: DispatchQueue?, using: @escaping (CMTime) ->Void) {
        player.addPeriodicTimeObserver(forInterval: forInterval, queue: queue, using: using)
    }
}
