import UIKit
//import PlaygroundSupport
//
//PlaygroundPage.current.needsIndefiniteExecution = true

let queue = DispatchQueue(label: "myQueue", qos: .default, attributes: .concurrent, autoreleaseFrequency: .inherit, target: nil)
queue.async {
    sleep(3)
    print("in background")
}

print("in main")
var seconds = 10
let timer = DispatchSource.makeTimerSource(flags: [], queue: queue)
timer.schedule(deadline: .now(),repeating: 1.0)
timer.setEventHandler {
    seconds -= 1
    if seconds < 0 {
        timer.cancel()
    } else {
        print("会把timer.setEventHandler里面的任务设置到DispatchSource里面，添加一个task")
    }
}
timer.resume()
///锁 spinLock

struct Test2 {
    
}

class Test {
    deinit {
        print("do something")
    }
}
class Test3: Test {
}
