<p>
<a href="http://cocoadocs.org/docsets/KeypathObserver"><img src="https://img.shields.io/cocoapods/v/KeypathObserver.svg?style=flat"></a>
<a href="https://github.com/Carthage/Carthage/"><img src="https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat"></a>
</p>

# KeypathObserver

KVO observing with simple syntax.

## Requirements

Swift 2.2, iOS 8.0

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
            keypath: "center",
            valueTransformer: { ($0 as? NSValue)?.CGPointValue() },
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

        view.backgroundColor = UIColor.redColor()
        view.backgroundColor = nil

        self.view = view
    }
}
```

## Installation

It's recommended to use CocoaPods or Carthage.

### CocoaPods

``` ogdl
pod 'KeypathObserver', '~> 0.5.0'
```

### Carthage

```ogdl
github "nixzhu/KeypathObserver" >= 0.5.0
```

## Contact

NIX [@nixzhu](https://twitter.com/nixzhu)

## License

KeypathObserver is available under the [MIT License][mitLink]. See the LICENSE file for more info.

[mitLink]:http://opensource.org/licenses/MIT
