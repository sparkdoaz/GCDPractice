//
//  ViewController.swift
//  GCDParctice
//
//  Created by 黃建程 on 2019/8/22.
//  Copyright © 2019 Spark. All rights reserved.
//
import Foundation
import UIKit

class ViewController: UIViewController {
    
    let group = DispatchGroup()
    
    let queue = DispatchQueue(label: "hihi")
    
    let urlOne = URL(string:"https://data.taipei/opendata/datalist/apiAccess?scope=resourceAquire&rid=5012e8ba-5ace-4821-8482-ee07c147fd0a&limit=1&offset=0" )
    
    let urlTwo = URL(string: "https://data.taipei/opendata/datalist/apiAccess?scope=resourceAquire&rid=5012e8ba-5ace-4821-8482-ee07c147fd0a&limit=1&offset=10")
    let urlThree = URL(string: "https://data.taipei/opendata/datalist/apiAccess?scope=resourceAquire&rid=5012e8ba-5ace-4821-8482-ee07c147fd0a&limit=1&offset=20")
    
    var save: [results] = []

    @IBOutlet weak var labelOne: UILabel!
    @IBOutlet weak var labelOneSpeed: UILabel!
    @IBOutlet weak var labelTwo: UILabel!
    @IBOutlet weak var labelTwoSpeed: UILabel!
    @IBOutlet weak var labelThree: UILabel!
    @IBOutlet weak var labelThreeSpeed: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let mana = GetReusltManager()
        mana.delegate = self
        
//        DispatchQueue.global().async {
//            let group = DispatchGroup()
//
//        }
        
        
        
        
//        mana.fetchData(no: 0)
//        mana.fetchData(no: 10)
//        mana.fetchData(no: 20)
        
        
        
    }
    func semaOne() {
        URLSession.shared.dataTask(with: urlOne!) { (data, _, error) in
            guard let data = data , let utf8Text = String(data: data, encoding: .utf8) else { return}
            
            
            let decoder = JSONDecoder()
            let kkk = try? decoder.decode(DataResult.self, from: data)
            
            let datatwo = kkk?.result.results[0]
            
            self.labelOne.text = datatwo?.road
            
            }.resume()
    }
    
    func semaTwo() {
        URLSession.shared.dataTask(with: urlTwo!) { (data, _, error) in
            guard let data = data , let utf8Text = String(data: data, encoding: .utf8) else { return}
            
            
            let decoder = JSONDecoder()
            let kkk = try? decoder.decode(DataResult.self, from: data)
            
            let datatwo = kkk?.result.results[0]
            
            self.labelTwo.text = datatwo?.road
            
            }.resume()
    }
    
    func semaThree() {
        
        
            URLSession.shared.dataTask(with: self.urlThree!) { [weak self](data, _, error) in
                guard let data = data , let utf8Text = String(data: data, encoding: .utf8) else { return}
                
                
                let decoder = JSONDecoder()
                let kkk = try? decoder.decode(DataResult.self, from: data)
                
                let datatwo = kkk?.result.results[0]
                
                self?.labelThree.text = datatwo?.road
                
                }.resume()
        
        
        
        
    }
    
    let semaphore = DispatchSemaphore(value: 1)
    @IBAction func clikcSemaphore() {
        
        //weak self add before parameter
        
        queue.async {
            
            
            
            
        }
        
    }
    
    @IBAction func clikc() {
        group.enter()
        
        URLSession.shared.dataTask(with: urlOne!) { (data, _, error) in
            guard let data = data , let utf8Text = String(data: data, encoding: .utf8) else { return}
            
            
            let decoder = JSONDecoder()
            let kkk = try? decoder.decode(DataResult.self, from: data)
            
            let datatwo = kkk?.result.results[0]
            
            //SORTED
            self.save.insert(datatwo!, at: 0)
            self.group.leave()
            }.resume()
        
        
        group.enter()
        
        URLSession.shared.dataTask(with: urlTwo!) { (data, _, error) in
            guard let data = data , let utf8Text = String(data: data, encoding: .utf8) else { return}
            
            
            let decoder = JSONDecoder()
            let kkk = try? decoder.decode(DataResult.self, from: data)
            
            let datatwo = kkk?.result.results[0]
            
            //SORTED
//            if self.save.count == 0 {
//                self.save.append(datatwo!)
//            } else {
//                self.save.insert(datatwo!, at: 1)
//            }
            self.save.append(datatwo!)
            
            
            self.group.leave()
            }.resume()
        
        group.enter()
        
        URLSession.shared.dataTask(with: urlThree!) { (data, _, error) in
            guard let data = data , let utf8Text = String(data: data, encoding: .utf8) else { return}
            
            
            let decoder = JSONDecoder()
            let kkk = try? decoder.decode(DataResult.self, from: data)
            
            let datatwo = kkk?.result.results[0]
//            if self.save.count == 0 {
                self.save.append(datatwo!)
//            } else {
            
//            }
            
            self.group.leave()
            }.resume()
        
        group.notify(queue: .main) {
            [weak self ] in
            print(self?.save.count) //斷點下在這邊後，直接 po save.count是找不到 save，因為 closure 只抓著self.再利用self找到 self.save
            //並且要證明 group有成功就在這邊下斷點去 po self.save.count是否為3
            self?.labelOne.text = self!.save[0].road
            self?.labelTwo.text = self!.save[1].road
            self?.labelThree.text = self!.save[2].road
            self?.labelOneSpeed.text = self!.save[0].sppedLimit
            self?.labelTwoSpeed.text = self!.save[1].sppedLimit
            self?.labelThreeSpeed.text = self!.save[2].sppedLimit
        }
    }


}

extension ViewController: GetResultManagerDelegate {
    func getData(_ manager: GetReusltManager, didGet save: results) {
        self.save.append(save)
    }
    
    
    
}
