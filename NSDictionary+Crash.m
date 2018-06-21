//
//  NSDictionary+Crash.m
//  TempPro
//
//  Created by LHJ on 2017/6/23.
//  Copyright © 2017年 LHJ. All rights reserved.
//

#import "NSDictionary+Crash.h"
#import "CrashPublic.h"

@implementation NSDictionary (Crash)

+ (void)initCrashCategory
{    
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        // __NSDictionary0, __NSSingleEntryDictionaryI, __NSDictionaryI
        MethodSwizzle(objc_getClass("__NSDictionaryI"), @selector(objectForKey:), @selector(dictionaryI_crashSafe_objectForKey:));
        
        MethodSwizzle(objc_getClass("__NSDictionary0"), @selector(objectForKey:), @selector(dictionary0_crashSafe_objectForKey:));
        
        MethodSwizzle(objc_getClass("__NSSingleEntryDictionaryI"), @selector(objectForKey:), @selector(singleEntryDictionaryI_crashSafe_objectForKey:));
    });
}

- (id) dictionaryI_crashSafe_objectForKey:(nonnull id)key
{
    return [self dictionaryI_crashSafe_objectForKey:key];
}
- (id) dictionary0_crashSafe_objectForKey:(nonnull id)key
{
    return [self dictionary0_crashSafe_objectForKey:key];
}
- (id) singleEntryDictionaryI_crashSafe_objectForKey:(nonnull id)key
{
    return [self singleEntryDictionaryI_crashSafe_objectForKey:key];
}

@end
