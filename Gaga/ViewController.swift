//
//  ViewController.swift
//  Gaga
//
//  Created by Daniel Martínez on 20/05/22.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var tableView: UITableView!
  override func viewDidLoad() {
    tableView.dataSource = self
    tableView.delegate = self
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    DataManager.instance.info.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    var configuration = cell.defaultContentConfiguration()
    configuration.text = DataManager.instance.info[indexPath.row].title
    cell.contentConfiguration = configuration
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let vc = PictViewController()
    vc.item = DataManager.instance.info[indexPath.row]
    show(vc, sender: nil)
  }
}

