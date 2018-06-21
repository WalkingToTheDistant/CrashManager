//
//  NSArray+Crash.m
//  TempPro
//
//  Created by LHJ on 2017/6/23.
//  Copyright © 2017年 LHJ. All rights reserved.

#import "NSArray+Crash.h"
#import <objc/runtime.h>
#import "CrashPublic.h"

@implementation NSArray (Crash)

+ (void)initCrashCategory
{    
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        //__NSSingleObjectArrayI, __NSArray0
        MethodSwizzle(objc_getClass("__NSArrayI"), @selector(objectAtIndex:), @selector(arrayI_crashSafe_objectAtIndex:));
        MethodSwizzle(objc_getClass("__NSArray0"), @selector(objectAtIndex:), @selector(array0_crashSafe_objectAtIndex:));
        MethodSwizzle(objc_getClass("__NSSingleObjectArrayI"), @selector(objectAtIndex:), @selector(singleObjectArrayI_crashSafe_objectAtIndex:));
    });
}

- (id) arrayI_crashSafe_objectAtIndex:(NSUInteger)index
{
    if(index >= self.count){ // 超出索引
        return indexCrashHandle([self class]); // 然后处理消息转发
    }
    
    return [self arrayI_crashSafe_objectAtIndex:index]; // 这个方法已经被替换成原先的objectAtIndex
}
- (id) array0_crashSafe_objectAtIndex:(NSUInteger)index
{
    if(index >= self.count){ // 超出索引
        return indexCrashHandle([self class]); // 然后处理消息转发
    }
    
    return [self array0_crashSafe_objectAtIndex:index]; // 这个方法已经被替换成原先的objectAtIndex
}
- (id) singleObjectArrayI_crashSafe_objectAtIndex:(NSUInteger)index
{
    if(index >= self.count){ // 超出索引
        return indexCrashHandle([self class]); // 然后处理消息转发
    }
    
    return [self singleObjectArrayI_crashSafe_objectAtIndex:index]; // 这个方法已经被替换成原先的objectAtIndex
}

- (id)crashSafe_objectAtIndex:(NSUInteger)index
{
    if(index >= self.count){ // 超出索引
        return indexCrashHandle([self class]); // 然后处理消息转发
    }
    
    return [self objectAtIndex:index]; // 这个方法已经被替换成原先的objectAtIndex
}

@end
