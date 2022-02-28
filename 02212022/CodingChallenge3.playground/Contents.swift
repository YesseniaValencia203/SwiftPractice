import UIKit
import Darwin

/*
 Given a string s containing just the characters '(', ')',
 '{', '}', '[', ']', determine if the input string is valid.
 An input string is valid if:
 1. Open brackets must be closed by the same type of brackets.
 2. Open brackets must be closed in the correct order.
 
 */
struct Stack<Element> {
  fileprivate var array: [Element] = []
  
  mutating func push(_ element: Element) {
    array.append(element)
  }
  
  mutating func pop() -> Element? {
    return array.popLast()
  }
  
  func peek() -> Element? {
    return array.last
  }
    var isEmpty: Bool {
      return array.isEmpty
    }

    var count: Int {
      return array.count
    }

    
    
}


func isStringValid(_ s: String) -> Bool {
    var isValid: Bool = true
    var temp : Stack<Character> = Stack()
    for char in s {
        switch(char) {
        case "{":
            temp.push(char)
        case "(":
            temp.push(char)
        case "[":
            temp.push(char)
        case "}":
            if temp.peek() != "{" {
                return false
            } else {
                temp.pop()
            }
        case "]":
            if temp.peek() != "[" {
                return false
            } else {
                temp.pop()
            }
        case ")":
            if temp.peek() != "(" {
                return false
            } else {
                temp.pop()
            }
        default:
            return false
        }
    }
    if temp.count != 0 {
        return false
    }
    return isValid
}




 var s1 = "()"
 print(isStringValid(s1))
 var s2 = "()[]{}"
 print(isStringValid(s2))
 var s3 = "(]"
 print(isStringValid(s3))

