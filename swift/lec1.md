# What's in iOS?
- Cocoa Touch
    - Multi Touch
    - Core Motion
    - View Hierarchy
    - Localization
    - Controls
    - Alerts
    - Web View
    - Map Kit
    - Image Picker
    - Camera
- Media
    - Core Audio
    - OpenAL
    - Audio Mixing
    - Audio Recording
    - Video Playback
    - JPEG, PNG, TIFF
    - Quartz(2D)
    - Core Animation
    - OpenGL ES
- Core services
    - Collections
    - Address Book
    - Networking
    - File Acess
    - SQLite
    - Core location
    - Net services
    - Threading
    - Preferences
    - URL Utilities
- Core OS
    - OSX Kernel
    - Mach 3.0
    - BSD
    - Sockets
    - Security
    - Power Management
    - Keychain Access
    - Certificates
    - File system
    - Bonjour

# Platform Components
1. Tools
    - Xcode 9
    - Instruments
2. Languages
    - Swift
    - Objective C
3. Framework
    - Foundation
    - Core Data
    - UIKit
    - Core Motion
    - Map Kit
4. Design Strategy
    - MVC

# Xcode
## Single view app
- product name
- org
- org identifier
- language: swift
## Components:
- drag with control
- didset on variable ([properties observers](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Properties.html#//apple_ref/doc/uid/TP40014097-CH14-ID262))


|Struct|Class|
|-|-|
|No inheritance|Has inheritances|
|Value types (get copies)|Refernce types (get pointers)|
|||


- lazy initialize (can not get properties observers)
- .indices
- target/action and outlets and oulet collections
- Methods and Properties (aka instance variables)
- property observer (`did Set`)
- `Array<Element>`
- MVC
- Value types (struct) vs refernce type (class)
- initializes
- Type (static) methods
- lazy properties
- Dictionary<Key, Value>
- Type conversion
- Optional?
- for in loop
- Range → stride
    ```swift
    for i in stride(from: 0.5, through: 15.25, by: 0.3) {
        print(i)
    }
    ```
- Tuple:
    ```swift
    let x: (String, Int, Doule) = ("hello", 4, 2.2)
    let (a, b, c)  = x
    print a // hello
    print b // 4
    print c // 2.2
    let x: (w: String, i:Int, v: Double) = ("hello", 4, 2.2)
    print(x.w) // "Hello"
    ```
  → multiple values return
- Computed properties
    ```swift
    var foo: Double // stored property

    var foo: Double {
        get {
            // required, return the calculated value of foo
        }
        set(newValue) {
            // optional, do something based on the fact that foo has changed to newValue
        }
    }
    ```

- Access Control
    - internal, this is the default, "any object in the app can call the method"
    - private - "only callable from within this object"
    - private(set) - "this property is readable outside this object, but no settable"
    - fileprivate - accessible by any code in this source file
    - public - this can be used by object outside the framewok
    - open - public and objects outside the framework can subclass this.
    - Good strategy: mark everything private by default


- Extensions
    - Extending existing data structures
        - You can add methods/properties to a class/struct/enum (even if you dont have the source)
- There are some restrictions
    - You can not re-implement methods or properties that are already there (only add new one).
    - The properties you add can have no storage associated with them (computed only)

- Enum:
    - each state can (does not have to) have its own "asociated data"
    ```swift
    enum FastFoodMenuItem {
        case hamburger(numberOfPatties: Int)
        case fries(size: FryOrderSize)
        case drink(String, ounces: Int) // the unnamed String is the brand, e.g "Coke"
        case cookie

        func isIncludedInSpecialOrder(number: Int) -> Bool {
            switch self {
                case .hamburger(let pattyCount): return pattyCount == number
                case .fries, .cookie: return true // a drink and cookie in every special order
                case .drink(_, let ounces): return ounces == 16 // & 16oz drink of any kind
            }
         }
        var calories: Int { } // calculate and return caloric value here
        mutating func switchToBeingACookie(){
            self = .cookie // this works even if self is a .hamburger, .fries of .drink
        } // Note that mutating is required because enum is a VALUE TYPE
    }
    // Set
    let menuItem: FastFoodMenuItem = FastFoodMenuItem.hambuger(patties: 2)
    var otherItem: FastFoodMenuItem = .cookie
    // NG
    var yetAnotherItem = .cookie // Swift can not figure this out
    var menuItem = FastFoodMenuItem.hamburger (patties: 2, size: .large)
    switch menuItem {
        case .hamburger(let pattyCount): print("hamburger with \(pattyCount) of patties")
        case .fries: break
        case .drink(let brand, let ounces):
            print("drink")
            print("a \(ounces)oz \(brand)")
        default: print("other")
    }
    ```
- Optional
    ```swift
    enum Optional<T> {
        case none
        case some(<T>)
    }
    ```
    - Optional chaining
- Data structures
    - class
    - struct
    - enum
    - protocol

## class
- Swift does not use `Garbage collection` it uses `References counting`
- Influencing ARC
    - strong: normal reference counting, anywhere has a strong pointer to an instance, it will stay in the heap
    - weak: Optional pointers to references types, a weak pointer will never keep an object in the heap
        - eg: Outlets
    - unowned: do not reference count this, crash if I am wrong, avoid memory cycle.
- eg: UIKit, UIButton,....

## struct
- value type

// TODO

## enum
// TODO

## protocols
- Protocols are a way to express an API more concisely
    ```swift
    protocol SomeProtocol : InheritedProtocol1, InheritedProtocol2 {
        var someProperty: Int {get set}
        func aMethod(arg1: Double, anotherArgument: String) -> SomeType
        mutating func changeIt()
        inti (arg: Type)
    }

    protocol SomeProtocol : class, InheritedProtocol1, InheritedProtocol2 {
        // rarely use this
    }
    ```
- Class implement protocol
    ```swift
    struct SomeStruct: SomeProtocol, AnotherProtocol {
        required init(..) // if not subclass is not conform, you are allowed to add protocol conformance via an extension
    }
    ```
- Protocols are types

## Delegation

1. A view declares a delegation protocol
2. The view's API has a weak delegate property whose type is that delegation protocol
3.
## Mutating
- var is mutable
- let is inmmutable

## Protocol
- Multiple inheritance
    - CountableRange
    - Sequence - makeIterator
    - Collection - subscripting(index, offset,...)
- Array, Dictionary is implemented with these protocols so they have all of these protocols methods
- @objc func is optional (don't need to be implemented)
- Using extension to provide protocol implementation
- Functional Programming
    - by combining protocols with generics and extensions (default implementations), focuses more on the behavior of data structures that storage

## String
- index
```swift
let pizzaJoint = "café pasto"
let firstCharacterIndex = pizzaJoint.startIndex //of type String.Index
let fourthCharacterIndex = pizzaJoint.index(firstCharacterIndex, offsetBy: 3)
let fourthCharacter = pizzaJoint[fourthCharacterIndex] // é
if let firstSpace = pizzaJoint.index(of: " ") {
    // return nil if " " not found
    let secondWordIndex = pizzaJoint.index(firstSpace, offsetBy:1)
    let secondWord = pizzaJoint[secondWordIndex..<pizzaJoint.endIndex>]
}
pizzaJoint.components(separatedBy: " ")[1]
```
- String is a sequence of Character
```swift
let characterArray = Array(s)
```
- A String is a value type (struct)
- Other methods

```swift
func hasPrefix(String) -> Bool
func hasSuffix(String) -> Bool
func replaceSubrange(Range<String.Index>, with: Collection of Character)
```

- API: https://developer.apple.com/documentation/swift/string

## NSAttributedString
- A String with attributes attached to each character (color, font, number,...)
- Create
```swift
let attributes: [NSAttributedStringKey : Any] = [ // type cannot be interred here
    .strokeColor : UIColor.orage,
    .strokeWidth : 5.0// negative number here would mean fill
]
let attribtext = NSAttributedString(string: "Flips: 0", attributes: attributes)
flipCountLabel.attributedText = attribtext
```
- String and NSString is little bit different
- NSString does not contain some of Unicode character (emoji,...)

## Function Types
- Function types
    - You can declare a variable (parameter, method) to be of type "function"
    - You will declare it with the types of the functions arguments (and return type) included
    ```swift
    var operation: (Double) -> Double
    operation = sqrt // sqrt is a function that takes a Double and returns a Double
    let result = operation(4.0) // 2.0
    ```

- Closures
    - Closures are refernce type

    ```swift
    func changeSign(operand: Double) -> Double { return -operand }
    var operation: (Double) -> Double
    operation = changeSign
    let result = operation(4.0) // -4.0
    // a lot of code
    ```

    - inline function
    ```swift
    var operation: (Double) -> Double
    operation = { -$0 } // $0,$1,$2 for arguments
    let result = operation(4.0) // -4.0
    ```

    - map()
    ```swift
    let primes = [2.0, 3.0, 4,0]
    let negativePrimes = primes.map({-$0}) // [-2.0, -3.0, -4.0]
    let invertedPrimes = primes.map() { 1.0/$0 } // [0.5, 0.333, 0.2]
    let primeString = primes.map { String($0) } // ["2.0", "3.0", "4.0"]
    ```

    - property initialization
    ```swift
    var someProperty: Type = {
        // construct
        return <the contructed value>
    }
    ```

    - Capturing
        - The variables that the closure captures stay in the heap as long as the closure stays in the heap.
        -  **Can create memory cycle, be careful**


# Errors handling
```swift
func save() throws {}
do {
    try context.save()
} catch let error {
    // handling
    throw error // re-throw the error
}

try! context.save() // will crash your program

let x = try? errorProneFunctionThatReturnsAnInt() // x will be Int?

```

## Class
### casting by as?
```swift
    let unknown: Any = ...
    if let foo = unknown as? myType {
        // casting unknown to be type of myType
    }
```

### NSObject
- Objective C base object class

### NSNumber
- Objective C number class, represent any kind of number

### Date

### Data
- bag of bits

# Views
- A view represents a rectangular area (ie UIView subclass)
- Hierarchical
    - View has only one superview
    - Can have many subviews
- Most often constructed in Xcode graphically
- Can be done in code as well
- Avoid an initializer
    ```swift
    init(frame: CGRect)
    init(coder: NSCoder)
    // have to initialize them both
    ```
- awakeFromNib()

## Coordinate System Data Structures
- CGFloat
    ```swift
    let cgf = CGFloat(aDouble)
    ```
- CGPoint: a struct with two CGFloat: x and y
    ```swift
    var point = CGPoint(x: 37.0, y; 55.2)
    point.y -= 30
    point.x += 20.0
    ```
- CGSize: a struct with 2 CGFloat in it: width and height
    ```swift
    var size = CGSize(width: 100.0, height: 50.0)
    size.width += 42.5
    size.height += 75
    ```
- CGRect: a struct with a CGPoint and a CGSize in it
    ```swift
    struct CGRect {
        var origin: CGPoint
        var size: CGSize
    }
    ```
## View Coordinate System
- Origin is upper left
- Unit are points, not pixels
- var bounds: CGRect // a view's internal drawing space's origin and size

## bound vs frame
- Use frame and/or center to position a UIView

## Creating view
- Create via storyboard
- Create via code
```swift
let labelRect = CGRect(x: 20, y: 20, width: 100, height: 50)
let label = UILabel(frame: labelRect)
label.text = "Hello"
view.addSubView(label)
```
- To draw, create a UIView subclass and override draw(CGRect)
- **NEVER** call draw(CGRect) **EVER**

## Custom views
- Core Graphic Concepts
    1. You get a context to draw into by `UIGraphicsGetCurrentContext()`
    2. Creat paths
    3. Set drawing attributes like colors, fonts, textures,...
    4. Stroke or fill the above-created paths with the given attributes
- UIBezierPath
    - creat a path
        ```swift
        let path = UIBezierPath()
        ```
    - Move around
        ```swift
        path.move(to: CGPoint(80,50))
        path.addLine(to: CGPoint(140,150))
        path.addLine(to: CGPoint(10,150))
        ```
    - Close the path
        ```swift
        path.close()
        ```
    - Set attributes and stroke/fill
        ```swift
        UIColor.green.setFill()
        UIColor.red.setStroke()
        path.linewidth = 3.0
        path.fill()
        path.stroke()
        ```
- Draw common shapes with UIBezierPath
    ```swift
    let roundedRect = UIBezierPath(roundedRect: CGRect, cornerRadius: CGFloat)
    let oval = UIBezierPath(ovalIn: CGRect)
    ```

- Clipping your drawing to a UIBezierPath's path
    ```swift
    addClip()
    ```
- Hit detection
    ```swift
    func contains(-_ point:CGPoing) -> Bool // return whether the point is inside the path.
    ```
 ## UI Color
- Colors are set using UIColor
// Slide


＃MVCs
