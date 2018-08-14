//
//  Copyright © 2016年 xiAo_Ju. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let controllers: [UIViewController.Type] = [
        AutoResizingHeaderController.self,
        ResizeTableHeaderViewAnimatedController.self,
        SearchTableViewController.self,
        SearchTableUpgradeVC.self
    ]
    
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
        navigationItem.title = "知乎（scrollViewDidScroll）"
        tableView.contentInset.top = 140
        tableView.scrollIndicatorInsets.top = 130
        view.addSubview(tableView)
        view.addSubview(headerView)
    }
}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return controllers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.textLabel?.text = "\(controllers[indexPath.row].classForCoder())"
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = scrollView.contentOffset.y
        headerView.frame.origin.y = 64 - 204 - max(y, -204)
    }

    func maxYRelative(to superview: UIView?) -> CGFloat {
        let maxEdge = CGPoint(x: 0, y: view.bounds.height)
        let normalizedMaxEdge = superview?.convert(maxEdge, from: view) ?? .zero
        return normalizedMaxEdge.y
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = controllers[indexPath.row].init()
        controller.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(controller, animated: true)
    }
}
