//
//  FilterViewController.swift
//  SwiftPoem
//
//  Created by 宮本一彦 on 2017/04/05.
//  Copyright © 2017年 宮本一彦. All rights reserved.
//

import UIKit
import Social
import ExpandingMenu

class FilterViewController: UIViewController {
    
    var hashString = String()
    
    lazy fileprivate var documentInteractionController = UIDocumentInteractionController()
    var myComposView:SLComposeViewController!
    var ciContext:CIContext!
    
    var endImage = UIImage()
    
    @IBOutlet weak var endImageView: UIImageView!
    
    @IBOutlet weak var sc: UIScrollView!
    var uv = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()

        endImageView.image = nil
        endImageView.image = endImage
        
        uv.frame = CGRect(x: 0, y: 0, width: 480, height: 80)
        
        for i in 0..<6{
            let button:UIButton = UIButton()
            button.frame = CGRect(x: i*80, y: 0, width: 70, height: 70)
            button.tag = i
            button.addTarget(self, action: #selector(tap), for: .touchUpInside)
            
            let buttonImage:UIImage = UIImage(named: String(i) + "x" + ".jpg")!
            button.setImage(buttonImage, for: UIControlState.normal)
            uv.addSubview(button)
        }
        sc.addSubview(uv)
        sc.contentSize = uv.bounds.size
        
        setSNSButton()
    }
    
    func tap(_ sender:UIButton){
        if(sender.tag == 0) {
            // filter1を適応
            filter1()
        }
        if(sender.tag == 1) {
            // filter2を適応
            filter2()
        }
        if(sender.tag == 2) {
            // filter3を適応
            filter3()
        }
        if(sender.tag == 3) {
            // filter4を適応
            filter4()
        }
        if(sender.tag == 4) {
            // filter5を適応
            filter5()
        }
        if(sender.tag == 5) {
            // filter6を適応
            filter6()
        }
    }
    
    //フィルターのメソッドを作っていく
    func filter1(){
        endImageView.image = endImage
        // image が 元画像のUIImage
        let ciImage:CIImage = CIImage(image:endImageView.image!)!;
        let ciFilter:CIFilter = CIFilter(name: "CISepiaTone")!
        ciFilter.setValue(ciImage, forKey: kCIInputImageKey)
        ciFilter.setValue(0.8, forKey: "inputIntensity")
        self.ciContext = CIContext(options: nil)
        let cgimg:CGImage = ciContext.createCGImage(ciFilter.outputImage!, from:ciFilter.outputImage!.extent)!
        
        //image2に加工後のUIImage
        let image2:UIImage = UIImage(cgImage: cgimg, scale: 1.0, orientation:UIImageOrientation.up)
        
        endImageView.image = image2
    }
    
    func filter2(){
        endImageView.image = endImage
        let ciImage:CIImage = CIImage(image:endImageView.image!)!;
        let ciFilter:CIFilter = CIFilter(name: "CIColorMonochrome")!
        ciFilter.setValue(ciImage, forKey: kCIInputImageKey)
        ciFilter.setValue(CIColor(red: 0.75, green: 0.75, blue: 0.75), forKey: "inputColor")
        ciFilter.setValue(1.0, forKey: "inputIntensity")
        self.ciContext = CIContext(options: nil)
        let cgimg:CGImage = ciContext.createCGImage(ciFilter.outputImage!, from:ciFilter.outputImage!.extent)!
        //image2に加工後のUIImage
        let image2:UIImage = UIImage(cgImage: cgimg, scale: 1.0, orientation:UIImageOrientation.up)
        endImageView.image = image2
    }
    
    func filter3(){
        endImageView.image = endImage
        let ciImage:CIImage = CIImage(image:endImageView.image!)!;
        let ciFilter:CIFilter = CIFilter(name: "CIFalseColor" )!
        ciFilter.setValue(ciImage, forKey: kCIInputImageKey)
        ciFilter.setValue(CIColor(red: 0.44, green: 0.5, blue: 0.2), forKey: "inputColor0")
        ciFilter.setValue(CIColor(red: 1, green: 0.92, blue: 0.50), forKey: "inputColor1")
        self.ciContext = CIContext(options: nil)
        let cgimg:CGImage = ciContext.createCGImage(ciFilter.outputImage!, from:ciFilter.outputImage!.extent)!
        //image2に加工後のUIImage
        let image2:UIImage = UIImage(cgImage: cgimg, scale: 1.0, orientation:UIImageOrientation.up)
        endImageView.image = image2
    }
    
    func filter4(){
        endImageView.image = endImage
        let ciImage:CIImage = CIImage(image:endImageView.image!)!;
        let ciFilter:CIFilter = CIFilter(name: "CIColorControls" )!
        ciFilter.setValue(ciImage, forKey: kCIInputImageKey)
        ciFilter.setValue(1.0, forKey: "inputSaturation")
        ciFilter.setValue(0.5, forKey: "inputBrightness")
        ciFilter.setValue(3.0, forKey: "inputContrast")
        self.ciContext = CIContext(options: nil)
        let cgimg:CGImage = ciContext.createCGImage(ciFilter.outputImage!, from:ciFilter.outputImage!.extent)!
        //image2に加工後のUIImage
        let image2:UIImage = UIImage(cgImage: cgimg, scale: 1.0, orientation:UIImageOrientation.up)
        endImageView.image = image2
    }
    
