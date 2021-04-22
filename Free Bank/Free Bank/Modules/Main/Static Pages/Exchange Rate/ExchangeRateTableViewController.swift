//
//  ExchangeRateTableViewController.swift
//  Free Bank
//
//  Created by Sasha Zontova on 2/12/21.
//

import UIKit

class RateTableViewCell: UITableViewCell {
    @IBOutlet fileprivate weak var flagImageView: UIImageView!
    @IBOutlet fileprivate weak var foreignRateLabel: UILabel!
    @IBOutlet fileprivate weak var nationalRateLabel: UILabel!
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
        changeTableBackground()
        let urlComponents = NSURLComponents(string: "https://www.nbrb.by/api/exrates/rates")!
                urlComponents.queryItems = [URLQueryItem(name: "periodicity", value: "0")]
        guard let url = urlComponents.url else {
            print("ExchangeRateTableViewController Error with url")
            return
            }
        URLSession.shared.dataTask(with: url) {(data, _, error) in
            guard let data = data else {return}
            guard error == nil else {return}
            do {
                self.currencies = try JSONDecoder().decode([Currency].self, from: data)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch let error {
                print(error)
            }
        }.resume()
    }
    func changeTableBackground() {
        self.tableView.backgroundView = UIImageView(image: UIImage(named: "mainBackground"))
    }
    // MARK: - TableViewDataSource

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return currencies.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Rate", for: indexPath) as! RateTableViewCell
        cell.selectionStyle = .none
        cell.flagImageView?.image = UIImage(named: currencies[indexPath.row].abbreviation!.lowercased())
        cell.foreignRateLabel?.text = "\(currencies[indexPath.row].scale ?? 0) \(currencies[indexPath.row].abbreviation ?? "")"
        cell.nationalRateLabel?.text = "\(currencies[indexPath.row].officialRate ?? 0.0) BYR"
        return cell
    }
    
    @IBAction private func tappedBackButton(_ sender: UIBarButtonItem) {
        dismiss(animated: false, completion: nil)
    }
}
