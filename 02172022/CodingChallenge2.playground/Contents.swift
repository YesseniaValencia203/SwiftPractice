import UIKit

func longestCommonPrefix(_ arr: [String]) -> String {
    var prefix: String = ""
    if arr.count == 0 {
        return prefix
    }
    
    // make prefix equal to the first word on the array
    prefix = arr[0]
    
    for i in 1..<arr.count {
        while arr[i].contains(prefix) == false {
            let tempIndex = prefix.index(prefix.startIndex, offsetBy: prefix.count-1)
            // copy contents up to that character
            prefix = String(prefix[..<tempIndex])
            
            // if empty, no common prefix -> return the empty string
            if prefix.count < 1 {
                return ""
            }
        }
    }
    return prefix
}
let str1 = ["dog", "racecar", "car"]
print(longestCommonPrefix(str1))
let str2 = ["flower", "flow", "flight"]
print(longestCommonPrefix(str2))
