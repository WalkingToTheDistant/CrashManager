//
//  NSMutableDictionary+Crash.h
//  TempPro
//
//  Created by LHJ on 2017/6/23.
//  Copyright © 2017年 LHJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (Crash)

+ (void)initCrashCategory;

- (void) crashSafe_setValue:(id)value forKey:(NSString *)key;

- (void)crashSafe_removeObjectForKey:(id)aKey;

- (void)crashSafe_setObject:(id)anObject forKey:(id<NSCopying>)aKey;

@end
