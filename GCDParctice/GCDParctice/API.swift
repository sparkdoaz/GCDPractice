//
//  API.swift
//  GCDParctice
//
//  Created by 黃建程 on 2019/8/22.
//  Copyright © 2019 Spark. All rights reserved.
//

import Foundation

class GetReusltManager {
    weak var delegate: GetResultManagerDelegate?
    //5012e8ba-5ace-4821-8482-ee07c147fd0a HUANBEILAD
    
    func fetchData(no: Int) {
        var endPointComponent: URL
        
        let urlOne = "https://data.taipei/opendata/datalist/apiAccess?scope=resourceAquire&rid=5012e8ba-5ace-4821-8482-ee07c147fd0a&limit=1&offset=0"
        let urlTwo = "https://data.taipei/opendata/datalist/apiAccess?scope=resourceAquire&rid=5012e8ba-5ace-4821-8482-ee07c147fd0a&limit=1&offset=10"
        let urlThree = "https://data.taipei/opendata/datalist/apiAccess?scope=resourceAquire&rid=5012e8ba-5ace-4821-8482-ee07c147fd0a&limit=1&offset=20"
        
        switch no {
        case 0:
            endPointComponent = URL(string: urlOne)!
        case 10:
            endPointComponent = URL(string: urlTwo)!
        case 20:
            endPointComponent = URL(string: urlThree)!
        default:
            endPointComponent = URL(string: urlOne)!
        }
        
        let task = URLSession.shared.dataTask(with: endPointComponent) { (data, response, error) in
            
            guard let data = data , let utf8Text = String(data: data, encoding: .utf8) else { return}
            
            
            let decoder = JSONDecoder()
            let kkk = try? decoder.decode(DataResult.self, from: data)
            
            let datatwo = kkk?.result.results[0]
            print(datatwo)
            self.delegate?.getData(self, didGet: datatwo! )
        }
        task.resume()
    }
}

protocol GetResultManagerDelegate: AnyObject {
    func getData(_ manager: GetReusltManager, didGet save: results)
}
