# Pharos

Pharos is Observer pattern framework for Swift that utilize `propertyWrapper`

![build](https://github.com/nayanda1/Pharos/workflows/build/badge.svg)
![test](https://github.com/nayanda1/Pharos/workflows/test/badge.svg)
[![Version](https://img.shields.io/cocoapods/v/Pharos.svg?style=flat)](https://cocoapods.org/pods/Pharos)
[![License](https://img.shields.io/cocoapods/l/Pharos.svg?style=flat)](https://cocoapods.org/pods/Pharos)
[![Platform](https://img.shields.io/cocoapods/p/Pharos.svg?style=flat)](https://cocoapods.org/pods/Pharos)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

- Swift 5.1 or higher
- iOS 10.0 or higher

### Cocoapods

Pharos is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'Pharos'
```

### Swift Package Manager

First, create a Package.swift file and add this github url. It should look like:

```swift
dependencies: [
    .package(url: "https://github.com/nayanda1/Pharos.git", from: "1.0.0")
]
```

Then run swift build to build the dependency before you use it

## Author

Nayanda Haberty, nayanda1@outlook.com

## License

Pharos is available under the MIT license. See the LICENSE file for more info.

***

# Basic Usage

Pharos is Observer pattern framework for Swift that utilize `propertyWrapper`. It using builder pattern and designed so it could be read just like english language.

## Basic

Basically all you need is property that you want to be obeserved and add `@Observable` propertyWrapper at it:

```swift
class MyClass {
    @Observable var text: String?
}
```

to observe any changes happens in the text, use its projectedValue to get its main relay. and pass the closure:

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

everytime any set happens in text, it will call the closure with its changes which including old value and new value.
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

it will store self as weak reference for the method call.

## Bonding using KVO

You can observe changes in any `NSObject` property that are compatible with `KVO` like most of `UIView` properties using `KeyPath`:

```swift
class MyClass {
    var textField: UITextField = .init()
    @Observable var text: String?
    
    func observeText() {
        $text.bond(with: textField, \.text)
            .whenDidSet { changes in
                print(changes.new)
                print(changes.old)
            }
    }
}
```

At the example above, everytime `text` is set, it will automatically set the `textField.text`, and when  `textField.text` is set it will automatically set the `text`. On both occasion it will always notify the `whenDidSet` closure.

If you want to bond and match both value right away, use `bondAndApply` or `bondAndMap`. the difference between both is apply will set the `Observable` value to `Object property` and map will set the `Object property` to `Observable`

```swift
class MyClass {
    var textField: UITextField = .init()
    @Observable var text: String?
    
    func applyToField() {
        $text.bondAndApply(to: textField, \.text)
            .whenDidSet { changes in
                print(changes.new)
                print(changes.old)
            }
    }
    
    func mapFromField() {
        $text.bondAndMap(from: textField, \.text)
            .whenDidSet { changes in
                print(changes.new)
                print(changes.old)
            }
    }
}
```

## Delaying Multiple Set

Sometimes you just want to delay some observing because if the value is coming too fast, it could be bottleneck some of your business logic like when you call API or something. It will automatically use latest value when the closure fire:

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

You could make sure the the closure will run synchronously if the current thread is the same as passed `DispatchQueue`:

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

## Add DispatchQueue

You could add `DispatchQueue` to make sure your observable is run on right thread. If DispatchQueue is not provided, it will use the thread from the notifier:
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

## Multiple observer

By design the Observable will have one main relay which only consist of one observer.
So if you set observer closure multiple time on Main Relay, it will only replace it but not add a new one:

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

At example above, first closure will replaced by second closure since both are assigned in Main Relay. But any relay could have multiple child relay which will notified by the previous relay:

**Observable -> Main Relay -> Multiple Next Relay -> ... -> Multiple Next Relay**

To use next relay, you could just do something like this:

```swift
class MyClass {
    @Observable var text: String?
    
    func observeTextLinearly() {
        $text.whenDidSet { changes in
            print("notified by Observable")
        }.addNext().whenDidSet { changes in
            print("notified by Main Relay")
        }.addNext().whenDidSet { changes in
            print("notified by Previous Relay")
        }
    }
    
    func addRelayToMainRelay() {
        $text.addNext().whenDidSet {
            print("notified by Main Relay")
        }
        $text.addNext().whenDidSet {
            print("notified by Main Relay Too")
        }.addNext().whenDidSet { changes in
            print("notified by Previous Relay")
        }
    }
}
```

At example above, all closure will be run if any set happens. The only difference between all the relay is just the one who notified it.

## Mapping Value

You could change the value from your `Observable` to another by using mapping. Mapping will add new Relay under previous one:

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

## Relay value to another Observable

You can relay value from any Relay to another Relay as long as the type is the same. Use `relayValue(to:)` or `relayUniqueValue(to:)` if the value is `Equatable`. It will return new Relay under the target Relay:

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

All relay will weak referenced and will stop relaying to other Observable if those relay is dereferenced by `ARC`

## Merging Relay

You can merge up to 4 relay as one and observe if any of those relay is set:

```swift
class MyClass {
    @Observable var userName: String = ""
    @Observable var fullName: String = ""
    @Observable var password: String = ""
    @Observable var user: User = ""
    
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

Keep in mind that merged relays will strong referenced in new relay.

## Using Dereferencer

You could use `Dereferencer` to make sure the relay created will discarded by `ARC` when `Dereferencer` is discarded so the closure in the relay will not run if its not used anymore:

```swift
class MyClass {
    @Observable var text: String?
    
    var dereferencer: Dereferencer = .init()
    
    func observeText() {
        $text.addNext(with: dereferencer)
            .whenDidSet { changes in
                print(changes.new)
                print(changes.old)
            }
    }
    
    func discardManually() {
        dereferencer.discardAll()
    }
    
    func discardByCreateNewDereferencer() {
        dereferencer = .init()
    }
    
}
```

`discardAll` will invalidate all relay associated with those `Dereferencer`. But `discardAll` not necessarily needed to invalidate relay since everytime `Dereferencer` is discarded by `ARC`, it will automatically invalidate all relay associated with those `Dereferencer`.

***

## Contribute

You know how, just clone and do pull request
