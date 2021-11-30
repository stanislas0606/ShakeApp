import UIKit

func getDeadLockWithTwoQueues() {
    print("A")
    
    DispatchQueue.main.async {
        print("B")
        
        DispatchQueue.global().sync {
            print("C")
            
            DispatchQueue.main.sync {
                print("D")
            }
        }
        print("I")
    }
}

getDeadLockWithTwoQueues()

func showCancellantionWorkItem() {
    let queue = DispatchQueue.global(qos: .background)
    
    var item = DispatchWorkItem {
        while true {
            if !item.isCancelled {
                print("0")
            } else {
                break
            }
        }
    }
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
        item.cancel()
    }
    
    item.notify(queue: .main, execute: {
        print("completed")
    })
    
    queue.async(execute: item)
}

showCancellantionWorkItem()
