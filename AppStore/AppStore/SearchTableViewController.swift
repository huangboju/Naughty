//
//  SearchTableViewController.swift
//  AppStore
//
//  Created by 黄伯驹 on 2018/7/21.
//  Copyright © 2018 xiAo_Ju. All rights reserved.
//

import UIKit

class SearchTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private lazy var blueView: UIView = {
        let blueView = UIView(frame: CGRect(x: 0, y: 20, width: self.view.frame.width, height: 80))
        blueView.backgroundColor = .blue
        return blueView
    }()
    
    private lazy var redView: UIView = {
        let blueView = UIView(frame: CGRect(x: 0, y: 100, width: self.view.frame.width, height: 40))
        blueView.backgroundColor = .red
        return blueView
    }()
    
    fileprivate lazy var tableView: UITableView = {
        let tableView = UITableView(frame: self.view.frame)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset.top = 120
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        
        view.addSubview(redView)
        
        view.addSubview(blueView)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        
        redView.frame.origin.y = 100 - 140 - max(offsetY, -140)
        blueView.frame.origin.y = 20
        if offsetY >= -100 {
            blueView.frame.origin.y = max(20 - 100 - max(offsetY, -100), -60)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
         navigationController?.setNavigationBarHidden(false, animated: true)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        cell.textLabel?.text = indexPath.description
        return cell
    }

}
