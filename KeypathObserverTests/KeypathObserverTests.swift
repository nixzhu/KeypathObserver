//
//  KeypathObserverTests.swift
//  KeypathObserverTests
//
//  Created by NIX on 16/7/2.
//  Copyright © 2016年 nixWork. All rights reserved.
//

import XCTest
import UIKit
@testable import KeypathObserver

class KeypathObserverTests: XCTestCase {

    var view: UIView?
    var frameObserver: KeypathObserver<UIView>?

    func testKeypathObserver() {

        let view = UIView()

        self.frameObserver = KeypathObserver(object: view, keypath: "frame") { view in
            print("view.frame: \(view.frame)")
        }

        view.frame = CGRect(x: 50, y: 100, width: 100, height: 100)
        view.frame = CGRect(x: 0, y: 0, width: 200, height: 200)

        self.view = view
    }
}

