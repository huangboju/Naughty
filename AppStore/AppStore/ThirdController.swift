//
//  Copyright © 2016年 xiAo_Ju. All rights reserved.
//

import UIKit

class ThirdController: UIViewController {
    
    fileprivate lazy var tableView: UITableView = {
        let tableView = UITableView(frame: self.view.frame)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()

    fileprivate lazy var headerView: UIView = {
        let headerView = UIView(frame: CGRect(x: 0, y: 64, width: self.view.frame.width, height: 130))
        headerView.backgroundColor = UIColor.red
        return headerView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "知乎（观察者）"
        tableView.contentInset.top = 140
        tableView.scrollIndicatorInsets.top = 130
        view.addSubview(tableView)
        view.addSubview(headerView)
        
        tableView.addObserver(self, forKeyPath: "contentOffset", options: [.new, .old], context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentOffset" {
            let y = tableView.contentOffset.y
            headerView.frame.origin.y = 64 - 204 - max(y, -204)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ThirdController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    }
}

extension ThirdController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.textLabel?.text = indexPath.row.description
    }
}

