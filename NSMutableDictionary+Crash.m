//
//  NSMutableDictionary+Crash.m
//  TempPro
//
//  Created by LHJ on 2017/6/23.
//  Copyright © 2017年 LHJ. All rights reserved.
//

#import "NSMutableDictionary+Crash.h"
#import "CrashPublic.h"

@implementation NSMutableDictionary (Crash)

+ (void)initCrashCategory
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        MethodSwizzle(objc_getClass("__NSDictionaryM"), @selector(objectForKey:), @selector(crashSafe_objectForKey:));
        
        MethodSwizzle(objc_getClass("__NSDictionaryM"), @selector(removeObjectForKey:), @selector(crashSafe_removeObjectForKey:));
        
        MethodSwizzle(objc_getClass("__NSDictionaryM"), @selector(crashSafe_setObject: forKey:), @selector(setObject:forKey:));
        MethodSwizzle(objc_getClass("__NSDictionaryM"), @selector(crashSafe_setValue: forKey:), @selector(setValue:forKey:));
    });
}
- (id) crashSafe_objectForKey:(nonnull id)key
{
    return [self crashSafe_objectForKey:key];
}
- (void) crashSafe_setValue:(id)value forKey:(NSString *)key
{
    if(value == nil
       || key == nil){
        return;
    }
    return [self crashSafe_setValue:value forKey:key];
}

- (void)crashSafe_removeObjectForKey:(id)aKey
{
    if(aKey == nil){
        return;
    }
    return [self crashSafe_removeObjectForKey:aKey];
}
- (void)crashSafe_setObject:(id)anObject forKey:(id<NSCopying>)aKey
{
    if(anObject == nil
       || aKey == nil){
        return;
    }
    return [self crashSafe_setObject:anObject forKey:aKey];
}


//- (void) crashSafe_setValue:(id)value forKey:(NSString *)key
//{
//    if(value == nil
//       || key == nil){
//        return;
//    }
//    return [self setValue:value forKey:key];
//}
//
//- (void)crashSafe_removeObjectForKey:(id)aKey
//{
//    if(aKey == nil){
//        return;
//    }
//    return [self removeObjectForKey:aKey];
//}
//- (void)crashSafe_setObject:(id)anObject forKey:(id<NSCopying>)aKey
//{
//    if(anObject == nil
//       || aKey == nil){
//        return;
//    }
//    return [self setObject:anObject forKey:aKey];
//}


@end
