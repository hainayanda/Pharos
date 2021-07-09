# Pharos

Pharos is an Observer pattern framework for Swift that utilizes `propertyWrapper`. It could help a lot when designing Apps using reactive programming

[![codebeat badge](https://codebeat.co/badges/e4784f82-ff10-45cf-92e2-93497bb6b1a4)](https://codebeat.co/projects/github-com-nayanda1-pharos-main)
![build](https://github.com/nayanda1/Pharos/workflows/build/badge.svg)
![test](https://github.com/nayanda1/Pharos/workflows/test/badge.svg)
[![SwiftPM Compatible](https://img.shields.io/badge/SwiftPM-Compatible-brightgreen)](https://swift.org/package-manager/)
[![Version](https://img.shields.io/cocoapods/v/Pharos.svg?style=flat)](https://cocoapods.org/pods/Pharos)
[![License](https://img.shields.io/cocoapods/l/Pharos.svg?style=flat)](https://cocoapods.org/pods/Pharos)
[![Platform](https://img.shields.io/cocoapods/p/Pharos.svg?style=flat)](https://cocoapods.org/pods/Pharos)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

# Installation

## Requirements

- Swift 5.0 or higher (or 5.3 when using Swift Package Manager)
- iOS 9.3 or higher (or 10 when using Swift Package Manager)

### Only Swift Package Manager

- macOS 10.10 or higher
- tvOS 10 or higher

### Cocoapods

Pharos is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'Pharos'
```

### Swift Package Manager from XCode

- Add it using XCode menu **File > Swift Package > Add Package Dependency**
- Add **https://github.com/nayanda1/Pharos.git** as Swift Package URL
- Set rules at **version**, with **Up to Next Major** option and put **1.2.2** as its version
- Click next and wait

### Swift Package Manager from Package.swift

Add as your target dependency in **Package.swift**

```swift
dependencies: [
    .package(url: "https://github.com/nayanda1/Pharos.git", .upToNextMajor(from: "1.2.2"))
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

Nayanda Haberty, nayanda1@outlook.com

## License

Pharos is available under the MIT license. See the LICENSE file for more info.

***

# Basic Usage

Pharos is an Observer pattern framework for Swift that utilizes `propertyWrapper`. It using a builder pattern and was designed so it could be read just like the English language.

## Basic

Basically, all you need is a property that you want to observe and add `@Observable` propertyWrapper at it:

```swift
class MyClass {
    @Observable var text: String?
}
```

to observe any changes that happen in the text, use its `projectedValue` to get its main relay. and pass the closure:

```swift
class MyClass {
    @Observable var text: String?
    
    func observeText() {
        $text.whenDidSet { changes in
            print(changes.new)
            print(changes.old)
        }
    }
}
```

every time any set happens in text, it will call the closure with its changes which including old value and new value.
You could ignore any set that not changing the value as long the value is `Equatable`

```swift
class MyClass {
    @Observable var text: String?
    
    func observeText() {
        $text.whenDidUniqueSet { changes in
            print(changes.new)
            print(changes.old)
        }
    }
}
```

if you want the observer called method instead, just do something like this:

```swift
class MyClass {
    @Observable var text: String?
    
    func observeText() {
        $text.whenDidSet(invoke: self, method: MyClass.textDidChange)
    }
    
    func textDidChange(_ changes: Changes<String?>) {
        print(changes.new)
        print(changes.old)
    }
}
```

it will store self as a weak reference for the method call.

if you want the observer to run using the current value, just invoke it:

```swift
class MyClass {
    @Observable var text: String?
    
    func observeText() {
        $text.whenDidSet { changes in
            print(changes.new)
            print(changes.old)
        }.invokeRelay()
    }
}
```

## Multiple observers

By design, the Observable will have one main relay which only consists of one observer.
So if you set observer closure multiple times on Main Relay, it will only replace it but not add a new one:

```swift
class MyClass {
    @Observable var text: String?
    
    func observeText() {
        $text.whenDidSet { changes in
            print("first closure")
        }.whenDidSet { changes in
            print("will replace first closure")
        }
    }
}
```

In the example above, the first closure will be replaced by the second closure since both are assigned in Main Relay. But any relay could have multiple child relays which will be notified by the previous relay as described by the diagram below:

![alt text](https://github.com/nayanda1/Pharos/blob/main/ObservableRelay.png)

And remember, a single relay will always just have one did set listener:

![alt text](https://github.com/nayanda1/Pharos/blob/main/DidSet.png)

To use the next relay, you could just do something like this:

```swift
class MyClass {
    @Observable var text: String?
    
    func observeTextLinearly() {
        $text.whenDidSet { changes in
            print("notified by Observable")
        }.nextRelay().whenDidSet { changes in
            print("notified by Main Relay")
        }.nextRelay().whenDidSet { changes in
            print("notified by Previous Relay")
        }
    }
    
    func addRelayToMainRelay() {
        $text.nextRelay().whenDidSet {
            print("notified by Main Relay")
        }
        $text.nextRelay().whenDidSet {
            print("notified by Main Relay Too")
        }.nextRelay().whenDidSet { changes in
            print("notified by Previous Relay")
        }
    }
}
```

In the example above, all closure will be run if any set happens. The only difference between all the relays is just the one who notified it.

## Using Retainer

You could use `Retainer` to make sure the relay created will be discarded by `ARC` when `Retainer` is discarded so the closure in the relay and all of its next relays will not run if it's not used anymore:

```swift
class MyClass {
    @Observable var text: String?
    
    var retainer: Retainer = .init()
    
    func observeText() {
        $text.nextRelay()
            .referenceManaged(by: retainer)
            .whenDidSet { changes in
                print(changes.new)
                print(changes.old)
            }
    }
    
    func discardManually() {
        retainer.discardAll()
    }
    
    func discardByCreateNewRetainer() {
        retainer = .init()
    }
    
}
```

There are many ways to discard the relay managed by `Retainer`:
- call `discardAll()` from relay's retainer
- replace the retainer with a new one, which will trigger `ARC` to remove the retainer from memory thus will discard all of its managed relays by default.
- doing nothing, which if the object that has retainer is discarded by `ARC`, it will automatically discard the `Retainer` thus will discard all of its managed relays by default.

## Custom getter and setter

You can create Observable using custom getter and setter which will relay value if there's some value set to those observable.

```swift
class MyClass {
    var button: UIButton = .init()
    @Observable var title: String?
    
    func observeText() {
        _title.mutator {
            button.title(for: .normal)
        } set {
            button.setTitle($0, for: .normal)
        }
        $title.whenDidSet { changes in
            print(changes.new)
            print(changes.old)
        }.invokeRelay()
    }
}
```

In the example above, every time title is set, it will call the set closure and then relay it to its relays.

## Bondable Relays

You can observe changes in supported `UIView` property by accessing it with `bondableRelays`:

```swift
class MyClass {
    var textField: UITextField = .init()
    @Observable var text: String?
    
    func observeText() {
        $text.bonding(with: textField.bondableRelays.text)
            .whenDidSet { changes in
                print(changes.new)
                print(changes.old)
            }
    }
}
```

At the example above, every time `text` is set, it will automatically set the `textField.text`, and when  `textField.text` is set it will automatically set the `text`. On both occasions, it will always notify the `whenDidSet` closure.

The mechanism can be described by 

![alt text](https://github.com/nayanda1/Pharos/blob/main/BondingRelay.png)

If you want to bond and match both values right away, use `bondAndApply` or `bondAndMap`. the difference between both is that apply will set the `Observable` value to `Object property` and map will set the `Object property` to `Observable`

```swift
class MyClass {
    var textField: UITextField = .init()
    @Observable var text: String?
    
    func applyToField() {
        $text.bondAndApply(to: textField.bondableRelays.text)
            .whenDidSet { changes in
                print(changes.new)
                print(changes.old)
            }
    }
    
    func mapFromField() {
        $text.bondAndMap(from: textField.bondableRelays.text)
            .whenDidSet { changes in
                print(changes.new)
                print(changes.old)
            }
    }
}
```

Actually what `textField.relays.text` do is creating `AssociativeTwoWayRelay` of given object keypath. `AssociativeTwoWayRelay` is open, so you could also creating one of your own. You can always treat `AssociativeTwoWayRelay` as observable:

```swift
class MyClass {
    var relay: AssociativeTwoWayRelay<String?>

    init(textField: UITextField) {
        self.relay = textField.bondableRelays.text
    }
    
    func observeRelay() {
        relay.whenDidSet { changes in
            print(changes.new)
            print(changes.old)
        }
    }
}
```

Some of the relays are just `ValueRelay` which cannot be bond since it's not observable, but you can always use it as the next relay or next value relay:

```swift
class MyClass {
    var button: UIButton = .init()
    @Observable var buttonState: UIControl.State
    
    func relayStateToButton() {
        $buttonState.relayValue(to: button.relays.state)
    }
}
```

If you just want to observe the value without storing the relay, retain it with the source of the relay, so it will always be called until the source is removed by `ARC`. You could always use `Retainer` if you want:

```swift
class MyClass {
    var button: UIButton = .init()
    
    func observeRelay() {
        button.relays.state
            .retainToSource()
            .whenDidSet { changes in
                print(changes.new)
                print(changes.old)
            }
    }
}
```

## Ignoring Set

You can ignore set to relay by passing a closure that returning `Bool` value which indicated that value should be ignored:

```swift
class MyClass {
    @Observable var text: String?
    
    func observeText() {
        $text.whenDidSet { changes in
            print(changes.new)
            print(changes.old)
        }.ignore { $0.new?.isEmpty ?? true }
    }
}
```

At the example above, whenDidSet closure will not run when the new value is empty or null

## Delaying Multiple Set

Sometimes you just want to delay some observing because if the value is coming too fast, it could be bottleneck some of your business logic like when you call API or something. It will automatically use the latest value when the closure fire:

```swift
class MyClass {
    @Observable var text: String?
    
    func observeText() {
        $text.whenDidUniqueSet { changes in
            print(changes.new)
            print(changes.old)
        }.multipleSetDelayed(by: 1)
    }
}
```

## Add DispatchQueue

You could add `DispatchQueue` to make sure your observable is run on the right thread. If DispatchQueue is not provided, it will use the thread from the notifier:

```swift
class MyClass {
    @Observable var text: String?
    
    func observeText() {
        $text.whenDidUniqueSet { changes in
            print(changes.new)
            print(changes.old)
        }.observe(on: .main)
    }
}
```

You could make sure the closure will run synchronously if the current thread is the same as passed `DispatchQueue`:

```swift
class MyClass {
    @Observable var text: String?
    
    func observeText() {
        $text.whenDidUniqueSet { changes in
            print(changes.new)
            print(changes.old)
        }.observe(on: .main)
        .syncWhenInSameThread()
    }
}
```

## Mapping Value

You could change the value from your `Observable` to another by using mapping. Mapping will add a new Relay under the previous one:

```swift
class MyClass {
    @Observable var text: String?
    
    func observeText() {
        $text.map { $0?.count ?? 0 }
            .whenDidSet { changes in
                print("notified by Main Relay")
                print("changes now is Int with value \(changes.new)")
            }
    }
}
```

If your value is `Array`, you can use `compactMap` to map the original `Array` to target `Array`:

```swift
class MyClass {
    @Observable var array: [String] = []
    
    func observeText() {
        $array.compactMap { $0.count }
            .whenDidSet { changes in
                print("notified by Main Relay")
                print("changes now is [Int]")
            }
    }
}
```

## Relay value to another Observable

You can relay value from any Relay to another Relay as long as the type is the same. Use `relayValue(to:)` or `relayUniqueValue(to:)` if the value is `Equatable`. It will return a new Relay under the target Relay:

```swift
class MyClass {
    @Observable var text: String?
    @Observable var count: Int = 0
    @Observable var empty: Bool = true
    
    func observeText() {
        $text.map { $0?.count ?? 0 }
            .relayValue(to: $count)
            .map { $0 == 0 }
            .relayUniqueValue(to: $empty)
    }
}
```

You can always relay value to Any NSObject Bearer Relays by accessing `bearerRelays`. Its using `dynamicMemberLookup`, so all of the object writable properties will available there:

```swift
class MyClass {
    var label: UILabel = UILabel()
    @Observable var text: String?
    
    func observeText() {
        $text.relayValue(to: label.bearerRelays.text)
    }
}
```

All relay will weak referenced and will stop relaying to other Observable if that relay is dereferenced by `ARC`

## Merging Relay

You can merge up to 4 relays as one and observe if any of those relays is set:

```swift
class MyClass {
    @Observable var userName: String = ""
    @Observable var fullName: String = ""
    @Observable var password: String = ""
    @Observable var user: User = User()
    
    func observeText() {
        mergeRelays($userName, $fullName, $password)
            .whenDidSet { changes in
                print("userName: \(changes.new.0)")
                print("fullName: \(changes.new.1)")
                print("password: \(changes.new.2)")
            }.map { 
                User(
                    userName: $0.new.0, 
                    fullName: $0.new.1, 
                    password: $0.new.2
                )
            }.relayValue(to: $user)
    }
}
```

Keep in mind that merged relays will strongly referenced in a new relay. It would be wise to store the merged relays locally or using `Retainer`

***

# Contribute

You know how just clone and do pull request
