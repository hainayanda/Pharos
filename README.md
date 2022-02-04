# Pharos

Pharos is an Observer pattern framework for Swift that utilizes `propertyWrapper`. It could help a lot when designing Apps using reactive programming

[![codebeat badge](https://codebeat.co/badges/e4784f82-ff10-45cf-92e2-93497bb6b1a4)](https://codebeat.co/projects/github-com-hainayanda-pharos-main)
![build](https://github.com/hainayanda/Pharos/workflows/build/badge.svg)
![test](https://github.com/hainayanda/Pharos/workflows/test/badge.svg)
[![SwiftPM Compatible](https://img.shields.io/badge/SwiftPM-Compatible-brightgreen)](https://swift.org/package-manager/)
[![Version](https://img.shields.io/cocoapods/v/Pharos.svg?style=flat)](https://cocoapods.org/pods/Pharos)
[![License](https://img.shields.io/cocoapods/l/Pharos.svg?style=flat)](https://cocoapods.org/pods/Pharos)
[![Platform](https://img.shields.io/cocoapods/p/Pharos.svg?style=flat)](https://cocoapods.org/pods/Pharos)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

- Swift 5.0 or higher (or 5.3 when using Swift Package Manager)
- iOS 9.3 or higher (or 10 when using Swift Package Manager)

### Only Swift Package Manager

- macOS 10.10 or higher
- tvOS 10 or higher

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
- Set rules at **version**, with **Up to Next Major** option and put **2.0.0** as its version
- Click next and wait

### Swift Package Manager from Package.swift

Add as your target dependency in **Package.swift**

```swift
dependencies: [
    .package(url: "https://github.com/hainayanda/Pharos.git", .upToNextMajor(from: "2.0.0"))
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

Basically, all you need is a property that you want to observe and add `@Observable` propertyWrapper at it:

```swift
class MyClass {
    @Observable var text: String?
}
```

to observe any changes that happen in the text, use its `projectedValue` to get its `Observable`. and pass the closure subscriber:

```swift
class MyClass {
    @Observable var text: String?
    
    func observeText() {
        $text.whenDidSet { changes in
            print(changes.new)
            print(changes.old)
        }.retain()
    }
}
```

every time any set happens in text, it will call the closure with its changes which including old value and new value.
You could ignore any set that not changing the value as long the value is `Equatable`

```swift
class MyClass {
    @Observable var text: String?
    
    func observeText() {
        $text.ignoreSameValue()
            .whenDidSet { changes in
                print(changes.new)
                print(changes.old)
            }.retain()
    }
}
```

if you want the observer to run using the current value, just invoke it:

```swift
class MyClass {
    @Observable var text: String?
    
    func observeText() {
        $text.whenDidSet { changes in
            print(changes.new)
            print(changes.old)
        }.retain()
        .notifyWithCurrentValue()
    }
}
```

you can always check the current value by accessing the observable property:

```swift
class MyClass {
    @Observable var text: String = "my text"
    
    func printCurrentText() {
        print(text)
    }
}
```

## Control Subscriber Retaining

By default, if you observing Observable and end it with `retain()`. The closure will be retained by the Observable itself. It will automatically removed by `ARC` if the Observable is removed by `ARC`.
If you want to handle the retaining manually, you could always use `Retainer` to retain the observer:

```swift
class MyClass {
    @Observable var text: String?
    
    var retainer: Retainer = .init()
    
    func observeText() {
        $text.whenDidSet { changes in
            print(changes.new)
            print(changes.old)
        }
        .retained(by: retainer)
    }
    
    func discardManually() {
        retainer.discardAll()
    }
    
    func discardByCreateNewRetainer() {
        retainer = .init()
    }
    
}
```

There are many ways to discard the subscriber managed by `Retainer`:

- call `discardAll()` from subscriber's retainer
- replace the retainer with a new one, which will trigger `ARC` to remove the retainer from memory thus will discard all of its managed subscribers by default.
- doing nothing, which if the object that has retainer is discarded by `ARC`, it will automatically discard the `Retainer` thus will discard all of its managed subscribers by default.

You can always control how long you want to retain by using various retain methods:

```swift
class MyClass {

    @Observable var text: String?
    
    var retainer: Retainer = .init()
    
    func observeTextOnce() {
        $text.whenDidSet { changes in
            print(changes.new)
            print(changes.old)
        }
        .retainUntilNextState()
    }
    
    func observeTextTenTimes() {
        $text.whenDidSet { changes in
            print(changes.new)
            print(changes.old)
        }
        .retainUntil(nextEventCount: 10)
    }
    
    func observeTextForOneMinutes() {
        $text.whenDidSet { changes in
            print(changes.new)
            print(changes.old)
        }
        .retain(for: 60)
    }
    
    func observeTextUntilFoundMatches() {
        $text.whenDidSet { changes in
            print(changes.new)
            print(changes.old)
        }
        .retainUntil {
            $0.new == "found!"
        }
    }
    
}
```

## Bindable

You can observe changes in supported `UIView` property by accessing its observables in `bindables`:

```swift
class MyClass {
    var textField: UITextField = .init()
    
    func observeText() {
        textField.bindables.text.whenDidSet { changes in
            print(changes.new)
            print(changes.old)
        }.retain()
    }
}
```

you can always bind two subject to notify each others as long its types is `BindableObservable`:

```swift
class MyClass {
    var textField: UITextField = .init()
    @Observable var text: String?
    
    func observeText() {
        $text.bind(with: textField.bindables.text)
            .retain()
    }
}
```

At the example above, every time `text` is set, it will automatically set the `textField.text`, and when  `textField.text` is set it will automatically set the `text`.

## Filtering Subscription

You can ignore set to observable by passing a closure that returning `Bool` value which indicated that value should be ignored:

```swift
class MyClass {
    @Observable var text: String
    
    func observeText() {
        $text.ignore { $0.new.isEmpty }
            .whenDidSet { changes in
                print(changes.new)
                print(changes.old)
            }.retain()
    }
}
```

At the example above, whenDidSet closure will not run when the new value is empty

The oppposite of ignore is `onlyInclude`

```swift
class MyClass {
    @Observable var text: String
    
    func observeText() {
        $text.onlyInclude { $0.new.count > 5 }
            .whenDidSet { changes in
                print(changes.new)
                print(changes.old)
            }.retain()
    }
}
```

At the example above, whenDidSet closure will only run when the new value is bigger than 5

## Delaying Multiple Set

Sometimes you just want to delay some observing because if the value is coming too fast, it could be bottleneck some of your business logic like when you call API or something. It will automatically use the latest value when the closure fire:

```swift
class MyClass {
    @Observable var text: String?
    
    func observeText() {
        $text.whenDidSet { changes in
            print(changes.new)
            print(changes.old)
        }.multipleSetDelayed(by: 1)
        .retain()
    }
}
```

## Add DispatchQueue

You could add `DispatchQueue` to make sure your observable is run on the right thread. If `DispatchQueue` is not provided, it will use the thread from the notifier:

```swift
class MyClass {
    @Observable var text: String?
    
    func observeText() {
        $text.whenDidSet { changes in
            print(changes.new)
            print(changes.old)
        }.observe(on: .main)
        .retain()
    }
}
```

It will always run the subscriber in the same `DispatchQueue` given. If it already in the same `DispatchQueue`, it will run synchronously. Otherwise it will run asynchronously.

You could always make sure the closure will always run asynchronously if needed:

```swift
class MyClass {
    @Observable var text: String?
    
    func observeText() {
        $text.whenDidSet { changes in
            print(changes.new)
            print(changes.old)
        }.observe(on: .main)
        .asynchronously()
        .retain()
    }
}
```

## Mapping Value

You could map the value from your `Subject` to another type by using mapping. Mapping will creating a new Observable with mapped type:

```swift
class MyClass {
    @Observable var text: String
    
    func observeText() {
        $text.mapped { $0.count }
            .whenDidSet { changes in
                print("text character count is \(changes.new)")
            }.retain()
    }
}
```

You could always map and ignore error or nil during mapping. Did set closure will always be called when mapping is succeed:

```swift
class MyClass {
    @Observable var text: String?
    
    func observeText() {
        $text.compactMap { $0?.count }
            .whenDidSet { changes in
                // this will not run if text is nil
                print("text character count is \(changes.new)")
            }.retain()
    }
}
```

## Relay value to another Observable

You can relay value from any Observable to another Observable as long as the type is the same and the other observable is `BindableObservable`:

```swift
class MyClass {
    @Observable var text: String?
    @Observable var count: Int = 0
    @Observable var empty: Bool = true
    
    func observeText() {
        $text.compactMap { $0?.count }
            .relayChanges(to: $count)
            .retain()
    }
}
```

You can always relay value to Any NSObject Bearer Observables by accessing `relayables`. Its using `dynamicMemberLookup`, so all of the object writable properties will available there:

```swift
class MyClass {
    var label: UILabel = UILabel()
    @Observable var text: String?
    
    func observeText() {
        $text.relayChanges(to: label.relayables.text)
            .retain()
    }
}
```

## Merge Observable

You can merge as much observables as long their type subject type is the same:

```swift
class MyClass {
    @Observable var subject1: String = ""
    @Observable var subject2: String = ""
    @Observable var subject3: String = ""
    @Observable var subject4: String = ""
    
    func observeText() {
        $subject1.merge(with: $subject2, $subject3, $subject4)
            .whenDidSet { changes in
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
    @Observable var userName: String = ""
    @Observable var fullName: String = ""
    @Observable var password: String = ""
    @Observable var user: User = User()
    
    func observeText() {
        $userName.combine(with: $fullName, $password)
            .map { 
                User(
                    userName: $0.new.0, 
                    fullName: $0.new.1, 
                    password: $0.new.2
                )
            }.observableValue(to: $user)
            .retain()
    }
}
```

***

## Contribute

You know how. Just clone and do pull request
