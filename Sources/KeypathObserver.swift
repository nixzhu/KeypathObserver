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

    public typealias ValueTransformer = (originalValue: AnyObject) -> Value?
    private var valueTransformer: ValueTransformer

    public typealias ValueChanged = (oldValue: Value?, newValue: Value?) -> Void
    private var valueChanged: ValueChanged?

    public typealias ValueUpdated = (newValue: Value?) -> Void
    private var valueUpdated: ValueUpdated?

    private var kvoContext: Int = 1

    deinit {
        object?.removeObserver(self, forKeyPath: keypath)
    }

    public init(object: Object, keypath: String, options: NSKeyValueObservingOptions? = nil, valueTransformer: ValueTransformer, valueChanged: ValueChanged) {

        self.object = object
        self.keypath = keypath
        self.valueTransformer = valueTransformer
        self.valueChanged = valueChanged

        super.init()

        object.addObserver(self, forKeyPath: keypath, options: options ?? [.Initial, .Old, .New], context: &kvoContext)
    }

    public init(object: Object, keypath: String, options: NSKeyValueObservingOptions? = nil, valueTransformer: ValueTransformer, valueUpdated: ValueUpdated) {

        self.object = object
        self.keypath = keypath
        self.valueTransformer = valueTransformer
        self.valueUpdated = valueUpdated

        super.init()

        object.addObserver(self, forKeyPath: keypath, options: options ?? [.New], context: &kvoContext)
    }

    public override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {

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
        if let originalNewValue = change[NSKeyValueChangeNewKey] {
            newValue = valueTransformer(originalValue: originalNewValue)
        } else {
            newValue = nil
        }

        if let valueChanged = self.valueChanged {

            let oldValue: Value?
            if let originalOldValue = change[NSKeyValueChangeOldKey] {
                oldValue = valueTransformer(originalValue: originalOldValue)
            } else {
                oldValue = nil
            }

            valueChanged(oldValue: oldValue, newValue: newValue)

        } else {
            self.valueUpdated?(newValue: newValue)
        }
    }
}

