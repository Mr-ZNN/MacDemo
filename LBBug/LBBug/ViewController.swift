//
//  ViewController.swift
//  LBBug
//
//  Created by 张宁宁 on 17/5/23.
//

import Cocoa

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = NSColor.red.cgColor
        setupUI()
    }
    func setupUI() {
        self.view.window?.backgroundColor = .white
        self.view.addSubview(self.scrollView)
        self.scrollView.snp.makeConstraints { make in
            make.top.left.bottom.equalToSuperview()
            make.right.equalTo(self.view.snp.centerX)
        }
    }
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    lazy var scrollView: NSScrollView = {
        let scrollView: NSScrollView = NSScrollView()
        scrollView.autoresizingMask = NSView.AutoresizingMask(rawValue: NSView.AutoresizingMask.height.rawValue | NSView.AutoresizingMask.width.rawValue)
        scrollView.documentView = self.tableView
        scrollView.hasVerticalScroller = true
        return scrollView
    }()
    lazy var tableView: NSTableView = {
        let tableView: NSTableView = NSTableView()
        tableView.backgroundColor = .cyan
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsColumnReordering = false
        tableView.allowsColumnResizing = false
        tableView.focusRingType = .none
        tableView.rowHeight = 75
        tableView.selectionHighlightStyle = .none
        tableView.headerView = nil
        //一列
        let column0 = NSTableColumn(identifier: NSUserInterfaceItemIdentifier(rawValue: "examColumn0"))
        tableView.addTableColumn(column0)
        return tableView
    }()

}

extension ViewController: NSTableViewDelegate, NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return 10
    }
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let identifier: NSUserInterfaceItemIdentifier = tableColumn?.identifier ?? NSUserInterfaceItemIdentifier(rawValue: "examColumn0")
        var cell: LBBugTableViewCell? = tableView.makeView(withIdentifier: identifier, owner: self) as? LBBugTableViewCell
        if cell == nil {
            cell = LBBugTableViewCell()
        }
        cell?.title = "\(row)"
        return cell
    }
}
