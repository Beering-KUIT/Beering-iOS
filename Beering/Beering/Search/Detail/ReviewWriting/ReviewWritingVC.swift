//
//  ReviewWritingVC.swift
//  Beering
//
//  Created by YoonSub Lim on 2023/07/25.
//

import UIKit
import PhotosUI

class ReviewWritingVC: UIViewController {
    
    var reviewData = reviewEssentialContent()

    @IBOutlet weak var reviewWritingTextView: UITextView!
    
    @IBOutlet weak var reviewPictureCollectionView: UICollectionView!
    
    var myReviewImages: [UIImage] = []
    @IBOutlet weak var myReviewImageCountLabel: UILabel!
    
    @IBOutlet var starSliders: [StarSlider]!
    
    @IBOutlet var starSliderStars: [UIImageView]!
    
    @IBOutlet var starSliderRateLabel: [UILabel]!
    
    @IBOutlet var titleViews: [UIView]!
    
    @IBOutlet weak var reviewWriteBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("viewDidLoad and reviewData is : \(reviewData)")
        
        navigationBarInit()
        
        /// TODO : textColor / font
        /// 적용은 되는데, 그렇게 보이지 않음
        reviewWritingTextView.delegate = self
        reviewWritingTextView.textColor = .lightGray
        reviewWritingTextView.text = "시음한 뒤 감상을 적어주세요."
        //        reviewWritingTextView.font = UIFont(name: "Pretendard", size: 30)

        reviewWritingTextView.textViewInit()
        
        reviewPictureCollectionView.dataSource = self
        reviewPictureCollectionView.delegate = self
        
        let reviewPictureCell = UINib(nibName: "ReviewPictureCell", bundle: nil)
        reviewPictureCollectionView.register(reviewPictureCell, forCellWithReuseIdentifier: "reviewPictureCell")
        
        for labelView in starSliderRateLabel{
            labelView.makeCircular()
        }
        
        for view in titleViews{
            view.titleViewInit()
        }
    }
    
    private func navigationBarInit(){

        self.navigationController?.navigationBar.tintColor = UIColor(named: "Beering_Black")
                
        let leftBarButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "arrow_left"), style: .done, target: self, action: #selector(goBack))
        self.navigationItem.leftBarButtonItem = leftBarButton
        
        self.navigationItem.title = "리뷰 작성"
        
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
    
    // 컬렉션 뷰 셀 삭제 처리
    func removeCell(at indexPath: IndexPath) {
        myReviewImages.remove(at: indexPath.item)
        reviewPictureCollectionView.deleteItems(at: [indexPath])
        print("remove : \(indexPath.item)")
        myReviewImageCountLabel.text = String(myReviewImages.count) + "/10"
        
        updateCellIndexPaths()
    }
    
    // 셀들의 indexPath 업데이트
    func updateCellIndexPaths() {
        let visibleCells = reviewPictureCollectionView.visibleCells
        for (index, cell) in visibleCells.enumerated() {
            if let indexPath = reviewPictureCollectionView.indexPath(for: cell) {
                (cell as? ReviewPictureCell)?.indexPath = indexPath
            }
        }
    }
    
    //MARK: - 카메라 이미지 클릭시 Alert
    @IBAction func pictureUploadBtnTap(_ sender: Any) {
        // 메시지창 컨트롤러 인스턴스 생성
        let alert = UIAlertController(title: "사진 업로드", message: "업로드 방식을 선택해주세요", preferredStyle: UIAlertController.Style.actionSheet)

        // 메시지 창 컨트롤러에 들어갈 버튼 액션 객체 생성
        let cameraAction =  UIAlertAction(title: "카메라로 촬영", style: UIAlertAction.Style.default){ [weak self] _ in
            self?.pictureUploadByCamera()
        }
        let galleryAction =  UIAlertAction(title: "사진첩에서 선택", style: UIAlertAction.Style.default){ [weak self] _ in
            if #available(iOS 14.0, *) {
                self?.presentImagePicker()
            }else{
                self?.pictureUploadByGallery()
            }
        }
        let cancelAction = UIAlertAction(title: "취소", style: UIAlertAction.Style.cancel, handler: nil)

        //메시지 창 컨트롤러에 버튼 액션을 추가
        alert.addAction(cameraAction)
        alert.addAction(galleryAction)
        alert.addAction(cancelAction)

        //메시지 창 컨트롤러를 표시
        self.present(alert, animated: true)
    }

    //MARK: - Star Slider
    @IBAction func onSliderValueChanged(_ sender: UISlider) {
        
        // label 표시 숫자. 소수점 1자리
        let floatValue = floor(sender.value * 100) / 100
        
        let intValue = Int(floor(sender.value))
        
        let roundedNumber = (floatValue * 2).rounded() / 2 // .5 단위 반올림
        
        var sliderIdx: Int?
        
        switch sender{
        case starSliders[0]:
            reviewData.tasteRating = roundedNumber
            sliderIdx = 0
        case starSliders[1]:
            reviewData.aromaRating = roundedNumber
            sliderIdx = 1
        case starSliders[2]:
            reviewData.colorRating = roundedNumber
            sliderIdx = 2
        case starSliders[3]:
            reviewData.swallowingRating = roundedNumber
            sliderIdx = 3
        case starSliders[4]:
            reviewData.totalRating = roundedNumber
            sliderIdx = 4
        default:
            return
        }
        
        starSliderRateLabel[sliderIdx!].text = String(roundedNumber)
        
        for index in 0..<Int(floor(roundedNumber)){
            if let starImage = starSliderStars[(5 * sliderIdx!) + index] as? UIImageView {
                starImage.image = UIImage(named: "star_filled")
            }
        }
        for index in Int(floor(roundedNumber))..<5{
            if let starImage = starSliderStars[(5 * sliderIdx!) + index] as? UIImageView {
                starImage.image = UIImage(named: "star_blank")
            }
        }
        if roundedNumber - Float(intValue) == 0.5{
            if let starImage = starSliderStars[(5 * sliderIdx!) + Int(floor(roundedNumber))] as? UIImageView {
                starImage.image = UIImage(named: "star_half")
            }
        }
        
        updateReviewApplyBtn()
    }
    
    @objc func updateReviewApplyBtn() {
        
        print("updateReviewApply and reviewData : \(reviewData)")
        
        if reviewData.reviewText != "" && reviewData.tasteRating != nil && reviewData.aromaRating != nil && reviewData.colorRating != nil && reviewData.swallowingRating != nil && reviewData.totalRating != nil{
            reviewWriteBtn.isEnabled = true
            reviewWriteBtn.backgroundColor = UIColor(named: "Beering_Black")
        }else{
            reviewWriteBtn.isEnabled = false
            reviewWriteBtn.backgroundColor = UIColor(named: "Gray01")
        }
    }
    
    @IBAction func reviewWritingBtnTap(_ sender: Any) {
        /// TODO review 작성 API 호출
        print("리뷰작성 버튼 클릭")
    }
    
}

