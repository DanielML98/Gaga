//
//  DataManager.swift
//  Gaga
//
//  Created by Daniel Martínez on 20/05/22.
//

import Foundation

struct Item: Codable {
  let picture: String?
  let title: String?
  
  enum CodingKeys: String, CodingKey {
    case picture = "pict"
    case title
  }
}

class DataManager: NSObject {
  static let instance = DataManager()
  
  override private init() {
    super.init()
    getInfo()
  }
  let baseURL = "http://janzelaznog.com/DDAM/iOS/gaga"
  var info = [Item]()
  func getInfo() {
    if let url = URL(string: baseURL + "/info.json") {
      do {
        let bytes = try Data(contentsOf: url)
        self.info = try JSONDecoder().decode([Item].self, from: bytes)
        print(self.info)
      } catch {
        print("Ocurrió un error \(error.localizedDescription)")
      }
    }
  }
}
