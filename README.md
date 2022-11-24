<p align="center">
  <img width="256" height="256" src="Pharos.png"/>
</p>

# Pharos

Pharos is an Observer pattern framework for Swift that utilizes `propertyWrapper`. It could help a lot when designing Apps using reactive programming. Under the hood, it utilize [Chary](https://github.com/hainayanda/Chary) as DispatchQueue utilities

[![Codacy Badge](https://app.codacy.com/project/badge/Grade/2d5055e1fe68483ea6a7c131990bf2d3)](https://www.codacy.com/gh/hainayanda/Pharos/dashboard?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=hainayanda/Pharos&amp;utm_campaign=Badge_Grade)
![build](https://github.com/hainayanda/Pharos/workflows/build/badge.svg)
![test](https://github.com/hainayanda/Pharos/workflows/test/badge.svg)
[![SwiftPM Compatible](https://img.shields.io/badge/SwiftPM-Compatible-brightgreen)](https://swift.org/package-manager/)
[![Version](https://img.shields.io/cocoapods/v/Pharos.svg?style=flat)](https://cocoapods.org/pods/Pharos)
[![License](https://img.shields.io/cocoapods/l/Pharos.svg?style=flat)](https://cocoapods.org/pods/Pharos)
[![Platform](https://img.shields.io/cocoapods/p/Pharos.svg?style=flat)](https://cocoapods.org/pods/Pharos)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

- Swift 5.0 or higher (or 5.5 when using Swift Package Manager)
- iOS 12.0 or higher

### Only Swift Package Manager

- macOS 12.0 or higher
- tvOS 12.0 or higher

## Installation

### Cocoapods

Pharos is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'Pharos'
```

### Swift Package Manager from XCode

- Add it using XCode menu **File > Swift Package > Add Package Dependency**
- Add **<https://github.com/hainayanda/Pharos.git>** as Swift Package URL
- Set rules at **version**, with **Up to Next Major** option and put **4.0.0** as its version
- Click next and wait

### Swift Package Manager from Package.swift

Add as your target dependency in **Package.swift**

```swift
dependencies: [
    .package(url: "https://github.com/hainayanda/Pharos.git", .upToNextMajor(from: "4.0.0"))
]
```

Use it in your target as `Pharos`

```swift
 .target(
    name: "MyModule",
    dependencies: ["Pharos"]
)
```

## Author

Nayanda Haberty, hainayanda@outlook.com

## License

Pharos is available under the MIT license. See the LICENSE file for more info.

***

## Basic Usage

All you need is a property that you want to observe and add `@Subject` propertyWrapper at it:

```swift
class MyClass {
    @Subject var text: String?
}
```

to observe any changes that happen in the text, use its `projectedValue` to get its `Observable`. and pass the closure subscriber:

```swift
class MyClass {
    @Subject var text: String?
    
    func observeText() {
        $text.observeChange { changes in
            print(changes.new)
            print(changes.old)
        }.retain()
    }
}
```

every time any set happens in text, it will call the closure with its changes which include old value and new value.
You could ignore any set that does not changing the value as long the value is `Equatable`

```swift
class MyClass {
    @Subject var text: String?
    
    func observeText() {
        $text.distinct()
            .observeChange { changes in
                print(changes.new)
                print(changes.old)
            }.retain()
    }
}
```

if you want the observer to run using the current value, just fire it:

```swift
class MyClass {
    @Subject var text: String?
    
    func observeText() {
        $text.observeChange { changes in
            print(changes.new)
            print(changes.old)
        }.retain()
        .fire()
    }
}
```

if you want to ignore observing the old value, use `observe` instead:

```swift
class MyClass {
    @Subject var text: String?
    
    func observeText() {
        $text.observe { newValue in
            print(newValue)
        }.retain()
    }
}
```

you can always check the current value by accessing the observable property:

```swift
class MyClass {
    @Subject var text: String = "my text"
    
    func printCurrentText() {
        print(text)
    }
}
```

## Control Subscriber Retaining

By default, if you observe Observable and end it with `retain()`. The closure will be retained by the Observable itself. It will automatically be removed by `ARC` if the Observable is removed by `ARC`.
If you want to retain the closure with custom object, you could always do something like this:

```swift
class MyClass {
    @Subject var text: String?
    
    func observeText() {
        $text.observeChange { changes in
            print(changes.new)
            print(changes.old)
        }
        .retained(by: self)
    }
}
```

At the example above, the closure will be retained by MyClass instance and will be removed if the instance is removed by ARC.

If you want to handle the retaining manually, you could always use `Retainer` to retain the observer:

```swift
class MyClass {
    @Subject var text: String?
    
    var retainer: Retainer = .init()
    
    func observeText() {
        $text.observeChange { changes in
            print(changes.new)
            print(changes.old)
        }
        .retained(by: retainer)
    }
    
    func discardManually() {
        retainer.discardAllRetained()
    }
    
    func discardByCreateNewRetainer() {
        retainer = .init()
    }
    
}
```

There are many ways to discard the subscriber managed by `Retainer`:

- call `discardAllRetained()` from subscriber's retainer
- replace the retainer with a new one, which will trigger `ARC` to remove the retainer from memory thus will discard all of its managed subscribers by default.
- doing nothing, which if the object that has retainer is discarded by `ARC`, it will automatically discard the `Retainer` thus will discard all of its managed subscribers by default.

You can always control how long you want to retain by using various retain methods:

```swift
class MyClass {

    @Subject var text: String?
    
    var retainer: Retainer = .init()
    
    func observeTextOnce() {
        $text.observeChange { changes in
            print(changes.new)
            print(changes.old)
        }
        .retainUntilNextState()
    }
    
    func observeTextTenTimes() {
        $text.observeChange { changes in
            print(changes.new)
            print(changes.old)
        }
        .retainUntil(nextEventCount: 10)
    }
    
    func observeTextForOneMinutes() {
        $text.observeChange { changes in
            print(changes.new)
            print(changes.old)
        }
        .retain(for: 60)
    }
    
    func observeTextUntilFoundMatches() {
        $text.observeChange { changes in
            print(changes.new)
            print(changes.old)
        }
        .retainUntil {
            $0.new == "found!"
        }
    }
    
}
```

Use this retain capability wisely, since if you're not aware how the ARC work it can introduced retain cycle.

## UIControl

You can observe event in `UIControl` as long as in iOS by call `observeEventChange`, or by using `whenDidTriggered(by:)` if you want to observe specific event or for more specific `whenDidTapped` for touchUpInside event:

```swift
myButton.observeEventChange { changes in
  print("new event: \(changes.new) form old event: \(changes.old)")
}.retain()

myButton.whenDidTriggered(by: .touchDown) { _ in
  print("someone touch down on this button")
}.retain()

myButton.whenDidTapped { _ in
  print("someone touch up on this button")
}.retain()
```

## Bindable

You can observe changes in supported `UIView` property by accessing its observables in `bindables`:

```swift
class MyClass {
    var textField: UITextField = .init()
    
    func observeText() {
        textField.bindables.text.observeChange { changes in
            print(changes.new)
            print(changes.old)
        }.retain()
    }
}
```

you can always bind two Observables to notify each other:

```swift
class MyClass {
    var textField: UITextField = .init()
    @Subject var text: String?
    
    func observeText() {
        $text.bind(with: textField.bindables.text)
            .retain()
    }
}
```

At the example above, every time `text` is set, it will automatically set the `textField.text`, and when `textField.text` is set it will automatically set the `text`.

## Filtering Subscription

You can filter value by passing a closure that returning `Bool` value which indicated that value should be ignored:

```swift
class MyClass {
    @Subject var text: String
    
    func observeText() {
        $text.ignore { $0.isEmpty }
            .observeChange { changes in
                print(changes.new)
                print(changes.old)
            }.retain()
    }
}
```

At the example above, `observeChange` closure will not run when the new value is empty

The opposite of ignore is `filter`

```swift
class MyClass {
    @Subject var text: String
    
    func observeText() {
        $text.filter { $0.count > 5 }
            .observeChange { changes in
                print(changes.new)
                print(changes.old)
            }.retain()
    }
}
```

At the example above, observeChange closure will only run when the new value is bigger than 5

## Throttling

Sometimes you just want to delay some observing because if the value is coming too fast, it could be bottleneck some of your business logic like when you call API or something. It will automatically use the latest value when the closure fire:

```swift
class MyClass {
    @Subject var text: String?
    
    func observeText() {
        $text.throttled(by: 1)
            .observeChange { changes in
                print(changes.new)
                print(changes.old)
            }
            .retain()
    }

    func test() { 
        text = "this will trigger the observable and block observer for next 1 second"
        text = "this will be stored in pending but will be replaced by next set"
        text = "this will be stored in pending but will be replaced by next set too"
        text = "this will be stored in pending and be used at next 1 second"
    }
}
```

## Add DispatchQueue

You could add `DispatchQueue` to make sure your observable is run on the right thread. If `DispatchQueue` is not provided, it will use the thread from the notifier:

```swift
class MyClass {
    @Subject var text: String?
    
    func observeText() {
        $text.dispatch(on: .main)
            .observeChange { changes in
                print(changes.new)
                print(changes.old)
            }
            .retain()
    }
}
```

It will make all the subscriber after this dispatch call to be run asyncrhonously in the given `DispatchQueue`

You could make it synchronous if its already in the same `DispatchQueue` by use `observe(on:)`:

```swift
class MyClass {
    @Subject var text: String?
    
    func observeText() {
        $text.observe(on: .main)
            .observeChange { changes in
                print(changes.new)
                print(changes.old)
            }
            .retain()
    }
}
```

## Mapping Value

You could map the value from your `Subject` to another type by using mapping. Mapping will create a new Observable with mapped type:

```swift
class MyClass {
    @Subject var text: String
    
    func observeText() {
        $text.mapped { $0.count }
            .observeChange { changes in
                print("text character count is \(changes.new)")
            }.retain()
    }
}
```

You could always map and ignore errors or nil during mapping. Did set closure will always be called when mapping is successful:

```swift
class MyClass {
    @Subject var text: String?
    
    func observeText() {
        $text.compactMapped { $0?.count }
            .observeChange { changes in
                // this will not run if text is nil
                print("text character count is \(changes.new)")
            }.retain()
    }
}
```

## Observable Block

You can always create `Observable` from code block by using `ObservableBlock`:

```swift
let myObservableFromBlock = ObservableBlock { accept in
    runSomethingAsync { result in
        accept(result)
    }
}

myObservableFromBlock.observeChange { changes in
    print(changes)
}.retain()
```

## Publisher

Publisher is the Observable that only used for Publishing value

```swift
let myPublisher = Publisher<Int>()

...
...

// it will then publish 10 to all of its subscriber
myPublisher.publish(10)
```

## Relay value to another Observable

You can relay value from any Observable to another Observable:

```swift
class MyClass {
    @Subject var text: String?
    @Subject var count: Int = 0
    @Subject var empty: Bool = true
    
    func observeText() {
        $text.compactMap { $0?.count }
            .relayChanges(to: $count)
            .retain()
    }
}
```

You can always relay value to Any NSObject Bearer Observables by accessing `relayables`. Its using `dynamicMemberLookup`, so all of the object writable properties will be available there:

```swift
class MyClass {
    var label: UILabel = UILabel()
    @Subject var text: String?
    
    func observeText() {
        $text.relayChanges(to: label.relayables.text)
            .retain()
    }
}
```

## Merge Observable

You can merge as many observables as long their type subject type is the same:

```swift
class MyClass {
    @Subject var subject1: String = ""
    @Subject var subject2: String = ""
    @Subject var subject3: String = ""
    @Subject var subject4: String = ""
    
    func observeText() {
        $subject1.merged(with: $subject2, $subject3, $subject4)
            .observeChange { changes in
                // this will run if any of merged observable is set
                print(changes.new)
            }.retain()
    }
}
```

## Combine Observable

You can combine up to 4 observables as one and observe if any of those observables is set:

```swift
class MyClass {
    @Subject var userName: String = ""
    @Subject var fullName: String = ""
    @Subject var password: String = ""
    @Subject var user: User = User()
    
    func observeText() {
        $userName.combine(with: $fullName, $password)
            .mapped { 
                User(
                    userName: $0.new.0 ?? "", 
                    fullName: $0.new.1 ?? "", 
                    password: $0.new.2 ?? ""
                )
            }.relayChanges(to: $user)
            .retain()
    }
}
```

It will generate Observable of all combined value but optional, since some value might not be there when one of the observable is triggered. To make sure that it will only called triggered when all of the combined value is available, you can use `compactCombine` instead

```swift
class MyClass {
    @Subject var userName: String = ""
    @Subject var fullName: String = ""
    @Subject var password: String = ""
    @Subject var user: User = User()
    
    func observeText() {
        $userName.compactCombine(with: $fullName, $password)
            .mapped { 
                User(
                    userName: $0.new.0, 
                    fullName: $0.new.1, 
                    password: $0.new.2
                )
            }.relayChanges(to: $user)
            .retain()
    }
}
```

It will not triggered until all the observable is emiting a value.

***

## Contribute

You know-how. Just clone and do pull request
