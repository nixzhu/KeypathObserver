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
    var centerObserver: KeypathObserver<UIView, CGPoint>?
    var colorObserver: KeypathObserver<UIView, UIColor>?

    func testKeypathObserver() {

        let view = UIView()

        self.centerObserver = KeypathObserver(
            object: view,
            keypath: "center",
            valueTransformer: { ($0 as? NSValue)?.cgPointValue },
            valueChanged: { oldCenter, newCenter in
                print("oldCenter: \(oldCenter)")
                print("newCenter: \(newCenter)")
            }
        )

        view.center = CGPoint(x: 100, y: 100)
        view.center = CGPoint(x: 200, y: 50)

        self.colorObserver = KeypathObserver(
            object: view,
            keypath: "backgroundColor",
            valueTransformer: { $0 as? UIColor },
            valueUpdated: { newColor in
                print("newColor: \(newColor)")
            }
        )

        view.backgroundColor = UIColor.red
        view.backgroundColor = nil

        self.view = view
    }
}

