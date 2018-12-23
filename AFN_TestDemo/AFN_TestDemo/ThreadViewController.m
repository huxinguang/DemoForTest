//
//  ThreadViewController.m
//  AFN_TestDemo
//
//  Created by huxinguang on 2018/4/23.
//  Copyright © 2018年 huxinguang. All rights reserved.
//

#import "ThreadViewController.h"
#import "QSThreadSafeMutableArray.h"
#import "ThreadTwoViewController.h"

typedef void(^DispatchBlock)(NSString *);

@interface ThreadViewController ()

@end

@implementation ThreadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //官方文档： https://developer.apple.com/library/content/documentation/General/Conceptual/ConcurrencyProgrammingGuide/OperationQueues/OperationQueues.html#//apple_ref/doc/uid/TP40008091-CH102-SW1
    
    /*
     派发队列： 无论是串行还是并行队列都遵循先进先出FIFO原则
     A dispatch queue is an object-like structure that manages the tasks you submit to it. All dispatch queues are first-in, first-out data structures. Thus, the tasks you add to a queue are always started in the same order that they were added.
     
     串行队列：（串行队列通常用于同步对特定资源的访问。我们应该用异步串行队列来保护共享资源和可变数据结构，而不应该用锁，因为用锁会出现死锁的情况，而异步串行队列永远不会出现死锁）
     Serial queues (also known as private dispatch queues) execute one task at a time in the order in which they are added to the queue. The currently executing task runs on a distinct thread (which can vary from task to task) that is managed by the dispatch queue. Serial queues are often used to synchronize access to a specific resource.
     Serial queues are useful when you want your tasks to execute in a specific order. A serial queue executes only one task at a time and always pulls tasks from the head of the queue. You might use a serial queue instead of a lock to protect a shared resource or mutable data structure. Unlike a lock, a serial queue ensures that tasks are executed in a predictable order. And as long as you submit your tasks to a serial queue asynchronously, the queue can never deadlock.
     
     并行队列： (1. 虽然任务的执行是并行的，但任务的开始仍然是按照其被加入到队列的顺序
            （2.每个时间点正在执行的任务数不是固定的，跟该时间点的系统情况有关
     Concurrent queues (also known as a type of global dispatch queue) execute one or more tasks concurrently, but tasks are still started in the order in which they were added to the queue. The currently executing tasks run on distinct threads that are managed by the dispatch queue. The actual number of tasks executed by a concurrent queue at any given moment is variable and can change dynamically as conditions in your application change. Many factors affect the number of tasks executed by the concurrent queues, including the number of available cores, the amount of work being done by other processes, and the number and priority of tasks in other serial dispatch queues.
     
     主队列：
     The main dispatch queue is a globally available serial queue that executes tasks on the application’s main thread. This queue works with the application’s run loop (if one is present) to interleave the execution of queued tasks with the execution of other event sources attached to the run loop. Because it runs on your application’s main thread, the main queue is often used as a key synchronization point for an application.
     */
    
    /*
     派发队列和线程的关系：
     
     When it comes to adding concurrency to an application, dispatch queues provide several advantages over threads. The most direct advantage is the simplicity of the work-queue programming model. With threads, you have to write code both for the work you want to perform and for the creation and management of the threads themselves. Dispatch queues let you focus on the work you actually want to perform without having to worry about the thread creation and management. Instead, the system handles all of the thread creation and management for you. The advantage is that the system is able to manage threads much more efficiently than any single application ever could. The system can scale the number of threads dynamically based on the available resources and current system conditions. In addition, the system is usually able to start running your task more quickly than you could if you created the thread yourself.
     当向应用程序添加并发时，派发队列相对于线程提供了几个优点。 最直接的优点是工作队列编程模型的简单性。 使用线程，您必须为您要执行的工作以及创建和管理线程本身编写代码。 派发队列让您专注于您实际想要执行的工作，而无需担心线程创建和管理。 相反，系统会为您处理所有的线程创建和管理。 优点是系统能够比任何单个应用程序更有效地管理线程。 系统可以根据可用资源和当前系统条件动态扩展线程数量。
     
     另外，如果您自己创建线程，系统通常能够更快地开始运行您的任务。（直接使用Thread比派发队列要快）
     
     Although you might think rewriting your code for dispatch queues would be difficult, it is often easier to write code for dispatch queues than it is to write code for threads. The key to writing your code is to design tasks that are self-contained and able to run asynchronously. (This is actually true for both threads and dispatch queues.) However, where dispatch queues have an advantage is in predictability. If you have two tasks that access the same shared resource but run on different threads, either thread could modify the resource first and you would need to use a lock to ensure that both tasks did not modify that resource at the same time. With dispatch queues, you could add both tasks to a serial dispatch queue to ensure that only one task modified the resource at any given time. This type of queue-based synchronization is more efficient than locks because locks always require an expensive kernel trap in both the contested and uncontested cases, whereas a dispatch queue works primarily in your application’s process space and only calls down to the kernel when absolutely necessary.
     
     尽管您可能认为为派发队列重写代码会很困难，但为编写派发队列编写代码通常比为线程编写代码更容易。编写代码的关键是设计独立并且能够异步运行的任务。 （这对于线程和派发队列都是如此。）但是，派发队列具有优势的地方在于可预测性。如果您有两个访问相同共享资源但在不同线程上运行的任务，则任一线程都可以先修改资源，并且您需要使用锁以确保两个任务不会同时修改该资源。使用分派队列，您可以将两个任务添加到串行分派队列，以确保在任何给定时间只有一个任务修改了资源。这种基于队列的同步比锁更有效，因为在有争议和无争议的情况下，锁始终需要昂贵的内核陷阱，而派发队列主要在应用程序的进程空间中工作，并且只在绝对必要时调用内核。
     
     Although you would be right to point out that two tasks running in a serial queue do not run concurrently, you have to remember that if two threads take a lock at the same time, any concurrency offered by the threads is lost or significantly reduced. More importantly, the threaded model requires the creation of two threads, which take up both kernel and user-space memory. Dispatch queues do not pay the same memory penalty for their threads, and the threads they do use are kept busy and not blocked.
     
     虽然您可能会指出在串行队列中运行的两个任务不能同时运行，但您必须记住，如果两个线程同时进行锁定，那么线程提供的任何并发会丢失或显着减少。 更重要的是，线程模型需要创建两个线程，它们同时占用内核和用户空间内存。 派发队列不会为它们的线程支付相同的内存损失，并且它们使用的线程保持繁忙并且不被阻塞。
     
     */
    
    
    /*
      队列任务何时执行：
      When you add a block object or function to a queue, there is no way to know when that code will execute
     */
    
    
    /*
     Suspending and Resuming Queues
     You can prevent a queue from executing block objects temporarily by suspending it. You suspend a dispatch queue using the dispatch_suspend function and resume it using the dispatch_resume function.
     
     Important: Suspend and resume calls are asynchronous and take effect only between the execution of blocks. Suspending a queue does not cause an already executing block to stop.
     */
    
    
    
    /*
        dispatch_get_current_queue的用途：
     
    Use the dispatch_get_current_queue function for debugging purposes or to test the identity of the current queue. Calling this function from inside a block object returns the queue to which the block was submitted (and on which it is now presumably running). Calling this function from outside of a block returns the default concurrent queue for your application
     
     */
    
    /*
     Dispatch Queues and Thread Safety
     
     1.Dispatch queues themselves are thread safe. In other words, you can submit tasks to a dispatch queue from any thread on the system without first taking a lock or synchronizing access to the queue.
     
     2.Do not call the dispatch_sync function from a task that is executing on the same queue that you pass to your function call. Doing so will deadlock the queue. If you need to dispatch to the current queue, do so asynchronously using the dispatch_async function.
     
     3.Avoid taking locks from the tasks you submit to a dispatch queue. Although it is safe to use locks from your tasks, when you acquire the lock, you risk blocking a serial queue entirely if that lock is unavailable. Similarly, for concurrent queues, waiting on a lock might prevent other tasks from executing instead. If you need to synchronize parts of your code, use a serial dispatch queue instead of a lock.
     
     4.Although you can obtain information about the underlying thread running a task, it is better to avoid doing so.
     
     */
    
    
    
    
    /*
     在多线程开发中我们经常会遇到这些概念：并发队列、串行队列、同步任务、异步任务。
     我们将这四个概念进行组合会有四种结果：串行队列＋同步任务、串行队列＋异步任务、并发队列＋同步任务、并发队列＋异步任务。
     我们对这四种结果进行解释：
     
     1.串行队列＋同步任务：不会开启新的线程，任务逐步完成。
     
     2.串行队列＋异步任务：开启新的线程，任务逐步完成。
     
     3.并发队列＋同步任务：不会开启新的线程，任务逐步完成。
     
     4.并发队列＋异步任务：开启新的线程，任务同步完成。
     
     我们如果要让任务在新的线程中完成，应该使用异步线程。为了提高效率，我们还应该将任务放在并发队列中。因此在开发中使用最多的是并发队列＋异步任务。
     
     */
    
    /*
     
     
     
     */
    
    
    //
    
    
    self.view.backgroundColor = [UIColor blueColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"next" forState:UIControlStateNormal];
    btn.frame =  CGRectMake([UIScreen mainScreen].bounds.size.width - 70, 90, 50, 40);
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(toNextPage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    UIButton *btn0 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn0 setTitle:@"dispatch_once" forState:UIControlStateNormal];
    btn0.frame =  CGRectMake(50, 150, 300, 40);
    btn0.backgroundColor = [UIColor redColor];
    [btn0 addTarget:self action:@selector(dispatchOnceTest) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn0];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn1 setTitle:@"dispatch_sync" forState:UIControlStateNormal];
    btn1.frame =  CGRectMake(50, 200, 300, 40);
    btn1.backgroundColor = [UIColor redColor];
    [btn1 addTarget:self action:@selector(dispatchSyncTest) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn2 setTitle:@"dispatch_async" forState:UIControlStateNormal];
    btn2.frame =  CGRectMake(50, 250, 300, 40);
    btn2.backgroundColor = [UIColor redColor];
    [btn2 addTarget:self action:@selector(dispatchAsyncTest) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn3 setTitle:@"sync_dead_lock" forState:UIControlStateNormal];
    btn3.frame =  CGRectMake(50, 300, 300, 40);
    btn3.backgroundColor = [UIColor redColor];
    [btn3 addTarget:self action:@selector(syncDeadLockTest) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn3];
    
    
    
    UIButton *btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn4 setTitle:@"dispatch_execute_sequence" forState:UIControlStateNormal];
    btn4.frame =  CGRectMake(50, 350, 300, 40);
    btn4.backgroundColor = [UIColor redColor];
    [btn4 addTarget:self action:@selector(dispatchExecuteSequenceTest) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn4];
    
    UIButton *btn5 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn5 setTitle:@"dispatch_nested" forState:UIControlStateNormal];
    btn5.frame =  CGRectMake(50, 400, 300, 40);
    btn5.backgroundColor = [UIColor redColor];
    [btn5 addTarget:self action:@selector(dispatchNestedTest) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn5];
    
