//
//  ThreadTwoViewController.m
//  AFN_TestDemo
//
//  Created by huxinguang on 2018/4/25.
//  Copyright © 2018年 huxinguang. All rights reserved.
//

#import "ThreadTwoViewController.h"

@interface ThreadTwoViewController ()

@end

@implementation ThreadTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    UIButton *btn0 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn0 setTitle:@"dispatch_sync_thread_create" forState:UIControlStateNormal];
    btn0.frame =  CGRectMake(50, 150, 300, 40);
    btn0.backgroundColor = [UIColor redColor];
    [btn0 addTarget:self action:@selector(dispatchsSyncThreadCreateTest) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn0];
    

    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn1 setTitle:@"dispatch_group_async" forState:UIControlStateNormal];
    btn1.frame =  CGRectMake(50, 200, 300, 40);
    btn1.backgroundColor = [UIColor redColor];
    [btn1 addTarget:self action:@selector(dispatchGroupAsyncTest) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];

    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn2 setTitle:@"dispatch_group_wait" forState:UIControlStateNormal];
    btn2.frame =  CGRectMake(50, 250, 300, 40);
    btn2.backgroundColor = [UIColor redColor];
    [btn2 addTarget:self action:@selector(dispatchGroupWaitTest) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];

    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn3 setTitle:@"dispatch_group_notify" forState:UIControlStateNormal];
    btn3.frame =  CGRectMake(50, 300, 300, 40);
    btn3.backgroundColor = [UIColor redColor];
    [btn3 addTarget:self action:@selector(dispatchGroupNotifyTest) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn3];

    UIButton *btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn4 setTitle:@"dispatch_time" forState:UIControlStateNormal];
    btn4.frame =  CGRectMake(50, 350, 300, 40);
    btn4.backgroundColor = [UIColor redColor];
    [btn4 addTarget:self action:@selector(dispatchTimeTest) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn4];

    UIButton *btn5 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn5 setTitle:@"dispatch_set_target_queue" forState:UIControlStateNormal];
    btn5.frame =  CGRectMake(50, 400, 300, 40);
    btn5.backgroundColor = [UIColor redColor];
    [btn5 addTarget:self action:@selector(dispatchSetTargetQueueTest) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn5];
//
//    UIButton *btn7 = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btn7 setTitle:@"dispatchBarrierAsync" forState:UIControlStateNormal];
//    btn7.frame =  CGRectMake(50, 500, 300, 40);
//    btn7.backgroundColor = [UIColor redColor];
//    [btn7 addTarget:self action:@selector(dispatchBarrierAsyncTest) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn7];
//
//    UIButton *btn8 = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btn8 setTitle:@"dispatchBarrierSync" forState:UIControlStateNormal];
//    btn8.frame =  CGRectMake(50, 550, 300, 40);
//    btn8.backgroundColor = [UIColor redColor];
//    [btn8 addTarget:self action:@selector(dispatchBarrierSyncTest) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn8];
//
//    UIButton *btn9 = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btn9 setTitle:@"mutableArrayThreadUnsafe" forState:UIControlStateNormal];
//    btn9.frame =  CGRectMake(50, 600, 300, 40);
//    btn9.backgroundColor = [UIColor redColor];
//    [btn9 addTarget:self action:@selector(mutableArrayThreadUnsafeTest) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn9];
//
//    UIButton *btn10 = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btn10 setTitle:@"mutableArrayThreadSafe" forState:UIControlStateNormal];
//    btn10.frame =  CGRectMake(50, 650, 300, 40);
//    btn10.backgroundColor = [UIColor redColor];
//    [btn10 addTarget:self action:@selector(mutableArrayThreadSafeTest) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn10];
}


- (void)dispatchsSyncThreadCreateTest{
    //用于测试同步派发任务的线程创建、执行问题
    dispatch_queue_t concurrentQueue = dispatch_queue_create("com.hxg.concurrent",DISPATCH_QUEUE_CONCURRENT);
    dispatch_sync(concurrentQueue,^{ //任务被派发到主线程中执行
        NSLog(@"test1   %@",[NSThread currentThread]);
    });
    dispatch_async(concurrentQueue,^{
        NSLog(@"test2   %@",[NSThread currentThread]);
        dispatch_sync(concurrentQueue, ^{
            NSLog(@"test3   %@",[NSThread currentThread]);
        });
    });
    
    /*
     结论：
     1. dispatch_sync 不会开辟新的线程
     2. dispatch_async 的block块中的代码是在另外开辟的线程中执行的。
     3. dispatch_sync 的block块中的代码执行在当前线程，从上面的代码执行结果来看，test2和test3执行在dispatch_async开辟的新线程中，而test1执行在主线程中
     */
    
}

