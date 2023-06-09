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
        self.view.window?.isRestorable = false
        self.view.window?.center()
        self.view.window?.makeKeyAndOrderFront(self)
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = NSColor.white.cgColor
        setupUI()
        setupConfig()
    }
    func setupUI() {
        self.view.addSubview(self.scrollView)
        self.scrollView.snp.makeConstraints { make in
            make.top.equalTo(10)
            make.left.equalTo(10)
            make.right.equalTo(self.view.snp.centerX)
            make.bottom.equalTo(-50)
        }
        self.view.addSubview(self.deleteButton)
        self.deleteButton.snp.makeConstraints { make in
            make.top.equalTo(self.scrollView.snp.bottom).offset(5)
            make.right.equalTo(self.scrollView)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        self.view.addSubview(self.addButton)
        self.addButton.snp.makeConstraints { make in
            make.top.equalTo(self.deleteButton)
            make.right.equalTo(self.deleteButton.snp.left).offset(-5)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
    }
    func setupConfig() {
        NotificationCenter.default.addObserver(self, selector: #selector(windowWillClose(notification:)), name: NSWindow.willCloseNotification, object: nil)
    }
    @objc func windowWillClose(notification: Notification) {
        NSApplication.shared.stopModal()
    }
    override var representedObject: Any? {
        didSet {
            //Update the view, if already loaded.
        }
    }

    @IBAction func addbuttonEvent(_ sender: Any) {
        //方法一：正常显示窗口（只能显示关闭一次，关闭后再次打开会crash）
        self.myWindow.makeKeyAndOrderFront(self)
        self.myWindow.center()
        //方法二：模态
        //NSApplication.shared.runModal(for: self.myWindow)
        //let sessionCode = NSApplication.shared.beginModalSession(for: window)
        
    }
    lazy var bugList: [LBBugModel] = {
        var list: [LBBugModel] = []
        for i in 0..<10 {
            let model1: LBBugModel = LBBugModel()
            model1.iconName = "icon_background_image_\(i)"
            model1.name = "背景图片_\(i + 1)"
            model1.score = 0.5
            model1.imageName = "icon_background_image_\(i)"
            list.append(model1)
        }
        return list
    }()
    lazy var myWindow: NSWindow = {
        let frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        //窗口样式风格
        let style: UInt = (NSWindow.StyleMask.titled.rawValue | NSWindow.StyleMask.closable.rawValue | NSWindow.StyleMask.miniaturizable.rawValue | NSWindow.StyleMask.resizable.rawValue)
        let styleMask: NSWindow.StyleMask = NSWindow.StyleMask(rawValue: style)
        let window = NSWindow(contentRect: frame, styleMask: styleMask, backing: NSWindow.BackingStoreType.buffered, defer: true)
        //窗口的title和icon
        window.representedURL = URL(string: "WindowTitle")
        window.title = "New Create Window"
        let iconImage: NSImage = NSImage(named: "icon_background_image_0")!
        window.standardWindowButton(NSWindow.ButtonType.documentIconButton)?.image = iconImage
        //Window的背景色
        window.isOpaque = false
        window.backgroundColor = NSColor.cyan
        
        //title区域增加视图
        if let titleView: NSView = window.standardWindowButton(.closeButton)?.superview {
            let button: NSButton = NSButton()
            button.title = "Register"
            let x = (window.contentView?.frame.size.width ?? 100) - 100
            button.frame = NSRect(x: x, y: 0, width: 80, height: 24)
            button.bezelStyle = .rounded
            button.tag = 100
            titleView.addSubview(button)
        }
        
        return window
    }()
    lazy var scrollView: NSScrollView = {
        let scrollView: NSScrollView = NSScrollView()
        scrollView.autoresizingMask = NSView.AutoresizingMask(rawValue: NSView.AutoresizingMask.height.rawValue | NSView.AutoresizingMask.width.rawValue)
        scrollView.documentView = self.tableView
        scrollView.hasVerticalScroller = true
        return scrollView
    }()
    lazy var tableView: NSTableView = {
        let tableView: NSTableView = NSTableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsColumnReordering = false
        tableView.allowsColumnResizing = false
        tableView.focusRingType = .none
        tableView.rowHeight = 60
        tableView.selectionHighlightStyle = .none
        tableView.headerView = nil
        tableView.usesAlternatingRowBackgroundColors = true
        //一列
        let column0 = NSTableColumn(identifier: NSUserInterfaceItemIdentifier(rawValue: "examColumn0"))
        tableView.addTableColumn(column0)
        return tableView
    }()
    lazy var addButton: NSButton = {
        let button: NSButton = NSButton()
//        button.wantsLayer = true
        button.image = NSImage(named: NSImage.addTemplateName)
        button.bezelStyle = .roundRect
        button.setButtonType(.switch)
        return button
    }()
    lazy var deleteButton: NSButton = {
        let button: NSButton = NSButton()
        button.wantsLayer = true
        button.image = NSImage(named: NSImage.removeTemplateName)
        button.bezelStyle = .roundRect
        button.setButtonType(.momentaryPushIn)
        return button
    }()
}

extension ViewController: NSTableViewDelegate, NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return self.bugList.count
    }
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let identifier: NSUserInterfaceItemIdentifier = tableColumn?.identifier ?? NSUserInterfaceItemIdentifier(rawValue: "examColumn0")
        var cell: LBBugTableViewCell? = tableView.makeView(withIdentifier: identifier, owner: self) as? LBBugTableViewCell
        if cell == nil {
            cell = LBBugTableViewCell()
        }
        let bugModel: LBBugModel = self.bugList[row]
        cell?.configBugModel(bugModel: bugModel)
        return cell
    }
}