//    UIButton *btn5 = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btn5 setTitle:@"dispatchBarrierAsyncTest" forState:UIControlStateNormal];
//    btn5.frame =  CGRectMake(50, 400, 300, 40);
//    btn5.backgroundColor = [UIColor redColor];
//    [btn5 addTarget:self action:@selector(dispatchBarrierAsyncTest) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn5];
//
//    UIButton *btn6 = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btn6 setTitle:@"dispatchBarrierAsyncTest" forState:UIControlStateNormal];
//    btn6.frame =  CGRectMake(50, 450, 300, 40);
//    btn6.backgroundColor = [UIColor redColor];
//    [btn6 addTarget:self action:@selector(dispatchBarrierAsyncTest) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn6];
    
    UIButton *btn7 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn7 setTitle:@"dispatch_barrier_async" forState:UIControlStateNormal];
    btn7.frame =  CGRectMake(50, 500, 300, 40);
    btn7.backgroundColor = [UIColor redColor];
    [btn7 addTarget:self action:@selector(dispatchBarrierAsyncTest) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn7];
    
    UIButton *btn8 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn8 setTitle:@"dispatch_barrier_sync" forState:UIControlStateNormal];
    btn8.frame =  CGRectMake(50, 550, 300, 40);
    btn8.backgroundColor = [UIColor redColor];
        [btn8 addTarget:self action:@selector(dispatchBarrierSyncTest) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn8];
    
    UIButton *btn9 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn9 setTitle:@"mutableArrayThreadUnsafe" forState:UIControlStateNormal];
    btn9.frame =  CGRectMake(50, 600, 300, 40);
    btn9.backgroundColor = [UIColor redColor];
    [btn9 addTarget:self action:@selector(mutableArrayThreadUnsafeTest) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn9];
    
    UIButton *btn10 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn10 setTitle:@"mutableArrayThreadSafe" forState:UIControlStateNormal];
    btn10.frame =  CGRectMake(50, 650, 300, 40);
    btn10.backgroundColor = [UIColor redColor];
    [btn10 addTarget:self action:@selector(mutableArrayThreadSafeTest) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn10];
    
    
}

