//
//  ExchangeRateTableViewController.swift
//  Free Bank
//
//  Created by Sasha Zontova on 2/12/21.
//

import UIKit

class RateTableViewCell: UITableViewCell{
    
}

class ExchangeRateTableViewController: UITableViewController {
    
    struct Currency: Codable {
        var date: String?
        var abbreviation: String?
        var scale: Int?
        var officialRate: Double?
        
        private enum CodingKeys: String, CodingKey {
            case date = "Date"
            case abbreviation = "Cur_Abbreviation"
            case scale = "Cur_Scale"
            case officialRate = "Cur_OfficialRate"
        }
    }
    
    var currencies = [Currency]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlComponents = NSURLComponents(string: "https://www.nbrb.by/api/exrates/rates")!
                urlComponents.queryItems = [URLQueryItem(name: "periodicity", value: "0")]
                
        guard let url = urlComponents.url else {
            print("ExchangeRateTableViewController Error with url")
            return
            }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Rate", for: indexPath)
        
        return cell
    }
    

    

}