    func filter5(){
        endImageView.image = endImage
        let ciImage:CIImage = CIImage(image:endImageView.image!)!;
        let ciFilter:CIFilter = CIFilter(name: "CIToneCurve" )!
        ciFilter.setValue(ciImage, forKey: kCIInputImageKey)
        ciFilter.setValue(CIVector(x: 0.0, y: 0.0), forKey: "inputPoint0")
        ciFilter.setValue(CIVector(x: 0.25, y: 0.1), forKey: "inputPoint1")
        ciFilter.setValue(CIVector(x: 0.5, y: 0.5), forKey: "inputPoint2")
        ciFilter.setValue(CIVector(x: 0.75, y: 0.9), forKey: "inputPoint3")
        ciFilter.setValue(CIVector(x: 1.0, y: 1.0), forKey: "inputPoint4")
        self.ciContext = CIContext(options: nil)
        let cgimg:CGImage = ciContext.createCGImage(ciFilter.outputImage!, from:ciFilter.outputImage!.extent)!
        //image2に加工後のUIImage
        let image2:UIImage = UIImage(cgImage: cgimg, scale: 1.0, orientation:UIImageOrientation.up)
        endImageView.image = image2
    }
    
    func filter6(){
        endImageView.image = endImage
        let ciImage:CIImage = CIImage(image:endImageView.image!)!;
        let ciFilter:CIFilter = CIFilter(name: "CIHueAdjust" )!
        ciFilter.setValue(ciImage, forKey: kCIInputImageKey)
        ciFilter.setValue(3.14, forKey: "inputAngle")
        self.ciContext = CIContext(options: nil)
        let cgimg:CGImage = ciContext.createCGImage(ciFilter.outputImage!, from:ciFilter.outputImage!.extent)!
        //image2に加工後のUIImage
        let image2:UIImage = UIImage(cgImage: cgimg, scale: 1.0, orientation:UIImageOrientation.up)
        endImageView.image = image2
    }

    
    // SNSへ投稿する
    func setSNSButton(){
        
        let menuButtonSize:CGSize = CGSize(width: 64.0, height: 64.0)
        let menuButton = ExpandingMenuButton(frame: CGRect(origin:CGPoint(x:0,y:0), size:menuButtonSize), centerImage: UIImage(named:"next.png")!, centerHighlightedImage: UIImage(named:"next.png")!)
        
        menuButton.center = CGPoint(x:self.view.bounds.width - 32.0, y: self.view.bounds.height - 32.0)
        menuButton.menuTitleDirection = .left
        view.addSubview(menuButton)
        
        
        let item1 = ExpandingMenuItem(size: menuButtonSize, title: "Instagramへシェア", image: UIImage(named:"instagram.png")!, highlightedImage: UIImage(named:"instagram.png")!, backgroundImage: UIImage(named:"instagram.png")!, backgroundHighlightedImage: UIImage(named:"instagram.png")!){() -> Void in
            
            self.postInstagram()
        }
        
        let item2 = ExpandingMenuItem(size: menuButtonSize, title: "Facebookへシェア", image: UIImage(named:"facebook.png")!, highlightedImage: UIImage(named:"facebook.png")!, backgroundImage: UIImage(named:"facebook.png")!, backgroundHighlightedImage: UIImage(named:"facebook.png")!){() -> Void in
            
            self.postFacebook()
        }
        
        let item3 = ExpandingMenuItem(size: menuButtonSize, title: "Twitterへシェア", image: UIImage(named:"twitter.png")!, highlightedImage: UIImage(named:"twitter.png")!, backgroundImage: UIImage(named:"twitter.png")!, backgroundHighlightedImage: UIImage(named:"twitter.png")!){() -> Void in
            
            self.postTwitter()
        }
        
        menuButton.addMenuItems([item1,item2,item3])
    }
    
    func postTwitter(){
        myComposView = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
        
        let string = hashString
        myComposView.setInitialText(string)
        myComposView.add(endImageView.image)
        
        //表示
        self.present(myComposView, animated: true, completion: nil)
    }
    
    func postFacebook(){
        myComposView = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
        
        let string = hashString
        myComposView.setInitialText(string)
        myComposView.add(endImageView.image)
        
        //表示
        self.present(myComposView, animated: true, completion: nil)
    }
    
    func postInstagram(){
        let fileURL = URL(fileURLWithPath: NSHomeDirectory()).appendingPathComponent("Documents/image.igo")
        
        if let jpegData = UIImageJPEGRepresentation(endImageView.image!, 80){
            try! jpegData.write(to: fileURL, options: [.atomic])
        }
        
        //表示
        self.documentInteractionController = UIDocumentInteractionController.init(url:fileURL)
        self.documentInteractionController.uti = "com.instagram.exclusivegram"
        
        if UIApplication.shared.canOpenURL(URL.init(string: "instagram:/app")! as URL){
            self.documentInteractionController.presentOpenInMenu(from: self.view.frame, in: self.view, animated: true)
        }else{
            print("Instagramが登録されたいません")
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    

}