extension ReviewWritingVC: UITextViewDelegate{
    
    func textViewDidBeginEditing (_ textView: UITextView) {
        if reviewWritingTextView.textColor == .lightGray && reviewWritingTextView.isFirstResponder {
            reviewWritingTextView.text = nil
            reviewWritingTextView.textColor = .black
        }
    }
    
    func textViewDidEndEditing (_ textView: UITextView) {
        if reviewWritingTextView.text.isEmpty || reviewWritingTextView.text == "" {
            reviewWritingTextView.textColor = .lightGray
            reviewWritingTextView.text = "시음한 뒤 감상을 적어주세요."
        }else{
            reviewData.reviewText = reviewWritingTextView.text
            updateReviewApplyBtn()
        }
    }
    
}

extension ReviewWritingVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myReviewImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reviewPictureCell", for: indexPath) as! ReviewPictureCell
        
        //        cell.reviewImage.loadImage(from: tempData[indexPath.row])
        cell.reviewImage.image = myReviewImages[indexPath.row]
        
        // cell에 indexPath와 delegate 설정
        cell.indexPath = indexPath
        cell.delegate = self
        
        return cell
    }
    
    
    // CollectionView Cell의 Size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.height, height: collectionView.frame.height)
    }
    
}

extension ReviewWritingVC: ReviewPictureCellDelegate {
    
    func didTapRemoveButton(at indexPath: IndexPath) {
        removeCell(at: indexPath)
    }
}

//MARK: - 리뷰 이미지 선택 by 카메라 촬영 / 사진첩 선택
extension ReviewWritingVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate, PHPickerViewControllerDelegate{
    
    //MARK: - 카메라 촬영
    func pictureUploadByCamera(){
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = false
        imagePicker.cameraDevice = .rear
        imagePicker.cameraCaptureMode = .photo
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    // Use Photo Btn
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            myReviewImages.append(image)
            myReviewImageCountLabel.text = String(myReviewImages.count) + "/10"
            
            self.reviewPictureCollectionView.reloadData()
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    // cancel Btn
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    //MARK: - 사진첩 선택 (ios 13 ~)
    func pictureUploadByGallery(){
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    //MARK: - 사진첩 선택 (ios 14 ~)
    
    // 리뷰 이미지 선택 (사진첩 선택)
    @available(iOS 14.0, *)
    func presentImagePicker() {
        // configuration 정의
        var config = PHPickerConfiguration()
        
        config.selectionLimit = 10
        
        if #available(iOS 15.0, *) {
            config.filter = .any(of: [.images, .screenshots])
        } else {
            config.filter = .any(of: [.images]) // images 에 live photos 포함
        }
        
        // picker Present
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    
    @available(iOS 14.0, *)
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true, completion: nil)
        
        // 이미지 처리 로직 추가
        for result in results {
            if result.itemProvider.canLoadObject(ofClass: UIImage.self) {
                result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] (image, error) in
                    DispatchQueue.main.async {
                        if let image = image as? UIImage {
                            self?.myReviewImages.append(image)
                            self?.myReviewImageCountLabel.text = String(self!.myReviewImages.count) + "/10"
                            
                            self?.reviewPictureCollectionView.reloadData()
                        }
                    }
                }
            }
        }
    }
}

struct reviewEssentialContent{
    var reviewText: String = ""
    var tasteRating: Float?
    var aromaRating: Float?
    var colorRating: Float?
    var swallowingRating: Float?
    var totalRating: Float?
}
