//
//  MemoryObject.m
//  CustomInstrument
//
//  Created by yushihang on 2018/9/1.
//  Copyright © 2018 yushihang. All rights reserved.
//

#import "MemoryObject.h"
#import "stdlib.h"


os_log_t mem_alloc_log;
@interface MemoryObject()
{
    void* mem_;
    int memSize_;

}
@end

@implementation MemoryObject

-(int)getRandomMemSize
{
    int memSize = 0;
    int random = arc4random_uniform(100);
    if (random < 10)
        memSize = 50;
    else if (random < 30)
        memSize = 10;
    else if (random < 90)
        memSize = 5;
    else
        memSize = 1;
    
    memSize *= 1024*1024;
    return memSize;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
    
        memSize_ = [self getRandomMemSize];
        bool a = os_log_type_enabled(mem_alloc_log, OS_LOG_TYPE_INFO);
        if (memSize_ <= 1*1024*1024)
            os_log_info(mem_alloc_log, "malloc MemoryObject with %d bytes", memSize_);
        else if (memSize_ <= 10*1024*1024)
            os_log_error(mem_alloc_log, "malloc MemoryObject with %d bytes", memSize_);
        else
            os_log_fault(mem_alloc_log, "malloc MemoryObject with %d bytes", memSize_);
        
        usleep(200*1000);
        mem_ = malloc(memSize_);

        
        
        float lifeTime = ((float)arc4random_uniform(500))/100.f + 1.0f;
        
        int random = arc4random_uniform(10);
        if (random == 1)
        {
            float inteval = ((float)arc4random_uniform(300))/100.f + 1.0f;
            lifeTime += inteval;
            
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(inteval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                
                self->memSize_ = [self getRandomMemSize];
                os_log_debug(mem_alloc_log, "realloc MemoryObject with %d bytes", self->memSize_);
                usleep(200*1000);
                self->mem_ = realloc(self->mem_, self->memSize_);
                
                
            });
            


        }
        
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(lifeTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"removeMe" object:self];
        });
        

        
    }
    return self;
}

- (void)dealloc
{
    
    os_log(mem_alloc_log, "dealloc MemoryObject with %d bytes", memSize_);
     usleep(200*1000);
    free(mem_);
    
   
    
}
@end
