//
//  KeypathObserver.swift
//  KeypathObserver
//
//  Created by NIX on 16/7/2.
//  Copyright © 2016年 nixWork. All rights reserved.
//

import Foundation

final public class KeypathObserver<Object: NSObject>: NSObject {

    weak var object: Object?
    var keypath: String

    public typealias ValueChanged = (object: Object) -> Void
    var valueChanged: ValueChanged?

    private var kvoContext: Int = 1

    deinit {
        object?.removeObserver(self, forKeyPath: keypath)
    }

    public init(object: Object, keypath: String, valueChanged: ValueChanged) {

        self.object = object
        self.keypath = keypath
        self.valueChanged = valueChanged

        super.init()

        object.addObserver(self, forKeyPath: keypath, options: [.New], context: &kvoContext)
    }

    public override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {

        guard context == &kvoContext else {
            return
        }

        guard let object = object as? Object else {
            return
        }

        if object == self.object && keypath == self.keypath {
            self.valueChanged?(object: object)
        }
    }
}

