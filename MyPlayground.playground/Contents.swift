import Foundation


//What is the output of the following code?
let q1 = DispatchQueue(label: "1")
// create q1 ==> serial queue
// scope is the same that print(4) is on --> main thread
// SYNC ===> waits until the task is finished; blocks thread
// ASYNC ==> performs a task later; does not block. 
q1.async {
    // when the queue is put to sleep --> for one second, the thread isn't doing anything
    sleep(1)
    print(1)
    sleep(1)
    q1.async {
        print(2)
    }
    sleep(1)
    print(3)
    sleep(1)
}
print(4)
q1.sync {
    print(5)
}
// 4,5,1.3,2
// 4,5
