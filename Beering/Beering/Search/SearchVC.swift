//
//  SearchVC.swift
//  Beering
//
//  Created by YoonSub Lim on 2023/07/12.
//

import UIKit

class SearchVC: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var searchView: UIView!
    
    @IBOutlet weak var filterView: UIView!
    
    @IBOutlet weak var searchCollectionView: UICollectionView!
    
    let tempData: [searchCellInfo] = [
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

        // Do any additional setup after loading    the view.
        
        layoutInit()
        
        // 컬렉션 뷰에 사용할 셀을 등록하는 기능
        // 여러 nib 를 등록할 수 있다고 한다
        let searchCellNibName = UINib(nibName: "SearchCell", bundle: nil)
        searchCollectionView.register(searchCellNibName, forCellWithReuseIdentifier: "searchCell")
        
        searchCollectionView.dataSource = self
        searchCollectionView.delegate = self
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SearchVC{
    
    func layoutInit(){
        searchTextField.borderStyle = .none
        searchView.addBottomBorderWithColor(color: UIColor.black, width: 1)
        filterView.makeCircular()
    }
}

struct searchCellInfo{
    var imageUrl: String
    var titleKor: String
    var titleEng: String
    var brewery: String
    var isFavorite: Bool
}

extension SearchVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tempData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // 사용할 Cell dequeue
        let cell = searchCollectionView.dequeueReusableCell(withReuseIdentifier: "searchCell", for: indexPath) as! SearchCell
        
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
    
    // CollectionView Cell의 Size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width: CGFloat = collectionView.frame.width / 2 - 1.0
        
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
