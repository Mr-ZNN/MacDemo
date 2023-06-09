//
//  AppDelegate.swift
//  LBBug
//
//  Created by 张宁宁 on 17/5/23.
//

import Cocoa
import SnapKit

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }
    //关闭最后一个window或者应用唯一一个window时退出
//    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
//        return true
//    }
    //应用关闭后，点击dock菜单再次打开应用
    func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
        //self.window?.makeKeyAndOrderFront(self)
        return true
    }

}

