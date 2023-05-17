//
//  LBBugTableViewCell.swift
//  LBBug
//
//  Created by 张宁宁 on 17/5/23.
//

import Cocoa

class LBBugTableViewCell: NSTableCellView {

    public var title: String = "" {
        didSet {
            self.titleLabel.stringValue = title
        }
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        setupUI()
    }
    func setupUI() {
        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.centerY.equalToSuperview()
            make.right.equalTo(-10)
            make.height.lessThanOrEqualTo(30)
        }
    }
    lazy var titleLabel: NSTextField = {
        let label: NSTextField = NSTextField()
        label.isBezeled = false
        label.drawsBackground = false
        label.isEditable = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .red
        label.font = .systemFont(ofSize: 15)
        label.stringValue = "Title Label"
        label.alignment = .left
        
        return label
    }()
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
}
