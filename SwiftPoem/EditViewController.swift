//
//  EditViewController.swift
//  SwiftPoem
//
//  Created by 宮本一彦 on 2017/03/26.
//  Copyright © 2017年 宮本一彦. All rights reserved.
//

import UIKit
import ExpandingMenu
import CoreImage

class EditViewController: UIViewController {

    var selectedImage = UIImage()
    var hashString = String()
    
    @IBOutlet weak var sliderView: UISlider!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textView: UITextView!
    
    var sliderValue:Int = 0
    var pathImage:UIImage = UIImage()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = selectedImage
        setColorButton()
    }

    func setColorButton(){
        let menuButtonSize:CGSize = CGSize(width: 64.0, height: 64.0)
        let menuButton = ExpandingMenuButton(frame: CGRect(origin:CGPoint(x:0,y:0), size:menuButtonSize), centerImage: UIImage(named:"next.png")!, centerHighlightedImage: UIImage(named:"next.png")!)
        
        menuButton.center = CGPoint(x:self.view.bounds.width - 32.0, y: self.view.bounds.height - 32.0)
        menuButton.menuTitleDirection = .left
        view.addSubview(menuButton)
        
        
        let item1 = ExpandingMenuItem(size: menuButtonSize, title: "Red", image: UIImage(named:"red.png")!, highlightedImage: UIImage(named:"red.png")!, backgroundImage: UIImage(named:"red.png")!, backgroundHighlightedImage: UIImage(named:"red.png")!){() -> Void in
            
            // textViewのテキストカラーを変更(Red)
            self.textView.textColor = UIColor.red
        }
        
        let item2 = ExpandingMenuItem(size: menuButtonSize, title: "Yellow", image: UIImage(named:"yellow.png")!, highlightedImage: UIImage(named:"yellow.png")!, backgroundImage: UIImage(named:"yellow.png")!, backgroundHighlightedImage: UIImage(named:"yellow.png")!){() -> Void in
            
            // textViewのテキストカラーを変更(yellow)
            self.textView.textColor = UIColor.yellow
        }
        
        let item3 = ExpandingMenuItem(size: menuButtonSize, title: "Black", image: UIImage(named:"black.png")!, highlightedImage: UIImage(named:"black.png")!, backgroundImage: UIImage(named:"black.png")!, backgroundHighlightedImage: UIImage(named:"black.png")!){() -> Void in
            
            // textViewのテキストカラーを変更(Red)
            self.textView.textColor = UIColor.black
        }
        
        let item4 = ExpandingMenuItem(size: menuButtonSize, title: "Green", image: UIImage(named:"green.png")!, highlightedImage: UIImage(named:"green.png")!, backgroundImage: UIImage(named:"green.png")!, backgroundHighlightedImage: UIImage(named:"green.png")!){() -> Void in
            
            // textViewのテキストカラーを変更(Red)
            self.textView.textColor = UIColor.green
        }
        
        let item5 = ExpandingMenuItem(size: menuButtonSize, title: "White", image: UIImage(named:"white.png")!, highlightedImage: UIImage(named:"white.png")!, backgroundImage: UIImage(named:"white.png")!, backgroundHighlightedImage: UIImage(named:"white.png")!){() -> Void in
            
            // textViewのテキストカラーを変更(Red)
            self.textView.textColor = UIColor.white
        }
        
        menuButton.addMenuItems([item1,item2,item3,item4,item5])
    }
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func slideFontSize(_ sender: Any) {
        // 文字の大きさを変更する
        let newSize = roundf(sliderView.value)
        textView.font = textView.font?.withSize(CGFloat(newSize))
    }
    
    @IBAction func dragGesture(_ sender: Any) {
        let point:CGPoint = (sender as AnyObject).translation(in: self.textView)
        
        let movedPoint:CGPoint = CGPoint(x: (sender as AnyObject).view.center.x + point.x, y: (sender as AnyObject).view.center.y + point.y)
        
        (sender as AnyObject).view.center = movedPoint
        (sender as AnyObject).setTranslation(CGPoint(x:0,y:0), in:self.textView)
        
    }
    
    // キーボードを閉じる
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if (textView.isFirstResponder){
            textView.resignFirstResponder()
        }
    }
    
    @IBAction func next(_ sender: Any) {
        
        // 全体のスクリーンショットを撮る
        let rect = UIScreen.main.bounds
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        
        let ctx = UIGraphicsGetCurrentContext()!
        ctx.fill(rect)
        self.view.layer.render(in: ctx)
        
        let data = UIImagePNGRepresentation(UIGraphicsGetImageFromCurrentImageContext()!)
        
        let capture = UIImage(data: data!)
        UIGraphicsEndImageContext()
        
        // 画像を切り取る
        let cropRect = CGRect(x:self.view.frame.origin.x, y:280, width:textView.frame.size.width*2, height:textView.frame.size.height*2)
        
        let cropRef = (capture?.cgImage!)?.cropping(to: cropRect)
        
        var cropImage = UIImage(cgImage:cropRef!)
        
        let data2 = UIImagePNGRepresentation(cropImage)
        cropImage = UIImage(data: data2!)!
        
        pathImage = cropImage
        
        // 今見えているTextViewの範囲を切り取る→UIImage
        // 画面遷移
        performSegue(withIdentifier: "filter", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "filter"){
            let filterVC:FilterViewController = segue.destination as! FilterViewController
            
            // UIImage型の変数へ画像を入れる
            filterVC.endImage = pathImage
            filterVC.hashString = hashString
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}
