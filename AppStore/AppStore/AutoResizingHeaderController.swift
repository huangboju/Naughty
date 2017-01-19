//
//  ResizeTableHeaderViewAnimatedController.swift
//  AppStore
//
//  Created by 伯驹 黄 on 2017/1/18.
//  Copyright © 2017年 xiAo_Ju. All rights reserved.
//

import UIKit

class AutoResizingHeaderController: UITableViewController {
    
    fileprivate lazy var headerView: HeaderView = {
        let headerView = HeaderView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 220), target: self, action: #selector(addMoreText), secondAction: #selector(makeThisTaller))
        headerView.backgroundColor = UIColor.cyan
        return headerView
    }()

    override func viewDidLayoutSubviews() {
        // viewDidLayoutSubviews is called when labels change.
        super.viewDidLayoutSubviews()
        sizeHeaderToFit(tableView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableHeaderView = headerView

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
    }
    
    func addMoreText() {
        headerView.textLabel.text! += "\n\(headerView.textLabel.text!)"
    }
    
    func makeThisTaller() {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    }
}

extension UIViewController {
    
    /** Resize a tableView header to according to the auto layout of its contents.
     - This method can resize a headerView according to changes in a dynamically set text label. Simply place this method inside viewDidLayoutSubviews.
     - To animate constrainsts, wrap a tableview.beginUpdates and .endUpdates, followed by a UIView.animateWithDuration block around constraint changes.
     */
    func sizeHeaderToFit(_ tableView: UITableView) {
        if let headerView = tableView.tableHeaderView {
            let height = headerView.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height
            headerView.frame.size.height = height
            tableView.tableHeaderView = headerView
            headerView.setNeedsLayout()
            headerView.layoutIfNeeded()
        }
    }
    
}
