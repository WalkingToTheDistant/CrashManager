//
//  NSArray+Crash.h
//  TempPro
//
//  Created by LHJ on 2017/6/23.
//  Copyright © 2017年 LHJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Crash)

+ (void)initCrashCategory;

- (id)crashSafe_objectAtIndex:(NSUInteger)index;

@end
