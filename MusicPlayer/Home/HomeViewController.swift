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
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // 셀 갯수 확인
        return trackManager.tracks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //셀 구성하기
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TrackCollectionViewCell", for: indexPath) as? TrackCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let item = trackManager.track(at: indexPath.item)
        
        cell.updateUI(item: item)
        
        return cell
    }
}

extension HomeViewController:UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // 클릭시 곡 플레이어 뷰 띄우기
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
