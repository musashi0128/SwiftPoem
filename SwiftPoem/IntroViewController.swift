//
//  IntroViewController.swift
//  SwiftPoem
//
//  Created by 宮本一彦 on 2017/03/26.
//  Copyright © 2017年 宮本一彦. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController {

    
    @IBOutlet weak var sv: UIScrollView!
    var uv = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        uv.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width*3, height: self.view.frame.size.height)
        
        for i in 0..<3{
            let imageView:UIImageView = UIImageView()
            imageView.frame = CGRect(x: i*Int(self.view.frame.size.width), y: 0, width: Int(self.view.frame.size.width), height: Int(self.view.frame.size.height))
            
            let image:UIImage = UIImage(named: "0" + String(i+1) + ".jpg")!
            imageView.image = image
            uv.addSubview(imageView)
        }
        sv.isPagingEnabled = true
        sv.addSubview(uv)
        sv.contentSize = uv.bounds.size

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

    

}
