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
    
    @IBOutlet weak var filterCollectionView: UICollectionView!

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
    
    var selectedFilterOptions: [String] = [
        "맥주",
        "리뷰많은순",
        "0~20000원",
        "와인",
        "리뷰많은순",
        "0~20000원"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading    the view.
        
        layoutInit()
        
        // 컬렉션 뷰에 사용할 셀을 등록하는 기능
        // 여러 nib 를 등록할 수 있다고 한다
        // filterCollectionView
        let filterCellNibName = UINib(nibName: "FilterCell", bundle: nil)
        filterCollectionView.register(filterCellNibName, forCellWithReuseIdentifier: "filterCell")
        
        filterCollectionView.delegate = self
        filterCollectionView.dataSource = self
        
        // searchCollectionView
        let searchCellNibName = UINib(nibName: "SearchCell", bundle: nil)
        searchCollectionView.register(searchCellNibName, forCellWithReuseIdentifier: "searchCell")
        
        searchCollectionView.dataSource = self
        searchCollectionView.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func filterBtnTap(_ sender: Any) {
        
        let filterVC = UIStoryboard(name: "Filter", bundle: nil).instantiateInitialViewController()
        
        self.present(filterVC!, animated: true)
        
    }
    
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
        
        if collectionView == filterCollectionView{
            return selectedFilterOptions.count
        }else if collectionView == searchCollectionView{
            return tempData.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        if collectionView == filterCollectionView{
            let cell = filterCollectionView.dequeueReusableCell(withReuseIdentifier: "filterCell", for: indexPath) as! FilterCell
            
            cell.filterLabel.text = selectedFilterOptions[indexPath.row]
            cell.makeCircular()
            
            return cell
            
        }else if collectionView == searchCollectionView{
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
        
        return UICollectionViewCell()
    }
    
    // 선택시 move to Detail
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == searchCollectionView{
            print("선택한 item : \(tempData[indexPath.row].titleKor)")
            
            let DetailStoryboard = UIStoryboard(name: "Detail", bundle: nil)
            let DetailVC = DetailStoryboard.instantiateInitialViewController()
            // 메인 화면을 풀 스크린으로 표시
            
            self.tabBarController?.tabBar.isHidden = true
            self.navigationController?.pushViewController(DetailVC!, animated: true)
        }
        // do stuff with image, or with other data that you need
    }
    
    func calculateFilterCellWidth(for filterOption: String) -> CGFloat {
        // 셀 폭을 계산하는 로직을 작성합니다.
        // 예: 텍스트의 길이에 따라 동적으로 폭을 설정하거나, 고정된 값으로 설정할 수 있습니다.
        let textWidth = filterOption.size(withAttributes: [.font: UIFont.systemFont(ofSize: 12.0)]).width
        let cellWidth = textWidth + 30.0 // 예시로 폭에 텍스트 너비를 추가하고 여백을 더합니다.
        
        return cellWidth
    }
    
    // CollectionView Cell의 Size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
                
        if collectionView == filterCollectionView{
            
            let filterOption = selectedFilterOptions[indexPath.item]
            let cellWidth = calculateFilterCellWidth(for: filterOption)
            
            print("Width : \(cellWidth), Height : \(collectionView.frame.height)")
            return CGSize(width: cellWidth, height: collectionView.frame.height)
            
        }else if collectionView == searchCollectionView{
            let width: CGFloat = collectionView.frame.width / 2 - 1.0
            return CGSize(width: width, height: 260)
        }
        return CGSize.zero
    }
    
    // CollectionView Cell의 위아래 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    // CollectionView Cell의 옆 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        if collectionView == filterCollectionView{
            return 7.0
        }else if collectionView == searchCollectionView{
            return 1.0
        }else{
            return 0
        }
    }
    
}
