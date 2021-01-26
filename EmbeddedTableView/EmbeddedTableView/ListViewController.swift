//
//  ViewController.swift
//  EmbeddedTableView
//
//  Created by Arun Sivakumar on 10/1/21.
//

import UIKit
import Kingfisher

class ResizingTableView: UITableView {
    
    override var contentSize: CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return contentSize
    }
}

struct Widgets {
    private let colors = [UIColor.orange, UIColor.blue, UIColor.yellow, UIColor.brown]
    
    func getColor(index: Int) -> UIColor {
        let color = index == 0 ? colors.first! : colors[ index % colors.count]
        return color
    }
    
}

struct WidgetsImage {
    private let images = [ "https://images.newrepublic.com/3de3e180569a4793d166f90285ba1f3b1c3cb8c4.jpeg?auto=compress&ar=3%3A2&fit=crop&crop=faces&q=65&fm=jpg&ixlib=react-9.0.2&w=3038", "https://d9qgzi7ga3w21.cloudfront.net/04868e1c-1ab1-4d79-bef6-d542d90cca36.png", "https://d9qgzi7ga3w21.cloudfront.net/c1d8010b-ca71-434a-a5fc-df092455ac0e.jpg", "https://d9qgzi7ga3w21.cloudfront.net/adfd3e86-24a8-4776-9bda-4bd7734bc828.png"]
    
    func getImage(index: Int) -> String {
        let image = index == 0 ? images.first! : images[ index % images.count]
        return image
    }
    
}

class ListViewController: UITableViewController {
    
    let widgets = WidgetsImage()
    
    override func loadView() {
        view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        tableView = ResizingTableView()
        tableView.estimatedRowHeight = 400
        tableView.rowHeight = UITableView.automaticDimension
//        self.view.frame = CGRect(x: 0,y: 0,width: UIScreen.main.bounds.width,height: UIScreen.main.bounds.height / 2.0)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        let cellNib = UINib(nibName: "CustomTableViewCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "CustomTableViewCell")
        tableView.reloadData()
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as! CustomTableViewCell

//        let color = widgets.getColor(index: indexPath.row)
//        cell.backgroundColor = color
        
        let image = widgets.getImage(index: indexPath.row)
        let url = URL(string: image)!
        cell.cellImage.kf.setImage(with: url, placeholder: nil, options: []) { (result) in
            print("downloadedImage")
            print(result)
            var cellFrame = cell.frame.size
            switch result {
            case .success(let downloadedImage):
                cell.imageHeight.constant = self.getAspectRatioAccordingToiPhones(cellImageFrame: cellFrame,downloadedImage: downloadedImage.image)
//                cell.setNeedsLayout()
//                cell.setNeedsDisplay()
               self.tableView.reloadRows(at: [indexPath], with: .none)
            case .failure(let error):
                print("error")
            }
        }
        
        
        cell.tag = indexPath.row
        print("\(indexPath.row)")
        return cell
    }
    
    func getAspectRatioAccordingToiPhones(cellImageFrame:CGSize,downloadedImage: UIImage)->CGFloat {
        let myImageWidth = downloadedImage.size.width
        let myImageHeight = downloadedImage.size.height
        let myFrameWidth = self.view.frame.size.width

        let ratio = myFrameWidth / myImageWidth
        let scaledHeight = myImageHeight * ratio

        return scaledHeight
        }
}

