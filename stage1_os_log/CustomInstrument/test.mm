//
//  test.m
//  CustomInstrument
//
//  Created by yushihang on 2018/9/7.
//  Copyright © 2018 yushihang. All rights reserved.
//

#import "test.h"
#import <os/signpost.h>
os_signpost_id_t signpost_id;
@implementation test
-(void)test
{
    signpost_id = os_signpost_id_generate(mem_alloc_log);
    if (memSize_ <= 1*1024*1024)
        os_signpost_interval_begin(mem_alloc_log, signpost_id, "1M");
    else if (memSize_ <= 10*1024*1024)
        os_signpost_interval_begin(mem_alloc_log, signpost_id, "<10M");
    else
        os_signpost_interval_begin(mem_alloc_log, signpost_id, ">10M");
}
@end
