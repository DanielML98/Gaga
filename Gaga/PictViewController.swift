//
//  PictViewController.swift
//  Gaga
//
//  Created by Daniel Martínez on 20/05/22.
//

import UIKit

class PictViewController: UIViewController {
  var item:Item?
  var imageView = UIImageView()
  var a_i = UIActivityIndicatorView()
  let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    imageView.frame = self.view.frame.insetBy(dx: 20, dy: 20)
    imageView.contentMode = .scaleAspectFit
    self.view.backgroundColor = .white
    self.view.addSubview(imageView)
    a_i.style = .large
    a_i.color = .red
    a_i.hidesWhenStopped = true
    a_i.center = self.view.center
    self.view.addSubview(a_i)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    guard let lItem = self.item else { return }
    
    if let pictureName: String = lItem.picture,
       let url = URL(string:DataManager.instance.baseURL + "/" + pictureName) {
      if photoIsDownloaded(name: pictureName) {
        let filePath = documentsURL.appendingPathComponent(pictureName).path
        guard let image = UIImage(contentsOfFile: filePath) else { return }
        self.imageView.image = image
      } else {
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
          guard error == nil else { return }
          guard let safeData = data else { return }
          let image = UIImage(data: safeData)
          self.saveImage(safeData, lItem.picture!)
          DispatchQueue.main.async {
            self.imageView.image = image
            self.a_i.stopAnimating()
          }
        }
        a_i.startAnimating()
        task.resume()
      }
    }
  }
  
  private func photoIsDownloaded(name: String) -> Bool {
    let fileURL = documentsURL.appendingPathComponent(name)
    print(fileURL.path)
    return FileManager.default.fileExists(atPath: fileURL.path)
  }
  
  private func saveImage(_ bytes: Data, _ name: String) {
    let fileURL = documentsURL.appendingPathComponent(name)
    do {
      try bytes.write(to: fileURL)
    } catch {
      print("We couldn't download the photo")
    }
  }
  
}
