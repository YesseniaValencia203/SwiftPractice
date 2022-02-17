import UIKit

func function1(arr: [Int], target: Int) -> [Int] {
    var first: Int = 0
    var second: Int = 1
    for i in 0..<arr.count {
        for j in i+1..<arr.count {
            if arr[i] + arr[j] == target && i != j {
                first = i
                second = j
            }
        }
    }
    return [first, second]
}

print(function1(arr: [2, 7, 11, 15], target: 9))
print(function1(arr: [3, 2, 4], target: 6))
print(function1(arr: [3,3], target: 6))
