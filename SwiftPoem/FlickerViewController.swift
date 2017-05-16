//
//  FlickerViewController.swift
//  SwiftPoem
//
//  Created by 宮本一彦 on 2017/03/26.
//  Copyright © 2017年 宮本一彦. All rights reserved.
//

import UIKit
import SDWebImage

class FlickerViewController: UIViewController,UITextFieldDelegate {

    var hashString = String()
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var dotsView: DotsLoader!
    @IBOutlet weak var selectImageView: UIImageView!
    
    
    let apikey = "825f9e2d3ae9a39c647e1148db210c4d"
    // secretky = f9337ebc4aca1e3b
    
    // farm
    // server
    // id
    // secret
    
    // URLの生成用の配列
    var farmArray = [Int]()
    var serverArray = [String]()
    var idArray = [String]()
    var secretArray = [String]()
    
    // 完成URL用の配列
    var urlArray = [String]()
    
    // URL生成要素
    var farm:String = String()
    var server:String = String()
    var id:String = String()
    var secret:String = String()
    
    // 何回押されたか
    var count:Int = 0
    var tapCount:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // DotsViewを隠す
        dotsView.isHidden = true
            }
    
    @IBAction func searchActionButton(_ sender: Any) {
        dotsView.isHidden = false
        count = 0
        tapCount = 0
        self.urlArray.removeAll()
        setUpFlicker()
        
        perform(#selector(createURLFromFlicker),with:nil, afterDelay:2.0)
        perform(#selector(dotsHidden),with:nil, afterDelay:4.0)
    }
    
    func dotsHidden(){
        dotsView.isHidden = true
    }
    
    
    func setUpFlicker(){
        
        //検索した言葉から10件画像とってくる
        
        let urlString:String = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(apikey)&tags=\(searchTextField.text!)&per_page=10&format=json&nojsoncallback=1"
        
        
        let urlStr = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url:URL = URL(string:urlStr)!
        
        let searchTask = URLSession.shared.dataTask(with: url as URL, completionHandler:{data, response, error -> Void in
            
            if error != nil{
                print(error)
                return
            }
            
            do{
                let resultsDictionary = try JSONSerialization.jsonObject(with:data!,options:[]) as? [String:AnyObject]
                guard let results = resultsDictionary else {return}
                guard let photosContainer = resultsDictionary!["photos"] as? NSDictionary else{ return }
                guard let photosArray = photosContainer["photo"] as? [NSDictionary] else{ return }
                
                
                
                //とり方
                self.farmArray = photosArray.map{$0["farm"] as! Int}
                self.serverArray = photosArray.map{$0["server"] as! String}
                self.idArray = photosArray.map{$0["id"] as! String}
                self.secretArray = photosArray.map{$0["secret"] as! String}
                
                
            }catch let error as NSError{
                
                print(error)
                return
            }
        })
        
        searchTask.resume()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if (searchTextField.isFirstResponder){
            searchTextField.resignFirstResponder()
        }
    }
    
    func createURLFromFlicker(){
        count = 0
        // URLを作成する
        for element in self.farmArray{
            count = count + 1
            if count == 10 {
                count = 0
            }
            // N番目の配列の中身を出す
            let farm = self.farmArray[count]
            let server = self.serverArray[count]
            let id = self.idArray[count]
            let secret = self.secretArray[count]
            
            // url生成
            let urlString = "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret).jpg"
            self.urlArray.append(urlString)
        }
        let urlString = self.urlArray[0]
        selectImageView.sd_setImage(with: URL(string:urlString))
        
    }
    
    @IBAction func changeImage(_ sender: Any) {
        if selectImageView.image != nil{
            tapCount = tapCount + 1
            
            if tapCount == 10{
                tapCount = 0
            }
            let urlString = self.urlArray[tapCount]
            selectImageView.sd_setImage(with: URL(string:urlString))
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "edit"){
            let editVC:EditViewController = segue.destination as! EditViewController
            
           editVC.selectedImage = selectImageView.image!
            editVC.hashString = hashString
        }
    }
    
    @IBAction func next(_ sender: Any) {
        performSegue(withIdentifier: "edit", sender: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
            }
    

}
