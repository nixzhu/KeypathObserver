<p>
<a href="http://cocoadocs.org/docsets/KeypathObserver"><img src="https://img.shields.io/cocoapods/v/KeypathObserver.svg?style=flat"></a>
<a href="https://github.com/Carthage/Carthage/"><img src="https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat"></a>
</p>

# KeypathObserver

KVO observing with simple syntax.

## Requirements

Swift 3.0, iOS 8.0

(Swift 2.3, use version 0.6.0)

## Example

``` swift
class ViewController: UIViewController {

    var view: UIView?
    var centerObserver: KeypathObserver<UIView, CGPoint>?
    var colorObserver: KeypathObserver<UIView, UIColor>?

    override func viewDidLoad() {
        super.viewDidLoad()

        let view = UIView()

        self.centerObserver = KeypathObserver(
            object: view,
            keypath: #keyPath(UIView.center),
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
            keypath: #keyPath(UIView.backgroundColor),
            valueTransformer: { $0 as? UIColor },
            valueUpdated: { newColor in
                print("newColor: \(newColor)")
            }
        )

        view.backgroundColor = UIColor.redColor()
        view.backgroundColor = nil

        self.view = view
    }
}
```

## Installation

### Carthage

```ogdl
github "nixzhu/KeypathObserver" >= 1.0.0
```

#### CocoaPods

``` ogdl
pod 'KeypathObserver', '~> 1.0.0'
```

# Contact

NIX [@nixzhu](https://twitter.com/nixzhu)

## License

KeypathObserver is available under the [MIT License][mitLink]. See the LICENSE file for more info.

[mitLink]:http://opensource.org/licenses/MIT
