//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

var x = 2

let d: Double = 1
//let e: Int = 1.1 wrong type. ERROR

let array = [0.5,1,2,3]
let defds: [Int] = []

let askasa = [Int]()

var faria = "boom"

let abs = "alala"
// abs = "dood" error as 'let' creates a constant. This cannot be changed.

//var a:String = nil This is a compilation error as by default strings are not optional
var b:String? = nil

//We can assign labels to our function parameters. Here we assign 'on' as a label to a and 'and' as a label to b. This helps make the function call more verbose and readable.
func perform(operation:String, on a:Double, and b:Double) -> Double {
    print("Performing \(operation) on \(a) and \(b)")
    var result:Double = 0
    switch operation {
    case "+":
        result = a + b
    case "-":
        result = a - b
    case "/":
        result = a / b
    case "*":
        result = a * b
    default:
        print("Don't know what to do with operation: \(operation)")
    }
    
    return result
}

perform("+", on: 1, and: 2)
perform("-", on: 1, and: 2)
perform("/", on: 1, and: 2)
perform("*", on: 1, and: 2)
perform("$", on: 1, and: 2)

var image = [
    [3, 7, 10],
    [6, 4, 2],
    [8, 5, 2]
]

func doSomethingWithList(list:[[Int]]) {
    //list[0][0] = 10 
    //This is not possible as by default parameters to a function are immutable. We have to define the 
    //parameter using 'var' to make it mutable
}

func actuallyDoSomethingWithList(var list:[[Int]]) -> [[Int]] {
    list[0][0] = 10
    return list
}

doSomethingWithList(image)
actuallyDoSomethingWithList(image)
image // despite 'actuallyDoSomethingWithList' changing the list that was passed in our original list remains unchanged
//what was changed was a copy of our list. We have to use the return value
image = actuallyDoSomethingWithList(image)

//or we can pass the reference of our list into the method using 'inout'
func doSomethingToReference(inout list:[[Int]]){
    list[1][0] = 30
}
doSomethingToReference(&image) //we use the '&' to pass the reference. Swift forces us to do this

//we can assign functions to variables
func performMagic(spell:String) -> String {
    return spell
}

var magic = performMagic //here we assign the functional to our varible.
magic("Wingardium Leviosa") //we can now use our variable to call our function

//we can define functions using var and closures
var superMethod = {
    (superParam:String) -> String in
    return superParam
}
superMethod("iamparam") //that just happened

// lets talk about structs baby
// structus are immutable. When assigning a struct to a another variable it creates a copy. So changes on the new instance do not affect the existing instance. This is one different between structs and classes!
struct Animal {
    var name = ""
    var heightInches = 0.0
    var heightCM:Double { //this is how getters and setters are declared yo
        get {
            return heightInches * 2.54
        }
        set(newHeightCM) {
            heightInches = newHeightCM / 2.54
        }
    }
}
let dog = Animal(name: "Spike", heightInches: 43)
dog.heightInches
dog.heightCM
// dog.heightCM = 200 fails as we defined dog as a constant and we can't teach a constant dog new tricks

var otherDog = Animal(name: "Modifiable", heightInches: 60)
otherDog.heightCM = 99.99 //we can change it hoorah
otherDog.heightInches

// Its all generic nowadays
func swapTwoValues<T>(inout a:  T, inout b: T) {
    let temporaryA = a
    a = b
    b = temporaryA
}
var val1 = "String"
var val2 = "OtherString"
swapTwoValues(&val1, b: &val2)
val1 //OtherString
val2 //String

var val3 = 1.0
var val4 = 2.0
swapTwoValues(&val3, b: &val4)
val3 //2.0
val4 //1.0

//Follow the protocol (protocols are basically java interfaces)
protocol MagicUser {
    init(hatSize:Double) //we can force implementers to conform to an initializer
    
    var hatSize: Double { get set } //this property must have a getter and setter
    var staffSize: Double { get } //does not need to have a setter but must have a getter
    func doMagicStuff()
}

class Wizard: MagicUser {
    
    required init(hatSize: Double) { //constructor. the required keyword indicates that all extending classes must all conform to the init method
        self.hatSize = hatSize
    }
    
    var hatSize: Double
    var staffSize: Double {
        get {
            return 3.0
        }
    }
    
    func doMagicStuff() {
        print("I'm doing magic stuff baby")
    }
}

class BossWizard: Wizard {
    
    required init(hatSize: Double) { //constructor. the required keyword indicates
        super.init(hatSize: hatSize) //delegating yo
    }
}

let gandalf = Wizard(hatSize: 40)
let saruman = Wizard(hatSize: 0) //hatless

//getting extensive
// we can define extensions for existing classes or structs. for example lets make the SWIFT Int a bit more groovy
extension Int {
    func times(task: () -> Void) {
        for _ in 0..<self {
            task()
        }
    }
}

5.times {
    print("I am groovy")
}