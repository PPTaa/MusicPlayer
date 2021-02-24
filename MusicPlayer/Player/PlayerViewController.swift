//
//  PlayerViewController.swift
//  MusicPlayer
//
//  Created by leejungchul on 2021/02/23.
//

import Foundation
import UIKit
import AVFoundation

class PlayerViewController: UIViewController {
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    
    @IBOutlet weak var timeSlider: UISlider!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var totalDurationLabel: UILabel!
    @IBOutlet weak var playControlButton: UIButton!
    
    // SimplePlayer를 만들고 프로퍼티를 추가
    let simplePlayer = SimplePlayer.shared
    
    var timeObserver: Any?
    var isSeeking: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updatePlayButton()
        updateTime(time: CMTime.zero)
        //timeObserver 구현
        let interval = CMTime(seconds: 1, preferredTimescale: 10) // 1초를 10개로 분할시켜 관찰 > 0.1초 마다 관찰하겠다.
        // dispatchqueue.main > 메인스레드에 0.1초마다 알려줄것
        timeObserver = simplePlayer.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main, using: {time in
            self.updateTime(time: time)
        })
    }
    // 뷰가 나타날때 발생하는 메소드
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateTrackInfo()
        updateTintColor()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // 뷰 나갈때 플레이 중지
        simplePlayer.pause()
        simplePlayer.replaceCurrentItem(with: nil)
    }
    @IBAction func togglePlayButton(_ sender: UIButton) {
        //플레이버튼 토글 구현
        if simplePlayer.isPlaying {
            simplePlayer.pause()
        } else {
            simplePlayer.play()
        }
        updatePlayButton()
    }
    @IBAction func seek(_ sender: UISlider) {
        // 슬라이더를 통한 탐색 구현
        guard let currentItem = simplePlayer.currentItem else { return }
        let position = Double(sender.value) // 0~1 사이의 소수점 값
        let seconds = position * currentItem.duration.seconds // 전체시간에 소수점 값을 곱해 시간으로 바꿈
        let time = CMTime(seconds: seconds, preferredTimescale: 100) // 구한 시간 값을 CMTime으로 캐스팅
        simplePlayer.seek(to: time)
    }
    // 슬라이더를 움직일때
    @IBAction func beginDrag(_ sender: UISlider) {
        isSeeking = true
    }
    // 슬라이더를 움직이는것을 그만할 때
    @IBAction func endDrag(_ sender: UISlider) {
        isSeeking = false
    }
}

extension PlayerViewController {
    // Track info update
    func updateTrackInfo(){
        // 트랙 정보 업데이트
        guard let track = simplePlayer.currentItem?.convertToTrack() else { return }
        thumbnailImageView.image = track.artwork
        titleLabel.text = track.title
        artistLabel.text = track.artist
    }
    
    //Play Button ui update > play/pause
    func updatePlayButton() {
        if simplePlayer.isPlaying {
//            image의 설정을 지정해 줄 수 있음
//            let configuration = UIImage.SymbolConfiguration(pointSize: 40)
//            let image = UIImage(systemName: "pause.fill", withConfiguration: configuration)
            let image = UIImage(systemName: "pause.fill")
            playControlButton.setImage(image, for: .normal)
        } else {
//            image의 설정을 지정해 줄 수 있음
//            let configuration = UIImage.SymbolConfiguration(pointSize: 40)
//            let image = UIImage(systemName: "play.fill", withConfiguration: configuration)
            let image = UIImage(systemName: "play.fill")
            playControlButton.setImage(image, for: .normal)
            
        }
    }
    
//    Timeupdate
    func updateTime(time: CMTime){
        // 시간 업데이트
        currentTimeLabel.text = secondsToString(sec: simplePlayer.currentTime)
        totalDurationLabel.text = secondsToString(sec: simplePlayer.totalDurationTime)
        // 슬라이더 업데이트
        if isSeeking == false {
            // Seeking중이 아닐때만 슬라이더를 업데이트
            // 슬라이더 정보 업데이트
            timeSlider.value = Float(simplePlayer.currentTime / simplePlayer.totalDurationTime)
        }
        
    }
    
    // 시간을 문자열로 변환시켜줌
    func secondsToString(sec: Double) -> String {
        guard sec.isNaN == false else { return "00:00" }
        let totalSeconds = Int(sec)
        let min = totalSeconds / 60
        let seconds = totalSeconds % 60
        return String(format: "%02d:%02d", min, seconds)
    }
    
    // 컬러를 다크/라이트 에따라 다르게 설정
    func updateTintColor(){
        playControlButton.tintColor = DefaultStyle.Colors.tint
        timeSlider.tintColor = DefaultStyle.Colors.tint
    }
}
