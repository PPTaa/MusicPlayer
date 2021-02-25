//
//  ViewController.swift
//  MusicPlayer
//
//  Created by leejungchul on 2021/02/19.
//

import UIKit

class HomeViewController: UIViewController {
    // 트랙 관리 객체 추가
    let trackManager: TrackManager = TrackManager()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

extension HomeViewController: UICollectionViewDataSource{
    // 셀을 몇개 표시할까?
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // 셀 갯수 확인
        return trackManager.tracks.count
    }
    // 셀을 어떻게 표시할까?
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //셀 구성하기
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TrackCollectionViewCell", for: indexPath) as? TrackCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let item = trackManager.track(at: indexPath.item)
        cell.updateUI(item: item)
        return cell
    }
    // 헤더뷰 를 어떻게 표시할까?
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            // 트랙매니저에서 오늘의 트랙을 가져옴
            guard let item = trackManager.todayTrack else { return UICollectionReusableView() }
            // 헤더뷰를 가져옴
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "TrackCollectionHeaderView", for: indexPath) as? TrackCollectionHeaderView else { return UICollectionReusableView() }
            
            header.update(with: item)
            header.tapHandler = { item -> Void in
                // Player 를 띄운다.
                print("item title : \(item.convertToTrack()?.title)")
                let playerStoryboard = UIStoryboard.init(name: "Player", bundle: nil)
                guard let playerVC = playerStoryboard.instantiateViewController(identifier: "PlayerViewController") as? PlayerViewController else { return }
                
                guard let index = self.trackManager.todayTrackIndex else { return }
                playerVC.simplePlayer.replaceCurrentItem(with: item, idx: index)
                
                self.present(playerVC, animated: true, completion: nil)
            }
            
            // 헤더 구성
            return header
        default:
            return UICollectionReusableView()
        }
    }
}
// 클릭시 이벤트
extension HomeViewController:UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // 클릭시 곡 플레이어 뷰 띄우기
        let playerStoryboard = UIStoryboard.init(name: "Player", bundle: nil)
        guard let playerVC = playerStoryboard.instantiateViewController(identifier: "PlayerViewController") as? PlayerViewController else { return }
        let item = trackManager.tracks[indexPath.item]
        
        playerVC.simplePlayer.replaceCurrentItem(with: item, idx: indexPath.row)
        
        present(playerVC, animated: true, completion: nil)
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // 컬렉션 뷰 사이즈 지정하기
        let itemSpacing: CGFloat = 20
        let margin: CGFloat = 20
        let width = (collectionView.bounds.width - itemSpacing - margin*2 )/2
        let height = width + 60
        
        return CGSize(width: width, height: height)
    }
}
