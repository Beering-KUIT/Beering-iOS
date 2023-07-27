//
//  ReviewWritingVC.swift
//  Beering
//
//  Created by YoonSub Lim on 2023/07/25.
//

import UIKit
import PhotosUI

class ReviewWritingVC: UIViewController {

    @IBOutlet weak var reviewWritingTextView: UITextView!
    
    @IBOutlet weak var reviewPictureCollectionView: UICollectionView!
    
    var myReviewImages: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textViewInit(reviewWritingTextView)
        
        reviewPictureCollectionView.dataSource = self
        reviewPictureCollectionView.delegate = self
        
        let reviewPictureCell = UINib(nibName: "ReviewPictureCell", bundle: nil)
        reviewPictureCollectionView.register(reviewPictureCell, forCellWithReuseIdentifier: "reviewPictureCell")
    }
    
    // 컬렉션 뷰 셀 삭제 처리
    func removeCell(at indexPath: IndexPath) {
        myReviewImages.remove(at: indexPath.item)
        reviewPictureCollectionView.deleteItems(at: [indexPath])
        print("remove : \(indexPath.item)")
        
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
        }
    }
    
    func textViewInit(_ myTextView: UITextView){
        
        reviewWritingTextView.delegate = self
        reviewWritingTextView.textColor = .lightGray
        reviewWritingTextView.text = "시음한 뒤 감상을 적어주세요."
//        reviewWritingTextView.font = UIFont(name: "Pretendard", size: 30)
        
        // 먼저 행간 조절 스타일 설정
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 10

        let attributedString = NSMutableAttributedString(string: myTextView.text)

        // 자간 조절 설정
        attributedString.addAttribute(NSAttributedString.Key.kern, value: CGFloat(1), range: NSRange(location: 0, length: attributedString.length))

        // 행간 스타일 추가
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: NSRange(location: 0, length: attributedString.length))

        // TextView에 세팅
        myTextView.attributedText = attributedString
        
        // Text contentInset
        myTextView.contentInset = .init(top: 20, left: 20, bottom: 20, right: 20)
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
        imagePicker.allowsEditing = true
        imagePicker.cameraDevice = .rear
        imagePicker.cameraCaptureMode = .photo
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    // Use Photo Btn
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            myReviewImages.append(image)
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
                            self?.reviewPictureCollectionView.reloadData()
                        }
                    }
                }
            }
        }
    }
}
