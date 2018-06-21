//
//  Public.h
//  TempPro
//
//  Created by LHJ on 2017/6/23.
//  Copyright © 2017年 LHJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "CrashManager.h"

#define ObjIsNil(obj) (obj == nil || [obj isKindOfClass:[NSNull class]] == YES)

void MethodSwizzle(Class cls , SEL oriSelector, SEL dstSelector);

id indexCrashHandle(Class cls);

id keyCrashHandle(Class cls);


@interface CrashPublic : NSObject

/** 开启防止Crash的功能，可以在application:didFinishLaunchingWithOptions 方法里面调用 */
+ (void) openCrashHandleFunction;

@end
