//
//  CrashManager.h
//  TempPro
//
//  Created by LHJ on 2017/6/23.
//  Copyright © 2017年 LHJ. All rights reserved.
//

#import <Foundation/Foundation.h>

#define CrashLog_File_Fun(str)     [NSString stringWithFormat:@"CrashManager -- 文件 %s 的 %s 方法：%@", __FILE__, __FUNCTION__ , str]

@interface CrashManager : NSObject

/** 记录闪退的信息
 @param strLog - crash记录信息
 */
+ (void) recordCrashWithLog:(NSString*)strLog;

/** 添加对于sel对应的方法，避免找不到方法报错 */
+ (BOOL) handleNSObjectResolveMethodWithInstance:(Class)cls withSEL:(SEL)sel;


@end
