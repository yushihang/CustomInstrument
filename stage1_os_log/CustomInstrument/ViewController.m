//
//  ViewController.m
//  CustomInstrument
//
//  Created by yushihang on 2018/9/1.
//  Copyright © 2018 yushihang. All rights reserved.
//

#import "ViewController.h"
#import "MemoryObject.h"
#import <os/signpost.h>
@interface ViewController ()
{
    NSMutableArray* _memoryObjectArray;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    mem_alloc_log = os_log_create("yh.CustomInstrument", "mem_alloc");
    
    point_of_interest_log = os_log_create("", OS_LOG_CATEGORY_POINTS_OF_INTEREST);
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeMemoryObject:) name:@"removeMe" object:nil];
    
    
    _memoryObjectArray = [NSMutableArray array];
    

    
    [NSTimer scheduledTimerWithTimeInterval:3. repeats:YES block:^(NSTimer * _Nonnull timer) {
        MemoryObject* memoryObject = [[MemoryObject alloc] init];
        [self->_memoryObjectArray addObject:memoryObject];
    }];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)removeMemoryObject:(NSNotification*)notification
{
    [_memoryObjectArray removeObject:notification.object];
    
}

@end
