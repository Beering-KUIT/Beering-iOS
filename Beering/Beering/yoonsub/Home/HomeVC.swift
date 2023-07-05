//
//  HomeVC.swift
//  Beering
//
//  Created by YoonSub Lim on 2023/07/05.
//

import UIKit
import SwiftUI

class HomeVC: UIViewController {

    @IBOutlet weak var reviewTableView: UITableView!
    var profileImageArr: [String] = [
        "https://picsum.photos/50",
        "https://picsum.photos/50",
        "https://picsum.photos/50",
        "https://picsum.photos/50",
        "https://picsum.photos/50",
        "https://picsum.photos/50",
        "https://picsum.photos/50",
        "https://picsum.photos/50",
        "https://picsum.photos/50",
        "https://picsum.photos/50",
        "https://picsum.photos/50",
        "https://picsum.photos/50"
    ]
    
    var nicknameArr: [String] = [
    "임윤섭1",
    "임윤섭2",
    "임윤섭3",
    "임윤섭4",
    "임윤섭5",
    "임윤섭6",
    "임윤섭7",
    "임윤섭8",
    "임윤섭9",
    "임윤섭10",
    "임윤섭11",
    "임윤섭12",
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("## HomeVC 진입")
        
        reviewTableView.delegate = self
        reviewTableView.dataSource = self
        
        let nibName = UINib(nibName: "ReviewCell", bundle: nil)
        reviewTableView.register(nibName, forCellReuseIdentifier: "reviewCell")
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

extension HomeVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("### numberOfRows " + String(section))
        return nicknameArr.count /// TODO Change
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "reviewCell", for: indexPath) as! ReviewCell
        
        cell.profileImage.loadImage(from: profileImageArr[indexPath.row])
        cell.profileImage.makeCircular()
        cell.nickname.text = nicknameArr[indexPath.row]
        
        print("## " + cell.nickname.text!)
        print("## indexPath.row : " + String(indexPath.row))
        // 초기화
        
        return cell
    }
}

struct HomeSBPreView:PreviewProvider {
    static var previews: some View {
        UIStoryboard(name: "Home", bundle: nil).instantiateInitialViewController()!.toPreview()
    }
}

struct HomeVCPreView:PreviewProvider {
    static var previews: some View {
        HomeVC().toPreview()
    }
}