- (void)dispatchTimeTest{
    /*
     dispatch_time_t dispatch_time(dispatch_time_t when, int64_t delta);
    
     1. when:   Pass DISPATCH_TIME_NOW to create a new time value relative to now.
     2. delta:   The number of nanoseconds(纳秒) to add to the time in the when parameter.
     
     */
    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3*NSEC_PER_SEC));
    dispatch_after(time, dispatch_get_main_queue(), ^{
        NSLog(@"*********");
    });

}

- (void)dispatchGroupAsyncTest{
    //只有dispatch_group_async,没有dispatch_group_sync
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_group_async(group, queue, ^{
        NSLog(@"1");
    });
    
    dispatch_group_async(group, queue, ^{
        sleep(1);
        NSLog(@"2");
    });
    
    dispatch_group_async(group, queue, ^{
        NSLog(@"3");
    });
    
}

- (void)dispatchGroupWaitTest{
    /*
     long dispatch_group_wait(dispatch_group_t group, dispatch_time_t timeout);
     
     group:  The dispatch group to wait on. This parameter cannot be NULL.
     
     timeout:  When to timeout (see dispatch_time). The DISPATCH_TIME_NOW and DISPATCH_TIME_FOREVER constants
               are provided as a convenience.
     
     Return Value :
     Returns zero on success (all blocks associated with the group completed before the specified timeout) or non-zero on error (timeout occurred).
     
     
     This function waits for the completion of the blocks associated with the given dispatch group and returns when either all blocks have completed or the specified timeout has elapsed. When a timeout occurs, the group is restored to its original state.
     This function returns immediately if the dispatch group is empty (there are no blocks associated with the group).
     After the successful return of this function, the dispatch group is empty, and can be reused for additional blocks.
     
     */
    
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_group_async(group, queue, ^{
        NSLog(@"1");
    });
    
    dispatch_group_async(group, queue, ^{
        sleep(2);
        NSLog(@"2");
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"3");
    });
    
    dispatch_time_t timeout1 = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4*NSEC_PER_SEC));
    dispatch_time_t timeout2 = DISPATCH_TIME_FOREVER;//会一直等到dispatch group 执行完，不会超时
    dispatch_group_wait(group, timeout2);
    
    NSLog(@"4");
    
    /*
     注意： 1.第二个参数是dispatch_time_t类型的，不是整型或浮点型
           2. dispatch_group_wait会阻塞当前线程
     */
    
}

