//
//  CrashManager.m
//  TempPro
//
//  Created by LHJ on 2017/6/23.
//  Copyright © 2017年 LHJ. All rights reserved.
//

#import "CrashManager.h"
#import <objc/runtime.h>

/** 消息转发机制，避免报错 */
@implementation CrashManager

// ======================================================================================================
#pragma mark - 处理Crash的方法
int handleInstanceMethodCrashMethod()
{
    return 0;
}
// ======================================================================================================
+ (void) recordCrashWithLog:(NSString*)strLog
{
    
}

+ (BOOL) resolveInstanceMethod:(SEL)sel
{
    return [CrashManager handleNSObjectResolveMethodWithInstance:objc_getClass(class_getName(self)) withSEL:sel];
}
+ (BOOL)resolveClassMethod:(SEL)sel
{
    return [CrashManager handleNSObjectResolveMethodWithInstance:objc_getMetaClass(class_getName(self)) withSEL:sel];
}

+ (BOOL) handleNSObjectResolveMethodWithInstance:(Class)cls withSEL:(SEL)sel
{    
#if DEBUG != 1
    class_addMethod(cls, sel, (IMP)handleInstanceMethodCrashMethod, "v@:");
    if(class_isMetaClass(cls) == YES){ // 元类
        return [super resolveClassMethod:sel];
        
    } else { //  对象类
        return [super resolveInstanceMethod:sel];
        
    }
#endif
    return NO;
}

@end
