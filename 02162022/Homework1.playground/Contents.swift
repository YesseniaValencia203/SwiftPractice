/*
 What is the difference between var and let?
    •    let: used to make a constant; value doesn’t need to be known at compile-time but value must be assigned exactly once
    •    var is used to define a variable that is mutable and can be re-assigned to a different value
*/

let name = "Yessenia" // can't be changed past this assignment
var age = 43

/*
What is an optional?
    •    An optional is used when the value may not be initialized or assigned to a value. If the value is absent, the default value would be nil
    •    Either there is a value, and you can unwrap the optional to access it or there isn’t one at all
    •    Int? Would be used to indicate an optional that may contain an Int value or nil
    •    Implicitly Unwrapped Optionals: useful when an optional’s value is confirmed to exist immediately after the optional is defined and be assumed to exist
    ⁃    Primary use is class initialization
 */
var serverResponseCode: Int? = 404
serverResponseCode = nil
var surveyAnswer: String? // default is nil

let possibleString: String? = "optional string"
let forcedString: String = possibleString!

let assumedString: String! = "Implicitly Unwrapped Optional"
let implicitString: String = assumedString // gives permission for optional to be force-unwrapped if needed

 
 /*
Optional Chaining vs Optional Binding
    •    Optional Binding: used when you want to find out if the optional has a value and, if so, to extract the value to another temporary variable
    ⁃    Can be used with if and while statements to check value inside optional and extract value
    ⁃    Alternative to forced unwrapping, which has greater potential for runtime errors if a nil value is encountered
    •    Optional Chaining: process used to call method, properties , and subscripts that may or may not contain a value. As long as nil values aren’t encountered, queries can be chained together.  However, if a single call returns a nil value, the entire chain fails
    ⁃    Used when a call to access a property may fail due to an optional property that has not been initialized with an appropriate value and a nil value is encountered instead
*/

let possibleNumber = "232"

// forced unwrapping
// let convertedNumber = Int(possibleNumber) // inferred to be of type Int?

// optional binding
if let actualNum = Int(possibleNumber) {
    print("The string \"\(possibleNumber)\" has an integer value of \(actualNum)")
} else {
    print("The string \"\(possibleNumber)\" couldn't be converted to an integer")
}



/*
Unwrapping an Optional
    •    Forced unwrapping: !
    ⁃    not safe if used to access an non-existent optional value. Leads to runtime error
    ⁃    should only be used if the optional is guaranteed to contain a value
    •    Optional Binding: ?
    ⁃    ensures the existence of an optional value before it is assigned to another variable or constant
    ⁃    safer alternative to forced unwrapping
*/

/*
Closure:
    •    self-contained blocks of functionality that can be passed around and used in your code
    •    Global functions are closures that have names and don’t capture any values
    •    Nested functions are closures that have name and can capture values from their enclosing function
    •    Closure expressions are unnamed closures written in a lightweight syntax that can capture values from the surrounding context; optimizations to have clean and brief syntax
    ⁃    Inferring parameter and return value types from context
    ⁃    implicit returns from single-expression closures
    ⁃    Shorthand argument names
    ⁃    Trailing closure syntax
    •    Capture and store references to any constants and variables from the context in which they are defined, which can then be referred and modified from with8in its body, regardless of whether the original scope exists
    •    reference-type which means when you assign a closure to a constant or variable, the contents aren’t being referred to but the choice of closure
    •    @escaping: Indicated that the closure is allowed to escape
    ⁃    A closure is said to escape a function when the closure is passed as an argument to the function but is called after function returns
*/

let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
// in: indicates that the definition of closure's parameters and return type has finished and body is about to begin
var reversedNames = names.sorted(by: { (s1: String, s2: String) -> Bool in return s1 > s2 })

var reversedNames1 = names.sorted(by: { s1, s2 in return s1 > s2 }) // inferring type from context
var reversedNames2 = names.sorted(by: { s1, s2 in s1 > s2 }) // implicit returns
var reversedNames3 = names.sorted(by: { $0 > $1 }) // Shorthand Argument Names

var completionHandlers: [ () -> Void ] = []

// someFuncWithEscapingClosure(_:) takes a closure as an arg and adds it to array declared outside the function
func someFuncWithEscapingClosure(completionHandler: @escaping () -> Void) {
    completionHandlers.append(completionHandler)
}

/*
Difference between class and structure
    •    Both are general-purpose, flexible constructions that can be used as building blocks with properties and methods that add functionality
    •    Can both define properties to store values, methods to provide functionality, initializers to set up initial state, and subscripts to provide access to the values
    •    Class:
    ⁃    Class Inheritance: enables one class to inherit characteristics of another class
    ⁃    Type-casting: enables you to check and interpret the type of a class instance at runtime
    ⁃    Deinitializers: enable an instance of a class to free up resources it has assigned
    ⁃    Reference type: when they are assigned to variable or constant, a reference to the existing instance is used (memory address)
    ⁃    Reference-counting: allows more than one reference to a class instance
    ⁃    Objective-C Interoperability: if you use an Objective-C API to process data, use classes and class inheritance since it could be expected
    ⁃    Use when you need your instances to have this identity
    ⁃    When you share class instance across app, changes to the instance are visible to every part of code that holds reference to that instance
    •    Structures:
    ⁃    Default: use to represent common kinds of data
    ⁃    structures can adopt protocols to gain behavior through default implementation
    ⁃    Protocol inheritance: protocols permit classes, structures, and enums to participate
    ⁃    Value-type: the value is copied when it is assigned or passed to function, not memory address
    ⁃    If you assign an instance of a structure to a constant, the instance’s properties can’t be modified  because structures are value types; if instance is marked as constant, its properties are all constant as well, regardless of whether or not it was declared as a variable
    ⁃    Use when you don’t control identity; when you’re modeling data that contains info about an entity with an identity you don’t control
 */
