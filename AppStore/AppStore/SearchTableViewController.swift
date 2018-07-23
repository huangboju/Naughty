//
//  SearchTableViewController.swift
//  AppStore
//
//  Created by 黄伯驹 on 2018/7/21.
//  Copyright © 2018 xiAo_Ju. All rights reserved.
//

import UIKit

class SearchTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let blueViewY: CGFloat = 20
    private let blueViewHeight: CGFloat = 120
    private var blueViewOffsetY: CGFloat {
        return blueViewY - blueViewHeight
    }

    private lazy var blueView: UIView = {
        let blueView = UIView(frame: CGRect(x: 0, y: blueViewY, width: self.view.frame.width, height: blueViewHeight))
        blueView.backgroundColor = .blue
        return blueView
    }()
    
    private let redViewY: CGFloat = 140
    private let redViewHeight: CGFloat = 80
    private var redViewOffsetY: CGFloat {
        return redViewY + redViewHeight
    }

    private lazy var redView: UIView = {
        let blueView = UIView(frame: CGRect(x: 0, y: redViewY, width: self.view.frame.width, height: redViewHeight))
        blueView.backgroundColor = .red
        return blueView
    }()
    
    
    private let greenViewY: CGFloat = 220
    private let greenViewHeight: CGFloat = 40
    private var greenViewOffsetY: CGFloat {
        return redViewY + redViewHeight
    }
    private lazy var greenView: UIView = {
        let greenView = UIView(frame: CGRect(x: 0, y: greenViewY, width: self.view.frame.width, height: greenViewHeight))
        greenView.backgroundColor = .green
        return greenView
    }()

    fileprivate lazy var tableView: UITableView = {
        let tableView = UITableView(frame: self.view.frame)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset.top = blueViewHeight + redViewHeight + greenViewHeight
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        
        view.addSubview(redView)
        
        view.addSubview(blueView)
        
        view.addSubview(greenView)
    }
    
    var offset: CGPoint = .zero
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        offset = scrollView.contentOffset
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if offset == .zero { return }
        
        let offsetY = scrollView.contentOffset.y + 44
        
        if offset.y < scrollView.contentOffset.y {
            // 向上滑
            blueView.frame.origin.y = blueViewY
            if offsetY >= -redViewY {
                blueView.frame.origin.y = max(blueViewY - redViewY - max(offsetY, -redViewY), blueViewOffsetY)
            }
            
            redView.frame.origin.y = max(redViewY - redViewOffsetY - max(offsetY, -redViewOffsetY), -redViewHeight)
            
            greenView.frame.origin.y = redView.frame.maxY

        } else {

            blueView.frame.origin.y += (offset.y - scrollView.contentOffset.y)
            if blueView.frame.origin.y >= blueViewY {
                blueView.frame.origin.y = blueViewY
            }
            redView.frame.origin.y = blueView.frame.maxY - redViewHeight
            
            if scrollView.contentOffset.y <= -(blueViewY + blueViewHeight + greenViewHeight) {
                redView.frame.origin.y = redViewY - redViewOffsetY - max(offsetY, -redViewOffsetY)
            }
            
            greenView.frame.origin.y = redView.frame.maxY
        }

        offset = scrollView.contentOffset
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
