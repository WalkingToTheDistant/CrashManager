//
//  NSNull+Crash.m
//  TempPro
//
//  Created by LHJ on 2017/7/10.
//  Copyright © 2017年 LHJ. All rights reserved.
//

#import "NSNull+Crash.h"
#import <objc/runtime.h>
#import "CrashManager.h"

@implementation NSNull (Crash)

+ (BOOL) resolveInstanceMethod:(SEL)sel
{
    return [CrashManager handleNSObjectResolveMethodWithInstance:objc_getClass(class_getName(self)) withSEL:sel];
}
+ (BOOL)resolveClassMethod:(SEL)sel
{
    return [CrashManager handleNSObjectResolveMethodWithInstance:objc_getMetaClass(class_getName(self)) withSEL:sel];
}

@end
