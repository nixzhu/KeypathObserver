//
//  KeypathObserver.swift
//  KeypathObserver
//
//  Created by NIX on 16/7/2.
//  Copyright © 2016年 nixWork. All rights reserved.
//

import Foundation

final public class KeypathObserver<Object: NSObject, Value>: NSObject {

    private weak var object: Object?
    private var keypath: String

    public typealias ValueTransformer = (_ originalValue: AnyObject) -> Value?
    private var valueTransformer: ValueTransformer

    public typealias ValueChanged = (_ oldValue: Value?, _ newValue: Value?) -> Void
    private var valueChanged: ValueChanged?

    public typealias ValueUpdated = (_ newValue: Value?) -> Void
    private var valueUpdated: ValueUpdated?

    private var kvoContext: Int = 1

    deinit {
        object?.removeObserver(self, forKeyPath: keypath)
    }

    public init(object: Object, keypath: String, options: NSKeyValueObservingOptions? = nil, valueTransformer: @escaping ValueTransformer, valueChanged: @escaping ValueChanged) {

        self.object = object
        self.keypath = keypath
        self.valueTransformer = valueTransformer
        self.valueChanged = valueChanged

        super.init()

        object.addObserver(self, forKeyPath: keypath, options: options ?? [.initial, .old, .new], context: &kvoContext)
    }

    public init(object: Object, keypath: String, options: NSKeyValueObservingOptions? = nil, valueTransformer: @escaping ValueTransformer, valueUpdated: @escaping ValueUpdated) {

        self.object = object
        self.keypath = keypath
        self.valueTransformer = valueTransformer
        self.valueUpdated = valueUpdated

        super.init()

        object.addObserver(self, forKeyPath: keypath, options: options ?? [.new], context: &kvoContext)
    }

    public override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {

        guard context == &kvoContext else {
            return
        }

        guard let object = object as? Object else {
            return
        }

        guard object == self.object && keypath == self.keypath, let change = change else {
            return
        }

        let newValue: Value?
        if let originalNewValue = change[NSKeyValueChangeKey.newKey] {
            newValue = valueTransformer(originalNewValue as AnyObject)
        } else {
            newValue = nil
        }

        if let valueChanged = self.valueChanged {

            let oldValue: Value?
            if let originalOldValue = change[NSKeyValueChangeKey.oldKey] {
                oldValue = valueTransformer(originalOldValue as AnyObject)
            } else {
                oldValue = nil
            }

            valueChanged(oldValue, newValue)

        } else {
            self.valueUpdated?(newValue)
        }
    }
}

