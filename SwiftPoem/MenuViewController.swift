//
//  MenuViewController.swift
//  SwiftPoem
//
//  Created by 宮本一彦 on 2017/03/26.
//  Copyright © 2017年 宮本一彦. All rights reserved.
//

import UIKit
import Firebase

class MenuViewController: UIViewController {
    
    var hashString = String()

    @IBOutlet weak var odaiLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getInfo()

            }
    // FIrebaseからお題を取ってくる
    func getInfo() {
        
        // ロード時のくるくる
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        // DB(Firebase)に接続
        let firebase = FIRDatabase.database().reference(fromURL:"https://swiftpoem-9711c.firebaseio.com/")
        
        // DBからテキストを取ってくる
        firebase.queryLimited(toLast: 1).observe(.value) { // 最新のものを１つ取ってくる
            (snapshot,error) in
            
            if let dictionary = snapshot.value as? [String:AnyObject] {
                
                let snapshotValue = snapshot.value as! NSDictionary
                snapshotValue.setValuesForKeys(dictionary)
                
                let text = snapshotValue["text"] as! String
                
                // ラベルに反映
                self.odaiLabel.text = text
                
                self.hashString = text
            }
        }
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        
    }

    @IBAction func nextView(_ sender: Any) {
        performSegue(withIdentifier: "next", sender: nil)
    }
    
    // お題の値（テーマ）を渡す
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "next") {
            
            let flickerVC:FlickerViewController = segue.destination as! FlickerViewController
            // UIImage型の変数へ画像を入れる
            flickerVC.hashString = hashString
        
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
            }
    

   

}
