//
//  NSMutableArray+Crash.h
//  TempPro
//
//  Created by LHJ on 2017/6/23.
//  Copyright © 2017年 LHJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (Crash)

+ (void)initCrashCategory;;

- (id _Nullable) crashSafe_objectAtIndex:(NSUInteger)index;

- (void) crashSafe_addObject:(id _Nullable )anObject;

- (void) crashSafe_setObject:(nonnull id)anObject atIndexedSubscript:(NSUInteger)index;

- (void) crashSafe_insertObject:(id _Nullable )anObject atIndex:(NSUInteger)index;

@end
