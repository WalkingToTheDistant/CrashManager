//
//  Public.m
//  TempPro
//
//  Created by LHJ on 2017/6/23.
//  Copyright © 2017年 LHJ. All rights reserved.
//

#import "CrashPublic.h"
#import "NSArray+Crash.h"
#import "NSDictionary+Crash.h"
#import "NSMutableArray+Crash.h"
#import "NSMutableDictionary+Crash.h"
#import "NSString+Crash.h"
#import "NSNull+Crash.h"

// ========================================================================
void MethodSwizzle(Class cls , SEL oriSelector, SEL dstSelector)
{
    if(cls == nil){ return; }
    
    Method oriMethod = class_getInstanceMethod(cls, oriSelector);
    Method dstMethod = class_getInstanceMethod(cls, dstSelector);
    BOOL isAdd = class_addMethod(cls, oriSelector, method_getImplementation(dstMethod), method_getTypeEncoding(dstMethod));
    if(isAdd == YES
       && oriMethod != nil){
        class_replaceMethod(cls, dstSelector, method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod));
    } else {
        method_exchangeImplementations(oriMethod, dstMethod);
    }
}
id indexCrashHandle(Class cls)
{
    return [CrashManager new];
}
id keyCrashHandle(Class cls)
{
    return [CrashManager new];
}

// ========================================================================
@implementation CrashPublic

+ (void) openCrashHandleFunction{
    [NSArray initCrashCategory];
    [NSDictionary initCrashCategory];
    [NSMutableDictionary initCrashCategory];
    [NSMutableArray initCrashCategory];
    [NSString initCrashCategory];
}

@end

// ========================================================================
