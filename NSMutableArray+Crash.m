//
//  NSMutableArray+Crash.m
//  TempPro
//
//  Created by LHJ on 2017/6/23.
//  Copyright © 2017年 LHJ. All rights reserved.
//

#import "NSMutableArray+Crash.h"
#import "CrashPublic.h"

@implementation NSMutableArray (Crash)

+ (void)initCrashCategory
{    
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        MethodSwizzle(objc_getClass("__NSArrayM"), @selector(objectAtIndex:), @selector(crashSafe_objectAtIndex:));
        MethodSwizzle(objc_getClass("__NSArrayM"), @selector(addObject:), @selector(crashSafe_addObject:));
        
        MethodSwizzle(objc_getClass("__NSArrayM"), @selector(setObject:atIndexedSubscript:), @selector(crashSafe_setObject:atIndexedSubscript:));
        
        MethodSwizzle(objc_getClass("__NSArrayM"), @selector(insertObject:atIndex:), @selector(crashSafe_insertObject: atIndex:));
    });
}
- (id) crashSafe_objectAtIndex:(NSUInteger)index
{
    if(index >= self.count){ // 超出索引
        return indexCrashHandle([self class]); // 然后处理消息转发
    }
    
    return [self crashSafe_objectAtIndex:index]; // 这个方法已经被替换成原先的objectAtIndex
}
- (void) crashSafe_addObject:(id)anObject
{
    if(anObject == nil){
        return;
    }
    return [self crashSafe_addObject:anObject];
}

- (void) crashSafe_setObject:(nonnull id)anObject atIndexedSubscript:(NSUInteger)index
{
    if(anObject == nil){
        return;
    }
    if(index > self.count){
        index = self.count;
    }
    return [self crashSafe_setObject:anObject atIndexedSubscript:index];
}
- (void) crashSafe_insertObject:(id)anObject atIndex:(NSUInteger)index
{
    if(anObject == nil){
        return;
    }
    if(index > self.count){
        index = self.count;
    }
    return [self crashSafe_insertObject:anObject atIndex:index];
}

//- (id) crashSafe_objectAtIndex:(NSUInteger)index
//{
//    if(index >= self.count){ // 超出索引
//        return indexCrashHandle([self class]); // 然后处理消息转发
//    }
//    
//    return [self objectAtIndex:index]; // 这个方法已经被替换成原先的objectAtIndex
//}
//- (void) crashSafe_addObject:(id)anObject
//{
//    if(anObject == nil){
//        return;
//    }
//    return [self addObject:anObject];
//}
//
//- (void) crashSafe_setObject:(nonnull id)anObject atIndexedSubscript:(NSUInteger)index
//{
//    if(anObject == nil){
//        return;
//    }
//    if(index > self.count){
//        index = self.count;
//    }
//    return [self setObject:anObject atIndexedSubscript:index];
//}
//- (void) crashSafe_insertObject:(id)anObject atIndex:(NSUInteger)index
//{
//    if(anObject == nil){
//        return;
//    }
//    if(index > self.count){
//        index = self.count;
//    }
//    return [self insertObject:anObject atIndex:index];
//}


@end