- (void)dispatchGroupNotifyTest{
    /*
     void dispatch_group_notify(dispatch_group_t group, dispatch_queue_t queue, dispatch_block_t block);
     
     group: The dispatch group to observe. The group is retained by the system until the block has run to completion. This parameter cannot be NULL
     
     queue: The queue to which the supplied block is submitted when the group completes.
     
     block: The block to submit when the group completes.
     
     This function schedules a notification block to be submitted to the specified queue when all blocks associated with the dispatch group have completed. If the group is empty (no block objects are associated with the dispatch group), the notification block object is submitted immediately.
     When the notification block is submitted, the group is empty. The group can either be released with dispatch_release or be reused for additional block objects.
     
     
     如果你部署的最低目标低于 iOS 6.0 or Mac OS X 10.8
     GCD对象没有纳入ARC内存管理，你应该自己管理GCD对象,使用(dispatch_retain,dispatch_release),ARC并不会去管理它们
     
     如果你部署的最低目标是 iOS 6.0 or Mac OS X 10.8 或者更高的
     ARC已经能够管理GCD对象了,这时候,GCD对象就如同普通的OC对象一样,不应该使用dispatch_retain or dispatch_release
     
     */
    
    
    dispatch_group_t  group = dispatch_group_create();
    /* 要设定队列的优先级，使用全局队列dispatch_get_global_queue是最简便的方式，因为全局队列的第一个参数可以方便地设置优先级
        如果是自己通过dispatch_queue_create创建的队列，由于其没有设置优先级的参数，所以对于自己创建的队列则需要通过dispatch_set_target_queue函数来把队列的target queue 设置为全局队列，从而能继承全局队列的优先级，详见下面dispatch_set_target_queue的测试案例。
     */
//    dispatch_queue_t lowPriorityQueue = dispatch_queue_create("com.hxg.concurrent", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_queue_t lowPriorityQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW,0);
    dispatch_queue_t highPriorityQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH,0);

    dispatch_group_async(group, lowPriorityQueue, ^{
        NSLog(@"1");
        for (long i=0; i<10000000000; i++) {
            if (i == 9999999999) {
                NSLog(@"11");
            }
        }
    });
    
    dispatch_group_async(group,lowPriorityQueue,^{
        NSLog(@"2");
        for (long i=0; i<10000000000; i++) {
            if (i == 9999999999) {
                NSLog(@"22");
            }
        }
    });
    
    
    dispatch_group_async(group,highPriorityQueue,^{
        NSLog(@"3");
        for (long i=0; i<10000000000; i++) {
            if (i == 9999999999) {
                NSLog(@"33");
            }
        }
    });
    
    dispatch_group_async(group, highPriorityQueue, ^{
        NSLog(@"4");
        for (long i=0; i<10000000000; i++) {
            if (i == 9999999999) {
                NSLog(@"44");
            }
        }
    });
    
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"5");
    });
    
    
    
    NSLog(@"6");
    
    /*
     结论：1. dispatch_group_notify不会堵塞当前线程
          2. dispatch_group_notify的group参数应该和dispatch_group_async的group是同一个group
          3. dispatch_group_notify的queue跟dispatch_group_async的queue没有必然联系，dispatch_group_notify的queue应根据具体情况来定,采用dispatch_get_main_queue()是常见的写法。
          4. 设置优先级不能控制block块开始执行的顺序，也不能控制block执行完的顺序，只能说在多线程执行block时优先处理优先级高的
          5. 如果每个block中只是执行一个简单的nslog语句，那么单从打印结果上无法看出设置优先级的作用，像上面的例子一样，每个block中进行大量的运算后再打印，这样优先级作用就可以从结果中体现出来了。
     */
    
}

- (void)dispatchSetTargetQueueTest{
    
    /*
     void dispatch_set_target_queue(dispatch_object_t object, dispatch_queue_t queue);
     
     object: The object to modify. This parameter cannot be NULL.
     queue:  The new target queue for the object. The queue is retained, and the previous one, if any, is released. This parameter cannot be NULL.
     
     An object's target queue is responsible for processing the object. The target queue determines the queue on which the object's finalizer is invoked. In addition, modifying the target queue of some objects changes their behavior:
     
     Dispatch queues:
             A dispatch queue's priority is inherited from its target queue. Use the dispatch_get_global_queue function to obtain a suitable target queue of the desired priority.
             If you submit a block to a serial queue, and the serial queue’s target queue is a different serial queue, that block is not invoked concurrently with blocks submitted to the target queue or to any other queue with that same target queue.
             Important
             If you modify the target queue for a queue, you must be careful to avoid creating cycles in the queue hierarchy.
     
     */
    
    dispatch_queue_t lowPriorityQueue = dispatch_queue_create("com.hxg.concurrent",DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t targetQueue1 = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0);
    dispatch_set_target_queue(lowPriorityQueue, targetQueue1);
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, lowPriorityQueue, ^{
        NSLog(@"1");
        for (long i=0; i<10000000000; i++) {
            if (i == 9999999999) {
                NSLog(@"11");
            }
        }
    });
    
    
    dispatch_group_async(group,lowPriorityQueue,^{
        NSLog(@"2");
        for (long i=0; i<10000000000; i++) {
            if (i == 9999999999) {
                NSLog(@"22");
            }
        }
    });
    
    dispatch_queue_t highPriorityQueue = dispatch_queue_create("com.hxg.concurrent",DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t targetQueue2 = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH,0);
    dispatch_set_target_queue(highPriorityQueue,targetQueue2);
    
    dispatch_group_async(group, highPriorityQueue, ^{
        NSLog(@"3");
        for (long i=0; i<10000000000; i++) {
            if (i == 9999999999) {
                NSLog(@"33");
            }
        }
    });
    
    dispatch_group_async(group,highPriorityQueue,^{
        NSLog(@"4");
        for (long i=0; i<10000000000; i++) {
            if (i == 9999999999) {
                NSLog(@"44");
            }
        }
        
    });
    
    dispatch_group_notify(group,dispatch_get_main_queue(),^{
        NSLog(@"5");
    });
    
    NSLog(@"6");
    
    
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