struct Resolution {
    var width  = 0
    var height = 0
}

class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}

let someResolution = Resolution()
let someVideoMode = VideoMode()
print(someResolution.width)
print(someVideoMode.resolution.width)
someVideoMode.resolution.width = 1280
// Memberwise Initializers are automatically generated for structures
let vga = Resolution(width: 640, height: 480)



/*
??:  Nil-coalescing operator
    •    operator that is used to provide default value in case the optional value is missing
    •    unwraps an optional if it contains a value, else it returns a default value if it is nil
*/
let defaultColorName = "red"
var userDefinedColorName: String? // default to nil
var colorNameToUse = userDefinedColorName ?? defaultColorName


/*
Tuple: group multiple values into single compound value
    •    Values within tuple can be of any type and don’t have to be the same type as each other
    •    Contents can be decomposed into separate variables, which you can then access
    •    Useful as return values of functions; because a type can return distinct values of different types, useful information is returned
*/
let http404Error = (404, "Not Found")
print(http404Error.0) // access elements using index
let http200Status = (statusCode: 200, description: "OK")
print(http200Status.description) // can use element names to access

/*
Any vs AnyObject: only use either when you explicitly need the behavior and capabilities they provide
    •    Any: can represent an instance of any type at all, including function types
    ⁃    When used as a concrete type for an instance, instance needs to be casted to a known type before you can access properties and methods
    ⁃    Instances with concrete type of Any maintain their original dynamic type and can be cast to that type using as?, as!, and as
    •    AnyObject: can represent an instance of any class type
    ⁃    All classes implicitly conform to AnyObject
    ⁃    use when you need the flexibility of an untyped object
    ⁃    can used as concrete type for an instance of any class, class type, or class-only protocol
*/

var things : [Any] = []
things.append(0)
things.append(0.0)
things.append("hello")

for thing in things {
    switch thing {
    case 0 as Int:
        print("Int")
    case 0 as Double:
        print("Double")
    case let someInt as Int:
        print(someInt)
    case let someDouble as Double where someDouble > 0:
        print(someDouble)
    case let someString as String:
        print(someString)
    default:
        print("default")
    }
}
let optNum: Int? = 3
things.append(optNum) // warning if it isn't explicitly cast
things.append(optNum as Any)

/*
Protocol: blueprint of methods, properties, and other requirements that suit a particular task or piece of functionality
    •    can be adopted by class, structure, or enumeration to provide the implementation of its requirements
    •    can be extended to implement some of these requirements or to implement additional functionality that conforming types can take advantage of
    ⁃    any type that satisfies the requirements of a protocol is said to conform
    •    Property Requirements: a protocol can require any conforming type to provide an instance property or type property with specific type and name
    ⁃    always declared as variable properties
    ⁃    static: always prefix type requirements with static keyword when you define them in protocol
    •    Method Requirements: protocols can require specific instance methods and type methods to be implemented
    ⁃    default values can’t be specified for method parameters within parameter definition
    •    Initializer Requirements:  protocols can require specific initializers to be implemented
    •    Protocols don’t actually implement functionality themselves
    •    Class-only protocol: used to limit adoption to class types (not structures or enumerations) by adding the AnyObject protocol to protocol’s inheritence list
 */

/*
Delegation: design pattern that enables a class or structure to hand off responsibilities to an instance of another type
    •    implemented by defining a protocol that encapsulates the delegated responsibilities, such that the delegate is guaranteed to provide functionality that has been delegated
    •    used to respond to particular action, or retrieve data from external data source without needing to know underlying type of that source
    •    delegates are declared as weak references to prevent reference cycles
    ⁃    weak reference: doesn’t keep strong hold on the instance it refers to, so it doesn’t prevent ARC from disposing of the instance
    •    Delegate property is automatically set to an initial value of nil because it is an optional type
    •
                                
 */
protocol DiceGame {
    var dice: Dice { get }
    func play()
}
// A class-only protocol is marked by inheritence from AnyObject
protocol DiceGameDelegate: AnyObject {
    func gameDidStart(_ game: DiceGame)
    func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int)
    func gameDidEnd(_ game: DiceGame)
    
}
class SnakesAndLadders: DiceGame {
    let finalSquare = 25
    weak var delegate: DiceGameDelegate? // must be optional because it isn't required to play the game
}


/*
 Explain UIKit - What is?
 
 A framework that provides the requireed infrastructure for iOS app.
 Provides the window and view architecture for implmenting your interface, eventhandling infrastructure. etc.
 
 */