- (void)dispatchOnceTest{
    
    
}

- (void)dispatchSyncTest{
    //1.同步函数在串行队列中执行（队列会在主线程中执行，会堵塞主线程）
    dispatch_queue_t serialQueue = dispatch_queue_create("com.hxg.serialQueueTest", DISPATCH_QUEUE_SERIAL);//第二个参数传NULL也可
    for (int i = 0; i < 10; i++) {
        dispatch_sync(serialQueue, ^{
            sleep(1);
            NSLog(@"%d====%@",i,[NSThread currentThread]);
        });
    }
    
    dispatch_queue_t mainQueue = dispatch_get_main_queue();//主队列也是串行队列
    
    
    
    
    
  //***********************************************
    
    
    //2.同步函数在并行队列中执行(队列会在主线程中执行，会堵塞主线程)
//    dispatch_queue_t concurrentQueue = dispatch_queue_create("com.hxg.concurrentQueueTest", DISPATCH_QUEUE_CONCURRENT);
//    for (int i = 0; i < 10; i++) {
//        dispatch_sync(concurrentQueue,^{
//            sleep(1);
//            NSLog(@"%d====%@",i,[NSThread currentThread]);
//        });
//    }
    
    NSLog(@"主线程运行**************");
}

- (void)dispatchAsyncTest{
    //1.异步函数在串行队列中执行（队列不在主线程执行，而是在另外“一个线程”中执行，异步操作先进先出，不会阻塞主线程）
//    dispatch_queue_t  serialQueue = dispatch_queue_create("com.hxg.serialQueueTest",DISPATCH_QUEUE_SERIAL);
//    for (int i = 0; i < 10; i++) {
//        dispatch_async(serialQueue,^{
//            sleep(1);
//            NSLog(@"%d====%@",i,[NSThread currentThread]);
//        });
//    }

    //2.异步函数在并行队列中执行 (队列不在主线程执行，而是在另外“多个线程”中执行，异步操作同时进行，不会阻塞主线程)
    dispatch_queue_t  concurrentQueue = dispatch_queue_create("com.hxg.concurrentQueueTest",DISPATCH_QUEUE_CONCURRENT);
    for (int i =0 ; i < 10; i++) {
        dispatch_async(concurrentQueue,^{
//            sleep(1);
            NSLog(@"%d====%@",i,[NSThread currentThread]);

        });
    }
    
    NSLog(@"主线程运行**************");
    
    
}

