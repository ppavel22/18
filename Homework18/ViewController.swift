//
//  ViewController.swift
//  Homework18
//
//  Created by mac on 29.11.2017.
//  Copyright © 2017 mac. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private let mass1 : [String] = ["https://avatars.mds.yandex.net/get-pdb/38069/c08ba0b8-4f27-4830-a12a-71b83dfb1837/s800",
                                    "http://fb.ru/misc/i/gallery/45022/1588657.jpg",
                                    "https://look.com.ua/pic/201209/1600x900/look.com.ua-19447.jpg",
                                    "http://ladyelena.ru/wp-content/uploads/2013/10/malenkie-mashiny-dlya-zhenshhin.jpg"]
    
    private let mass2 : [String] = ["http://www.fainaidea.com/wp-content/uploads/2017/10/0003a709_medium-720x479.jpg",
                                    "http://ogivotnich.ru/images/stories/zhivotnye/animal.jpg",
                                    "http://www.sciencedebate2008.com/wp-content/uploads/dangerous-animals-bear.jpg",
                                    "http://veganstvo.info/uploads/posts/2017-02/1487090878_6fbea6e2a77240582b4b7fcc05781325_xl.jpg"]
    
    private let mass3 : [String] = ["http://klumba.guru/images/89469/tsvetok-v-teni.jpg",
                                    "http://www.poznavayka.org/wp-content/uploads/2014/09/tsvetyi.jpg",
                                    "https://news.uklon.com.ua/image.axd?picture=2012%2F4%2F08784953.jpg",
                                    "http://chihuashki.ru/sites/default/files/images/u6/podsolnuh.jpg",]
    
    @IBOutlet weak var thirdIndicator: UIActivityIndicatorView!
    @IBOutlet weak var secondIndicator: UIActivityIndicatorView!
    @IBOutlet weak var firstIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var thirdImage: UIImageView!
    @IBOutlet weak var secondImage: UIImageView!
    @IBOutlet weak var firstImage: UIImageView!
    private var imageIndex = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        loadImage(by: imageIndex, inArray: mass1, inImage: firstImage, ibIndicator: firstIndicator)
        loadImage(by: imageIndex, inArray: mass2, inImage: secondImage, ibIndicator: secondIndicator)
        loadImage(by: imageIndex, inArray: mass3, inImage: thirdImage, ibIndicator: thirdIndicator)
    }
    
    private func loadImage(by index: Int, inArray: [String],inImage: UIImageView, ibIndicator: UIActivityIndicatorView) {
        inImage.image = nil
        guard index >= 0, index < inArray.count else { return }
        let imageStringURL = inArray[index]
        guard let url = URL(string: imageStringURL) else { return }
        ibIndicator.isHidden = false
        ibIndicator.startAnimating()
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else {
                ibIndicator.stopAnimating()
                ibIndicator.isHidden = true
                return
            }
            let loadedImage = UIImage(data: imageData)
            DispatchQueue.main.async {
                inImage.image = loadedImage
                ibIndicator.stopAnimating()
                ibIndicator.isHidden = true
            }
        }
    }
    
    @IBAction func refreshPressed(_ sender: Any) {
        imageIndex = (imageIndex + 1) % mass3.count
        loadImage(by: imageIndex, inArray: mass1, inImage: firstImage, ibIndicator: firstIndicator)
        loadImage(by: imageIndex, inArray: mass2, inImage: secondImage, ibIndicator: secondIndicator)
        loadImage(by: imageIndex, inArray: mass3, inImage: thirdImage, ibIndicator: thirdIndicator)
    }
    
}

