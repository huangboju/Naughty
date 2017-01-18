//
//  SecondViewController.swift
//  AppStore
//
//  Created by 伯驹 黄 on 2017/1/18.
//  Copyright © 2017年 xiAo_Ju. All rights reserved.
//

import UIKit

class SecondViewController: UITableViewController {
    
    fileprivate lazy var headerView: UIView = {
        let headerView = UIView(frame: CGRect(x: 0, y: 64, width: self.view.frame.width, height: 130))
        headerView.backgroundColor = UIColor.red
        return headerView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "APP Store"

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.tableHeaderView = headerView
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let y = tableView.contentOffset.y
        if y <= -64 {
            tableView.tableHeaderView?.frame.origin.y = y + 64
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
