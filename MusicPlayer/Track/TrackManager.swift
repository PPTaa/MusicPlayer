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
        let tracks = loadTracks()
        self.tracks = tracks
        self.albums = loadAlbums(tracks: tracks)
        self.todayTrack = self.tracks.randomElement()
    }
    
    // 트랙 로드하기
    func loadTracks() -> [AVPlayerItem] {
        //파일을 읽어서 AVPlayerItem 만들기
        let urls = Bundle.main.urls(forResourcesWithExtension: "mp3", subdirectory: nil) ?? []
        
//        var items: [AVPlayerItem] = []
//        for url in urls {
//            let item = AVPlayerItem(url: url)
//            items.append(item)
//        }
        
        let items = urls.map{url -> AVPlayerItem in
            return AVPlayerItem(url: url)
        }
        
        return items
    }
    
    // 인덱스에 맞는 트랙 로드하기
    func track(at index:Int) -> Track? {
        let playerItem = tracks[index]
        // playerItem > track
        let track = playerItem.convertToTrack()
        return track
    }
    
    // 앨범 로딩메소드 구현
    func loadAlbums(tracks: [AVPlayerItem]) -> [Album] {
        
        let trackList: [Track] = tracks.compactMap { $0.convertToTrack() }
        // trackList를 활용하여 딕셔너리 제작
        let albumDics = Dictionary(grouping: trackList, by: { (track) in track.albumName })
        var albums: [Album] = []
        for (key, value) in albumDics {
            let title = key
            let tracks = value
            let album = Album(title: title, tracks: tracks)
            albums.append(album)
        }
        return albums
    }
    
    // 오늘의 트랙 랜덤으로 재 선택
    func loadOtherTodaysTrack(){
        self.todayTrack = self.tracks.randomElement()
        
    }
}
