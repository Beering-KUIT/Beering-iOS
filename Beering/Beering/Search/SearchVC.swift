//
//  SearchVC.swift
//  Beering
//
//  Created by YoonSub Lim on 2023/07/12.
//

import UIKit
import SwiftUI

class SearchVC: UIViewController, SendFilterDataDelegate {
    
    func receiveData(data: String) {
        filterOptions.append(data)
        self.filterCollectionView.reloadData()
    }
    
    func clearFilterOptionData() {
        filterOptions.removeAll()
    }

    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var searchView: UIView!
    
    @IBOutlet weak var filterView: UIView!
    
    @IBOutlet weak var filterCollectionView: UICollectionView!

    @IBOutlet weak var searchCollectionView: UICollectionView!
    
    var tempData: [searchCellInfo] = [
        searchCellInfo(imageUrl: "https://picsum.photos/347", titleKor: "클라우드", titleEng: "Kloud", brewery: "Lotte", isFavorite: false),
        searchCellInfo(imageUrl: "https://picsum.photos/347/200", titleKor: "클라우드1", titleEng: "Kloud1", brewery: "Lotte1", isFavorite: false),
        searchCellInfo(imageUrl: "https://picsum.photos/333/600", titleKor: "클라우드2", titleEng: "Kloud2", brewery: "Lotte2", isFavorite: true),
        searchCellInfo(imageUrl: "https://picsum.photos/50", titleKor: "클라우드3", titleEng: "Kloud3", brewery: "Lotte3", isFavorite: false),
        searchCellInfo(imageUrl: "https://picsum.photos/349", titleKor: "클라우드4", titleEng: "Kloud4", brewery: "Lotte4", isFavorite: true),
        searchCellInfo(imageUrl: "https://picsum.photos/347", titleKor: "클라우드5", titleEng: "Kloud5", brewery: "Lotte5", isFavorite: true),
        searchCellInfo(imageUrl: "https://picsum.photos/100/100", titleKor: "클라우드6", titleEng: "Kloud6", brewery: "Lotte6", isFavorite: false)
    ]
    
    /// TODO Refactoring
    var filterOptions: [String] = []
    
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
        
        searchTextField.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func filterBtnTap(_ sender: Any) {
        
        let filterVC = UIStoryboard(name: "Filter", bundle: nil).instantiateInitialViewController() as! FilterVC
        filterVC.delegate = self
        
        self.present(filterVC, animated: true)
        
    }
    
    @IBAction func clearSearchTextfieldBtnTap(_ sender: Any) {
        
        searchTextField.text = ""
    }
    
    
}

extension SearchVC{
    
    func layoutInit(){
        self.navigationController?.navigationBar.barTintColor = UIColor(named: "Beering_White")
        
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

extension SearchVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, SearchCellDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == filterCollectionView{
            return filterOptions.count
        }else if collectionView == searchCollectionView{
            return tempData.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        if collectionView == filterCollectionView{
            let cell = filterCollectionView.dequeueReusableCell(withReuseIdentifier: "filterCell", for: indexPath) as! FilterCell
            
            cell.filterLabel.text = filterOptions[indexPath.row]
            cell.makeCircular()
            
            return cell
            
        }else if collectionView == searchCollectionView{
            // 사용할 Cell dequeue
            let cell = searchCollectionView.dequeueReusableCell(withReuseIdentifier: "searchCell", for: indexPath) as! SearchCell
            
            cell.delegate = self
            cell.index = indexPath.row
            
            cell.liquorImage.loadImage(from: tempData[indexPath.row].imageUrl)
            cell.liquorTitleKor.text = tempData[indexPath.row].titleKor
            cell.liquorTitleEng.text = tempData[indexPath.row].titleEng
            cell.breweryTitle.text = tempData[indexPath.row].brewery
            
            if tempData[indexPath.row].isFavorite{
                cell.isFavorite.isSelected = true
                cell.updateIsFavoriteImage()
            }else{
                cell.isFavorite.isSelected = false
                cell.updateIsFavoriteImage()
            }
            
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    // Heart Click 시의, SearchCellDelegate 구현 메서드
    func reloadFavoriteData(_ index: Int, _ isSelected: Bool){
        tempData[index].isFavorite = isSelected
//        searchCollectionView.reloadData()
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
            
            let filterOption = filterOptions[indexPath.item]
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

extension SearchVC: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // 키보드를 사라지게 하는 코드
        textField.resignFirstResponder()
        return true
    }
    
    /// TODO 글자 입력시마다 검색 API 호출
}

struct SearchSBPreView:PreviewProvider {
    static var previews: some View {
        UIStoryboard(name: "Search", bundle: nil).instantiateInitialViewController()!.toPreview()
    }
}
