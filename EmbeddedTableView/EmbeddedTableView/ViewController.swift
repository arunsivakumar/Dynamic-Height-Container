//
//  ViewController.swift
//  EmbeddedTableView
//
//  Created by Arun Sivakumar on 11/1/21.
//

import UIKit
import Kingfisher


class ViewController: UIViewController {
    
//    struct WidgetsImage {
//        private let images = [ "https://images.newrepublic.com/3de3e180569a4793d166f90285ba1f3b1c3cb8c4.jpeg?auto=compress&ar=3%3A2&fit=crop&crop=faces&q=65&fm=jpg&ixlib=react-9.0.2&w=3038", "https://d9qgzi7ga3w21.cloudfront.net/04868e1c-1ab1-4d79-bef6-d542d90cca36.png", "https://d9qgzi7ga3w21.cloudfront.net/c1d8010b-ca71-434a-a5fc-df092455ac0e.jpg", "https://d9qgzi7ga3w21.cloudfront.net/adfd3e86-24a8-4776-9bda-4bd7734bc828.png"]
//
//        func getImage(index: Int) -> String {
//            let image = index == 0 ? images.first! : images[ index % images.count]
//            return image
//        }
//
//    }
    
    let widgets = WidgetsImage()
    
    
    @IBOutlet weak var tableViewHome :UITableView!
    override func viewDidLoad() {
        tableViewHome.register(UINib(nibName:"HomeTableViewCell",bundle:nil), forCellReuseIdentifier: "cell")
        tableViewHome.estimatedRowHeight = 400
        tableViewHome.rowHeight = UITableView.automaticDimension
        tableViewHome.dataSource = self
        tableViewHome.delegate = self
    }
}
// MARK: TableView datasource delegate
extension ViewController :UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 17
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! HomeTableViewCell
        cell.selectionStyle = .none
        //let image = UIImage(named:"\(indexPath.row+1)")
       // cell.feedImageView.image = image

        var cellFrame = cell.frame.size

        let image = widgets.getImage(index: indexPath.row)
        let url = URL(string: image)!
        cell.feedImageView.kf.setImage(with: url, placeholder: nil, options: []) { (result) in
            print("downloadedImage")
            print(result)
            var cellFrame = cell.frame.size
            switch result {
            case .success(let downloadedImage):
                cell.feedImageHeightConstraint.constant = self.getAspectRatioAccordingToiPhones(cellImageFrame: cellFrame,downloadedImage: downloadedImage.image)
                self.tableViewHome.reloadRows(at: [indexPath], with: .none)
            case .failure(let error):
                print("error")
            }
        }
        return cell
    }
    
    func getAspectRatioAccordingToiPhones(cellImageFrame:CGSize, downloadedImage: UIImage)->CGFloat {
//        let widthOffset = downloadedImage.size.width - cellImageFrame.width
//        let widthOffsetPercentage = (widthOffset*100)/downloadedImage.size.width
//        let heightOffset = (widthOffsetPercentage * downloadedImage.size.height)/100
//        let effectiveHeight = downloadedImage.size.height - heightOffset
//        return(effectiveHeight)
        
        let myImageWidth = downloadedImage.size.width
        let myImageHeight = downloadedImage.size.height
        let myFrameWidth = self.view.frame.size.width

        let ratio = myFrameWidth / myImageWidth
        let scaledHeight = myImageHeight * ratio

        return scaledHeight
        
    }
    // MARK: Optional function for resize of image
    func resizeHighImage(image:UIImage)->UIImage {
        let size = image.size.applying(CGAffineTransform(scaleX: 0.5, y: 0.5))
        let hasAlpha = false
        let scale: CGFloat = 0.0 // Automatically use scale factor of main screen
        UIGraphicsBeginImageContextWithOptions(size, !hasAlpha, scale)
        image.draw(in: CGRect(origin: .zero, size: size))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return scaledImage!

    }
}



