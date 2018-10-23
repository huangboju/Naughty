//
//  SearchTableUpgradeVC.swift
//  AppStore
//
//  Created by xiAo_Ju on 2018/8/14.
//  Copyright © 2018 xiAo_Ju. All rights reserved.
//

//
//  SearchTableViewController.swift
//  AppStore
//
//  Created by 黄伯驹 on 2018/7/21.
//  Copyright © 2018 xiAo_Ju. All rights reserved.
//

import UIKit

class SearchTableUpgradeVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var totalHeight: CGFloat {
        return blueViewHeight + redViewHeight + greenViewHeight + blueViewY
    }
    
    private let blueViewY: CGFloat = 0
    private let blueViewHeight: CGFloat = 120
    
    private lazy var blueView: UIView = {
        let blueView = UIView(frame: CGRect(x: 0, y: blueViewY, width: self.view.frame.width, height: blueViewHeight))
        blueView.backgroundColor = .blue
        return blueView
    }()
    
    private var redViewY: CGFloat {
        return blueViewY + blueViewHeight
    }
    private let redViewHeight: CGFloat = 80
    
    private lazy var redView: UIView = {
        let blueView = UIView(frame: CGRect(x: 0, y: redViewY, width: self.view.frame.width, height: redViewHeight))
        blueView.backgroundColor = .red
        return blueView
    }()
    
    
    private var greenViewY: CGFloat {
        return redViewY + redViewHeight
    }
    private let greenViewHeight: CGFloat = 40
    private lazy var greenView: UIView = {
        let greenView = UIView(frame: CGRect(x: 0, y: greenViewY, width: self.view.frame.width, height: greenViewHeight))
        greenView.backgroundColor = .green
        return greenView
    }()
    
    fileprivate lazy var tableView: UITableView = {
        let tableView = UITableView(frame: self.view.frame)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset.top = totalHeight
        tableView.scrollIndicatorInsets.top = tableView.contentInset.top
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        
        view.addSubview(redView)
        
        view.addSubview(blueView)
        
        view.addSubview(greenView)
        
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
    }
    
    var offset: CGPoint = .zero
    var velocity: CGPoint = .zero
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        offset = scrollView.contentOffset
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if offset == .zero { return }
        
        let offsetY = scrollView.contentOffset.y
        let totalHeight = self.totalHeight
        
        if offset.y < offsetY {
            // 向上滑
            
            if offsetY <= -greenViewHeight {
                blueView.frame.origin.y = blueViewY
                if offsetY + totalHeight >= redViewHeight {
                    blueView.frame.origin.y = blueViewY - (offsetY + totalHeight - redViewHeight)
                }
                
                redView.frame.origin.y = min(redViewY - (offsetY + totalHeight), redViewY)
                
            } else {
                blueView.frame.origin.y += (offset.y - offsetY)
                blueView.frame.origin.y = max(-blueViewHeight, blueView.frame.minY)
                redView.frame.origin.y = blueView.frame.maxY - redViewHeight
            }
        } else {
            if velocity.y <= -1 {
                blueView.frame.origin.y += (offset.y - offsetY)
                if blueView.frame.minY >= blueViewY {
                    blueView.frame.origin.y = blueViewY
                }
                redView.frame.origin.y = blueView.frame.maxY - redViewHeight
                
                if scrollView.contentOffset.y <= -(redViewY + greenViewHeight) {
                    redView.frame.origin.y = min(redViewY - (offsetY + totalHeight), redViewY)
                }
            }
        }
        
        greenView.frame.origin.y = redView.frame.maxY
        
        offset = scrollView.contentOffset
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        self.velocity = velocity
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
        return 200
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        cell.textLabel?.text = indexPath.description
        return cell
    }
    
}

