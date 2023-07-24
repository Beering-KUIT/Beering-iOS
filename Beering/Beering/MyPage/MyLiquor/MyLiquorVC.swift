//
//  MyLiquorVC.swift
//  Beering
//
//  Created by YoonSub Lim on 2023/07/24.
//

import UIKit

class MyLiquorVC: UIViewController {
    
    @IBOutlet weak var myLiquorCollectionView: UICollectionView!
    
    let tempData: [searchCellInfo] = [
        searchCellInfo(imageUrl: "https://picsum.photos/347", titleKor: "클라우드", titleEng: "Kloud", brewery: "Lotte", isFavorite: false),
        searchCellInfo(imageUrl: "https://picsum.photos/347/200", titleKor: "클라우드1", titleEng: "Kloud1", brewery: "Lotte1", isFavorite: false),
        searchCellInfo(imageUrl: "https://picsum.photos/333/600", titleKor: "클라우드2", titleEng: "Kloud2", brewery: "Lotte2", isFavorite: true),
        searchCellInfo(imageUrl: "https://picsum.photos/50", titleKor: "클라우드3", titleEng: "Kloud3", brewery: "Lotte3", isFavorite: false),
        searchCellInfo(imageUrl: "https://picsum.photos/349", titleKor: "클라우드4", titleEng: "Kloud4", brewery: "Lotte4", isFavorite: true),
        searchCellInfo(imageUrl: "https://picsum.photos/347", titleKor: "클라우드5", titleEng: "Kloud5", brewery: "Lotte5", isFavorite: true),
        searchCellInfo(imageUrl: "https://picsum.photos/100/100", titleKor: "클라우드6", titleEng: "Kloud6", brewery: "Lotte6", isFavorite: false),
        searchCellInfo(imageUrl: "https://picsum.photos/347", titleKor: "클라우드", titleEng: "Kloud", brewery: "Lotte", isFavorite: false),
        searchCellInfo(imageUrl: "https://picsum.photos/347/200", titleKor: "클라우드1", titleEng: "Kloud1", brewery: "Lotte1", isFavorite: false),
        searchCellInfo(imageUrl: "https://picsum.photos/333/600", titleKor: "클라우드2", titleEng: "Kloud2", brewery: "Lotte2", isFavorite: true),
        searchCellInfo(imageUrl: "https://picsum.photos/50", titleKor: "클라우드3", titleEng: "Kloud3", brewery: "Lotte3", isFavorite: false),
        searchCellInfo(imageUrl: "https://picsum.photos/349", titleKor: "클라우드4", titleEng: "Kloud4", brewery: "Lotte4", isFavorite: true),
        searchCellInfo(imageUrl: "https://picsum.photos/347", titleKor: "클라우드5", titleEng: "Kloud5", brewery: "Lotte5", isFavorite: true),
        searchCellInfo(imageUrl: "https://picsum.photos/100/100", titleKor: "클라우드6", titleEng: "Kloud6", brewery: "Lotte6", isFavorite: false)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = false
        
        // myLiquorCollectionView
        let myLiquorCellNibName = UINib(nibName: "SearchCell", bundle: nil)
        myLiquorCollectionView.register(myLiquorCellNibName, forCellWithReuseIdentifier: "searchCell")
        
        myLiquorCollectionView.dataSource = self
        myLiquorCollectionView.delegate = self
        
        navigationBarInit()
    }

    private func navigationBarInit(){

        self.navigationController?.navigationBar.tintColor = UIColor(named: "Beering_Black")
                
        let leftBarButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "arrow_left"), style: .done, target: self, action: #selector(goBack))
        self.navigationItem.leftBarButtonItem = leftBarButton
        
        self.navigationItem.title = "찜한 주류 모아보기"
        
        // 커스텀 폰트를 가져옴
        if let customFont = UIFont(name: "Pretendard", size: 16) {
            // 타이틀 텍스트를 NSAttributedString으로 생성하고 폰트를 적용
            let titleTextAttributes: [NSAttributedString.Key: Any] = [
                .font: customFont,
                .foregroundColor: UIColor(named: "Beering_Black") ?? .black // 폰트 색상 설정
            ]
            self.navigationController?.navigationBar.titleTextAttributes = titleTextAttributes
        }
        
    }
    
    @objc private func goBack(){
        self.navigationController?.popViewController(animated: true)
    }
}


extension MyLiquorVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tempData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // 사용할 Cell dequeue
        let cell = myLiquorCollectionView.dequeueReusableCell(withReuseIdentifier: "searchCell", for: indexPath) as! SearchCell
        
        cell.liquorImage.loadImage(from: tempData[indexPath.row].imageUrl)
        cell.liquorTitleKor.text = tempData[indexPath.row].titleKor
        cell.liquorTitleEng.text = tempData[indexPath.row].titleEng
        cell.breweryTitle.text = tempData[indexPath.row].brewery
        
        if tempData[indexPath.row].isFavorite{
            cell.isFavorite.image = UIImage(named: "heart_filled")
        }else{
            cell.isFavorite.image = UIImage(named: "heart_blank")
        }
        
        return cell
        
    }
    
    // 선택시 move to Detail
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("선택한 item : \(tempData[indexPath.row].titleKor)")
        
        let DetailStoryboard = UIStoryboard(name: "Detail", bundle: nil)
        let DetailVC = DetailStoryboard.instantiateInitialViewController()
        // 메인 화면을 풀 스크린으로 표시
        
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.pushViewController(DetailVC!, animated: true)
        
    }

    // CollectionView Cell의 Size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        print("collectionView.frame.width  : \(collectionView.frame.width)")
        let width: CGFloat = collectionView.frame.width / 2 - 1.0
        print("width : \(width)")
        return CGSize(width: width, height: 260)
        
    }
    
    // CollectionView Cell의 위아래 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    // CollectionView Cell의 옆 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
}
