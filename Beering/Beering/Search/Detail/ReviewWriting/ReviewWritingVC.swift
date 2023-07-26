//
//  ReviewWritingVC.swift
//  Beering
//
//  Created by YoonSub Lim on 2023/07/25.
//

import UIKit

class ReviewWritingVC: UIViewController {

    @IBOutlet weak var reviewWritingTextView: UITextView!
    
    @IBOutlet weak var reviewPictureCollectionView: UICollectionView!
    
    var tempData = [
        "https://picsum.photos/100/300",
        "https://picsum.photos/200/3000",
        "https://picsum.photos/200/200",
        "https://picsum.photos/50/50",
        "https://picsum.photos/200/300",
        "https://picsum.photos/200/300",
        "https://picsum.photos/100/300",
        "https://picsum.photos/200/3000",
        "https://picsum.photos/200/200",
        "https://picsum.photos/50/50",
        "https://picsum.photos/200/300",
        "https://picsum.photos/200/300"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textViewInit(reviewWritingTextView)
        
        reviewPictureCollectionView.dataSource = self
        reviewPictureCollectionView.delegate = self
        
        let reviewPictureCell = UINib(nibName: "ReviewPictureCell", bundle: nil)
        reviewPictureCollectionView.register(reviewPictureCell, forCellWithReuseIdentifier: "reviewPictureCell")
        
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
        return tempData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reviewPictureCell", for: indexPath) as! ReviewPictureCell
        
        cell.reviewImage.loadImage(from: tempData[indexPath.row])
        
        return cell
    }
    
    
    // CollectionView Cell의 Size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: collectionView.frame.height, height: collectionView.frame.height)
    }
    
}