- (void)syncDeadLockTest{
    /*
     Important: You should never call the dispatch_sync or dispatch_sync_f function from a task that is executing in the same queue that you are planning to pass to the function. This is particularly important for serial queues, which are guaranteed to deadlock, but should also be avoided for concurrent queues.
     */
    
    //同步死锁示例1（运行直接报错）
    //dispatch_get_main_queue()得到的是一个串行队列
    /*
     
     要理解这个死锁问题，我们可以这样理解，把

     dispatch_sync(dispatch_get_main_queue(), ^{
        NSLog(@"2");
     });
     
     这个函数分成两个任务添加到主队列：
     1.第一个任务：将
     ^{
     NSLog(@"2");
     }
     这个block添加到主队列，并等待执行完。
     
     2.第二个任务：执行^{
     NSLog(@"2");
     }
     这个block。
     
     这两个任务依次添加到主队列，串行执行
     
     由于第一个任务比第二个任务先加入到队列，所以必须要等第一个任务执行完，才能执行第二个任务；
     但第二个任务要执行，又必须等第一个任务执行完才能执行，因为队列是先进先出的。
     
     这样，两个任务就相互等待，永远都无法执行完，死锁就产生了。
     
     
     那为什么改成dispatch_async就不会死锁了呢？
     
     
     可以这样理解： 还是拆分成两个任务，但第一个任务不是添加到主队列的，第二个任务是添加到主队列的，那么这两个任务不在一个队列里，就不存在相互等待的问题了。
     
     
     */
    
    
//    NSLog(@"1"); // 任务1
//    dispatch_sync(dispatch_get_main_queue(), ^{
//        NSLog(@"2"); // 任务2
//    });
//    NSLog(@"3");
    
    
    
    
    dispatch_queue_t concurrentQueue = dispatch_queue_create("com.hxg.concurrentQueueTest",DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t serialQueue = dispatch_queue_create("com.hxg.serialQueueTest", nil);
    dispatch_queue_t globalQueue = dispatch_get_global_queue(0, 0);
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    //同步嵌套同步 (并发队列) 不会死锁
//    dispatch_sync(concurrentQueue, ^ {
//        NSLog(@"1111");
//        dispatch_sync(concurrentQueue, ^ {
//            NSLog(@"2222");
//        });
//        NSLog(@"3333");
//    });
    
    
    //同步嵌套同步（串行队列）
    dispatch_sync(serialQueue, ^{
        NSLog(@"current thread = %@", [NSThread currentThread]);
        dispatch_sync(dispatch_get_main_queue(), ^{
            NSLog(@"current thread = %@", [NSThread currentThread]);
        });
    });
    
    
    //同步嵌套异步（并发队列）不会死锁
//    dispatch_sync(concurrentQueue, ^{
//        NSLog(@"1111");
//        dispatch_async(concurrentQueue, ^ {
//            NSLog(@"2222");
//        });
//        NSLog(@"3333");
//    });
    
    
    //异步嵌套同步 (主队列) 会死锁
    
//    dispatch_async(mainQueue, ^{
//        dispatch_sync(mainQueue, ^{
//            NSLog(@"1");
//        });
//    });
    
    //异步嵌套同步 (串行队列) 会死锁
//    dispatch_async(serialQueue, ^{
//        dispatch_sync(serialQueue, ^{
//            NSLog(@"1");
//        });
//    });
    
    NSLog(@"主线程运行**************");
    
}


- (void)dispatchExecuteSequenceTest{
    //场景1 执行顺序：任务1 -> 任务3 -> 任务2   （至于任务2和任务3哪个先执行完毕，取决于两者的耗时情况，但任务3的开始执行时间肯定先于任务2）
    dispatch_queue_t queue = dispatch_queue_create("com.hxg.serialQueue", DISPATCH_QUEUE_SERIAL);
    NSLog(@"1"); // 任务1
    dispatch_async(queue, ^{
        NSLog(@"2"); // 任务2
    });
    for (int i = 3; i< 100; i++) {// 任务3
        NSLog(@"%d",i);
    }

}

//嵌套
- (void)dispatchNestedTest{
    //1.串行队列
//    dispatch_queue_t serialQueue = dispatch_queue_create("com.hxg.serialQueue", DISPATCH_QUEUE_SERIAL);
//    NSLog(@"1"); // 任务1
//    dispatch_async(serialQueue, ^{
//        NSLog(@"2 === %@",[NSThread currentThread]); // 任务2
//        dispatch_sync(serialQueue, ^{
//            NSLog(@"3 === %@",[NSThread currentThread]); // 任务3
//        });
//        NSLog(@"4 === %@",[NSThread currentThread]); // 任务4
//    });
//    NSLog(@"5"); // 任务5
    
    //2. 并行队列
    dispatch_queue_t concurrentQueue = dispatch_queue_create("com.hxg.concurrentQueue", DISPATCH_QUEUE_CONCURRENT);
    NSLog(@"1"); // 任务1
    dispatch_async(concurrentQueue, ^{
        NSLog(@"2 === %@",[NSThread currentThread]); // 任务2
        dispatch_sync(concurrentQueue, ^{
            NSLog(@"3 === %@",[NSThread currentThread]); // 任务3
        });
        NSLog(@"4 === %@",[NSThread currentThread]); // 任务4
    });
    NSLog(@"5"); // 任务5
    
}


- (void)dispatchBarrierAsyncTest{
    
    /*
     dispatch_barrier_async :
     Submits a barrier block for asynchronous execution and returns immediately.
     
     Calls to this function always return immediately after the block has been submitted and never wait for the block to be invoked. When the barrier block reaches the front of a private concurrent queue, it is not executed immediately. Instead, the queue waits until its currently executing blocks finish executing. At that point, the barrier block executes by itself. Any blocks submitted after the barrier block are not executed until the barrier block completes.
     The queue you specify should be a concurrent queue that you create yourself using the dispatch_queue_create function. If the queue you pass to this function is a serial queue or one of the global concurrent queues, this function behaves like the dispatch_async function.
     
     用法：该函数需要同dispatch_queue_create函数生成的concurrent Dispatch Queue队列一起使用
     
     注意：指定的队列应该是使用dispatch_queue_create函数创建的并发队列。 如果传递给此函数的队列是串行队列或全局并发队列之一，则此函数的行为与dispatch_async函数相同
     
     应用： 1.实现高效率的数据库访问和文件访问
           2.避免数据竞争
    
     */
    
    /* 要搞清楚： 1.派发block块到queue中这个动作是在哪个线程中进行的
                2.block块里的代码是在哪个线程里执行的
     下面的例子中，派发block块到queue中这个动作都是在主线程中进行的
     */
    
    dispatch_queue_t concurrentQueue = dispatch_queue_create("com.hxg.concurrent", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_sync(concurrentQueue, ^{//主线程中执行
        NSLog(@"test1");
        sleep(2);
    });
    dispatch_async(concurrentQueue, ^{
        NSLog(@"test2");
    });
    dispatch_async(concurrentQueue, ^{
        sleep(2);
        NSLog(@"test3");
    });
    
    dispatch_barrier_async(concurrentQueue, ^{//请注意是异步的
        NSLog(@"test4");//新线程中执行
        sleep(1);
        NSLog(@"test4-1");
        
    });
    NSLog(@"hello");
    dispatch_async(concurrentQueue, ^{
        NSLog(@"test5");
    });
    NSLog(@"world");
    dispatch_async(concurrentQueue, ^{
        NSLog(@"test6");
    });
    dispatch_async(concurrentQueue, ^{
        NSLog(@"test7");
    });
    
    /*
     结论：
     dispatch_barrier_async只会拦截在它之前添加并发队列中的block块，是异步拦截，不会拦截其派发block这个动作所在的线程。
     
     
     
     */
    
    
}

- (void)dispatchBarrierSyncTest{
    /*
     dispatch_barrier_sync :
     Submits a barrier block object for execution and waits until that block completes.
     
     Submits a barrier block to a dispatch queue for synchronous execution. Unlike dispatch_barrier_async, this function does not return until the barrier block has finished. Calling this function and targeting the current queue results in deadlock.
     When the barrier block reaches the front of a private concurrent queue, it is not executed immediately. Instead, the queue waits until its currently executing blocks finish executing. At that point, the queue executes the barrier block by itself. Any blocks submitted after the barrier block are not executed until the barrier block completes.
     The queue you specify should be a concurrent queue that you create yourself using the dispatch_queue_create function. If the queue you pass to this function is a serial queue or one of the global concurrent queues, this function behaves like the dispatch_sync function.
     Unlike with dispatch_barrier_async, no retain is performed on the target queue. Because calls to this function are synchronous, it "borrows" the reference of the caller. Moreover, no Block_copy is performed on the block.
     As an optimization, this function invokes the barrier block on the current thread when possible.
     
     
     
     */
    
    
    dispatch_queue_t concurrentQueue = dispatch_queue_create("com.hxg.concurrent", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(concurrentQueue, ^{
        NSLog(@"test1");
    });
    dispatch_async(concurrentQueue, ^{
        sleep(1);
        NSLog(@"test2");
    });
    dispatch_sync(concurrentQueue, ^{
        NSLog(@"test3");//主线程中执行
    });
    dispatch_barrier_sync(concurrentQueue, ^{///分界线在这里 请注意是同步的
        NSLog(@"test4");
        sleep(2);
        NSLog(@"test4-1");//主线程中执行
    });
    NSLog(@"hello");
    dispatch_async(concurrentQueue, ^{
        NSLog(@"test5");
    });
    NSLog(@"world");
    dispatch_async(concurrentQueue, ^{
        NSLog(@"test6");
    });
    dispatch_async(concurrentQueue, ^{
        NSLog(@"test7");
    });
    
    
    /*
     0. test3肯定先于test4
     1. test3和test2执行顺序不一定
     2. test5、test6、test7执行顺序不一定
     3. hello 肯定先于 test5， world，test6，test7
     4. world肯定先于 test6，test7
     5. test5、world顺序不一定
     
     结论: dispatch_barrier_sync 会阻塞其派发block这个动作所在的线程
     */
    
}


- (void)mutableArrayThreadUnsafeTest{
    
    /*
     Immutable objects are generally thread-safe. Once you create them, you can safely pass these objects to and from threads. On the other hand, mutable objects are generally not thread-safe. To use mutable objects in a threaded application, the application must synchronize appropriately.
     */
    
    /*
     Mutable objects are generally not thread-safe. To use mutable objects in a threaded application, the application must synchronize access to them using locks. (For more information, see Atomic Operations). In general, the collection classes (for example, NSMutableArray, NSMutableDictionary) are not thread-safe when mutations are concerned. That is, if one or more threads are changing the same array, problems can occur. You must lock around spots where reads and writes occur to assure thread safety.
     
     Even if a method claims to return an immutable object, you should never simply assume the returned object is immutable. Depending on the method implementation, the returned object might be mutable or immutable. For example, a method with the return type of NSString might actually return an NSMutableString due to its implementation. If you want to guarantee that the object you have is immutable, you should make an immutable copy.
     */
    
    
    
    //在block中只要不对可变数组赋值，是可以直接用的，不必用__block 修饰
    __block NSMutableArray *arr = [[NSMutableArray alloc]init];
    
#warning 注意dispatch_queue_create的第一个参数是char类型，不是NSString类型的
    dispatch_queue_t concurrentQueue = dispatch_queue_create("com.hxg.mutablearray", DISPATCH_QUEUE_CONCURRENT);
    
    //线程1
    dispatch_async(concurrentQueue, ^{
        for (int i = 0; i < 100; i++) {
            [arr addObject:[NSNumber numberWithInt:i]];
        }
        NSLog(@"线程1: %ld",arr.count);
    });
    
    //线程2
    dispatch_async(concurrentQueue, ^{
        for (int i = 100; i < 200 ; i++) {
            [arr addObject:@"1"];
        }
        NSLog(@"线程2: %ld",arr.count);
    });
    
    //线程3
    dispatch_async(concurrentQueue, ^{
        for (int i = 200; i < 300; i++) {
            [arr addObject:[NSNumber numberWithInt:i]];
        }
        NSLog(@"线程3: %ld",arr.count);
    });
    
    dispatch_barrier_async(concurrentQueue, ^{
        NSLog(@"*********%ld",arr.count);
    });
    
}

- (void)mutableArrayThreadSafeTest{
    //https://www.jianshu.com/p/ed2030920ec4
    QSThreadSafeMutableArray *safeArray = [[QSThreadSafeMutableArray alloc]init];
    //在block中只要不对可变数组赋值，是可以直接用的，不必用__block 修饰
    dispatch_queue_t concurrentQueue = dispatch_queue_create("com.hxg.mutablearray", DISPATCH_QUEUE_CONCURRENT);
    
    //线程1
    dispatch_async(concurrentQueue, ^{
        for (int i = 0; i < 1000; i++) {
            [safeArray addObject:[NSNumber numberWithInt:i]];
        }
        NSLog(@"线程1: %ld",safeArray.count);
    });
    
    //线程2
    dispatch_async(concurrentQueue, ^{
        for (int i = 1000; i < 2000 ; i++) {
            [safeArray addObject:@"1"];
        }
        NSLog(@"线程2: %ld",safeArray.count);
    });
    
    //线程3
    dispatch_async(concurrentQueue, ^{
        for (int i = 2000; i < 3000; i++) {
            [safeArray addObject:[NSNumber numberWithInt:i]];
        }
        NSLog(@"线程3: %ld",safeArray.count);
    });
    
    dispatch_barrier_async(concurrentQueue, ^{
        NSLog(@"*********%ld",safeArray.count);
    });
    
    
    
}




- (void)gcdTest1{
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 处理耗时操作的代码块...
        //通知主线程刷新
        dispatch_async(dispatch_get_main_queue(), ^{
            //回调或者说是通知主线程刷新，
        });
    });
    //关于dispatch_get_global_queue(long identifier, unsigned long flags);的两个参数说明：
    
    //    * @param identifier
    //    * A quality of service class defined in qos_class_t or a priority defined in
    //    * dispatch_queue_priority_t.
    //    *
    //    * It is recommended to use quality of service class values to identify the
    //    * well-known global concurrent queues:
    //    *  - QOS_CLASS_USER_INTERACTIVE
    //    *  - QOS_CLASS_USER_INITIATED
    //    *  - QOS_CLASS_DEFAULT
    //    *  - QOS_CLASS_UTILITY
    //    *  - QOS_CLASS_BACKGROUND
    //    *
    //    * The global concurrent queues may still be identified by their priority,
    //    * which map to the following QOS classes:
    //    *  - DISPATCH_QUEUE_PRIORITY_HIGH:         QOS_CLASS_USER_INITIATED
    //    *  - DISPATCH_QUEUE_PRIORITY_DEFAULT:      QOS_CLASS_DEFAULT
    //    *  - DISPATCH_QUEUE_PRIORITY_LOW:          QOS_CLASS_UTILITY
    //    *  - DISPATCH_QUEUE_PRIORITY_BACKGROUND:   QOS_CLASS_BACKGROUND
    //    *
    //    * @param flags
    //    * Reserved for future use. Passing any value other than zero may result in
    //    * a NULL return value.
    //    *
    
}

- (void)concurrentAction{
    //需求： 在3个网络请求后再执行UI更新
    
    /*
     http://yjl.skyocean.com/tyapi/Public/skyocean/?service=Home.Get_ad&time=1524188905987&type=1&block=2&uid=2432&token=E67C642E80D2C94E7750A37AE0849DED41F463F0A123AAB2BC5CC2B995A1B4D3
     */
    
    /*
     http://yjl.skyocean.com/tyapi/Public/skyocean/?service=Shop.Pop_shop_list&time=1524188905998&mall=10&uid=2432&token=E67C642E80D2C94E7750A37AE0849DED41F463F0A123AAB2BC5CC2B995A1B4D3
     */
    
    /*
     http://yjl.skyocean.com/tyapi/Public/skyocean/?service=Home.TelPhone&time=1524188905992&tag=tyc4d&uid=2432&token=E67C642E80D2C94E7750A37AE0849DED41F463F0A123AAB2BC5CC2B995A1B4D3
     */
    
}





- (void)toNextPage{ 
    ThreadTwoViewController *ttvc = [[ThreadTwoViewController alloc]init];
    [self.navigationController pushViewController:ttvc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
