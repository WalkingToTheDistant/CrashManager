//
//  NSString+Crash.m
//  TempPro
//
//  Created by LHJ on 2017/6/26.
//  Copyright © 2017年 LHJ. All rights reserved.
//

#import "NSString+Crash.h"
#import "CrashPublic.h"

@implementation NSString (Crash)

+ (void)initCrashCategory
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        // ---------- NSString的类簇 - __NSCFString，其中__NSCFConstantString是__NSCFString的子类，调用的还是__NSCFString的方法，所以这里__NSCFConstantString不需要修改
        MethodSwizzle(objc_getClass("__NSCFString"), @selector(substringFromIndex:), @selector(cfString_crashSafe_substringFromIndex:));
        MethodSwizzle(objc_getClass("__NSCFString"), @selector(substringToIndex:), @selector(cfString_crashSafe_substringToIndex:));
        MethodSwizzle(objc_getClass("__NSCFString"), @selector(substringWithRange:), @selector(cfString_crashSafe_substringWithRange:));
//        MethodSwizzle(objc_getClass("__NSCFString"), @selector(stringByReplacingOccurrencesOfString:withString:options:range:), @selector(cfString_crashSafe_stringByReplacingOccurrencesOfString:withString:options:range:));
//        MethodSwizzle(objc_getClass("__NSCFString"), @selector(stringByReplacingOccurrencesOfString:withString:), @selector(cfString_crashSafe_stringByReplacingOccurrencesOfString:withString:));
//        MethodSwizzle(objc_getClass("__NSCFString"), @selector(stringByReplacingCharactersInRange:withString:), @selector(cfString_crashSafe_stringByReplacingCharactersInRange:withString:));
//        MethodSwizzle(objc_getClass("__NSCFString"), @selector(stringByAppendingString:), @selector(cfString_crashSafe_stringByAppendingString:));
////        MethodSwizzle(objc_getClass("__NSCFString"), @selector(stringByAppendingFormat:), @selector(cfString_crashSafe_stringByAppendingFormat:));
//        MethodSwizzle(objc_getClass("__NSCFString"), @selector(stringByAppendingPathComponent:), @selector(cfString_crashSafe_stringByAppendingPathComponent:));
//        MethodSwizzle(objc_getClass("__NSCFString"), @selector(stringByAppendingPathExtension:), @selector(cfString_crashSafe_stringByAppendingPathExtension:));
//        MethodSwizzle(objc_getClass("__NSCFString"), @selector(componentsSeparatedByString:), @selector(cfString_crashSafe_componentsSeparatedByString:));
//        MethodSwizzle(objc_getClass("__NSCFString"), @selector(containsString:), @selector(cfString_crashSafe_containsString:));
//        MethodSwizzle(objc_getClass("__NSCFString"), @selector(rangeOfString:options:range:locale:), @selector(cfString_crashSafe_rangeOfString:options:range:locale:));
        
        
        // ---------- NSMutableString 属于 __NSCFString 类簇，所以直接修改__NSCFString的方法即可
//        MethodSwizzle(objc_getClass("__NSCFString"), @selector(replaceCharactersInRange:withString:), @selector(cfString_crashSafe_replaceCharactersInRange:withString:));
//
//        MethodSwizzle(objc_getClass("__NSCFString"), @selector(insertString:atIndex:), @selector(cfString_crashSafe_insertString:atIndex:));
//        MethodSwizzle(objc_getClass("__NSCFString"), @selector(deleteCharactersInRange:), @selector(cfString_crashSafe_deleteCharactersInRange:));
//        MethodSwizzle(objc_getClass("__NSCFString"), @selector(replaceOccurrencesOfString:withString:options:range:), @selector(cfString_crashSafe_replaceOccurrencesOfString:withString:options:range:));
//        MethodSwizzle(objc_getClass("__NSCFString"), @selector(appendString:), @selector(cfString_crashSafe_appendString:));
//        MethodSwizzle(objc_getClass("__NSCFString"), @selector(setString:), @selector(cfString_crashSafe_setString:));
//        MethodSwizzle(objc_getClass("__NSCFString"), @selector(appendFormat:), @selector(cfString_crashSafe_appendFormat:));
        
        
        // ---------- NSString的类簇 - NSTaggedPointerString，如果在Category的load中替换NSTaggedPointerString的方法，有可能NSTaggedPointerString这个类簇还没有加载父类的类方法列表指引到自己的类结构中，导致会找不到其方法Method，（Method为空，其IMP函数指针当然也为空），那么此时如果执行了Class_addMethod，会把一个空的IMP加载到对应SEL的Method中，然后把Method添加到NSTaggedPointerString类方法中，那么在NSTaggedPointerString类簇加载时监测到该SEL已经有实现了，那么就不会再继承父类的IMP了（个人推测当加载器监测到有这个SEL了，就不加载其父类的Method进来），那么在调用SEL时会找不到IMP，那么就会报错。（父类方法实现在Foundation类里面）
        MethodSwizzle(objc_getClass("NSTaggedPointerString"), @selector(substringFromIndex:), @selector(taggedPointerString_crashSafe_substringFromIndex:));
        MethodSwizzle(objc_getClass("NSTaggedPointerString"), @selector(substringToIndex:), @selector(taggedPointerString_crashSafe_substringToIndex:));
        MethodSwizzle(objc_getClass("NSTaggedPointerString"), @selector(substringWithRange:), @selector(taggedPointerString_crashSafe_substringWithRange:));
//        MethodSwizzle(objc_getClass("NSTaggedPointerString"), @selector(stringByReplacingOccurrencesOfString:withString:options:range:), @selector(taggedPointerString_crashSafe_stringByReplacingOccurrencesOfString:withString:options:range:));
//        MethodSwizzle(objc_getClass("NSTaggedPointerString"), @selector(stringByReplacingCharactersInRange:withString:), @selector(taggedPointerString_crashSafe_stringByReplacingCharactersInRange:withString:));
//        MethodSwizzle(objc_getClass("NSTaggedPointerString"), @selector(stringByAppendingString:), @selector(taggedPointerString_crashSafe_stringByAppendingString:));
////        MethodSwizzle(objc_getClass("NSTaggedPointerString"), @selector(stringByAppendingFormat:), @selector(taggedPointerString_crashSafe_stringByAppendingFormat:));
//        MethodSwizzle(objc_getClass("NSTaggedPointerString"), @selector(stringByAppendingPathComponent:), @selector(taggedPointerString_crashSafe_stringByAppendingPathComponent:));
//        MethodSwizzle(objc_getClass("NSTaggedPointerString"), @selector(stringByAppendingPathExtension:), @selector(taggedPointerString_crashSafe_stringByAppendingPathExtension:));
//        MethodSwizzle(objc_getClass("NSTaggedPointerString"), @selector(componentsSeparatedByString:), @selector(taggedPointerString_crashSafe_componentsSeparatedByString:));
//        MethodSwizzle(objc_getClass("NSTaggedPointerString"), @selector(containsString:), @selector(taggedPointerString_crashSafe_containsString:));
//        MethodSwizzle(objc_getClass("NSTaggedPointerString"), @selector(rangeOfString:options:range:locale:), @selector(taggedPointerString_crashSafe_rangeOfString:options:range:locale:));
        
        /** 注：因为***Format方法会触发转码出现乱码的情况，所以暂时先不做format的方法检测 */
        
        // ---------- NSString的类簇 NSPlaceholderString ，一般是初始化的时候出现，[NSString stringWith****]，[NSString alloc] initWith****，应该这几个方法是属于虚类方法，只有NSPlaceholderString继承类实现了这几个方法，其他类则并没有实现，所以在用其他类簇调用这几个方法会报错。
//        MethodSwizzle(objc_getClass("NSPlaceholderString"), @selector(initWithFormat:locale:arguments:), @selector(placeholderString_crashSafe_initWithFormat:locale:arguments:));
//        MethodSwizzle(objc_getClass("NSPlaceholderString"), @selector(initWithString:), @selector(placeholderString_crashSafe_initWithString:));
    });
}

// ================================================================================================================
#pragma mark - NSPlaceholderString
- (instancetype)placeholderString_crashSafe_initWithFormat:(NSString *)format locale:(nullable id)locale arguments:(va_list)argList
{
    if(format == nil){
        return [self init]; // 如果仅仅是[NSString alloc]不调用init，会返回NSPlaceholderString，这样调用init之后，NSPlaceholderString类簇的方法不需要再重写了
    }
    return [self placeholderString_crashSafe_initWithFormat:format locale:locale arguments:argList];
}
- (instancetype)placeholderString_crashSafe_initWithString:(NSString *)aString
{
    if(aString == nil){
        return [self init]; // 如果仅仅是[NSString alloc]不调用init，会返回NSPlaceholderString，这样调用init之后，NSPlaceholderString类簇的方法不需要再重写了
    }
    return [self placeholderString_crashSafe_initWithString:aString];
}







// ================================================================================================================
// pragma mark - __NSCFString
- (NSString *)cfString_crashSafe_stringByAppendingString:(NSString *)aString
{
    if(aString == nil){
        return self;
    }
    return [self cfString_crashSafe_stringByAppendingString:aString];
}
- (NSString *)cfString_crashSafe_stringByAppendingFormat:(NSString *)format, ...
{
    if(format == nil){
        return self;
    }
    va_list args;
    va_start(args, format);
    NSString *strResult = [[NSString alloc]initWithFormat:format arguments:args];
    va_end(args);
    
    return [self cfString_crashSafe_stringByAppendingFormat:strResult];
}
- (NSString *)cfString_crashSafe_stringByAppendingPathComponent:(NSString *)str
{
    if(str == nil){
        return self;
    }
    return [self cfString_crashSafe_stringByAppendingPathComponent:str];
}
- (nullable NSString *)cfString_crashSafe_stringByAppendingPathExtension:(NSString *)str
{
    if(str == nil){
        return self;
    }
    return [self cfString_crashSafe_stringByAppendingPathExtension:str];
}
- (NSArray<NSString *> *)cfString_crashSafe_componentsSeparatedByString:(NSString *)separator
{
    if(separator == nil){
        return nil;
    }
    return [self cfString_crashSafe_componentsSeparatedByString:separator];
}
- (BOOL)cfString_crashSafe_containsString:(NSString *)str
{
    if(str == nil){
        return NO;
    }
    return [self cfString_crashSafe_containsString:str];
}
- (NSRange)cfString_crashSafe_rangeOfString:(NSString *)searchString options:(NSStringCompareOptions)mask range:(NSRange)rangeOfReceiverToSearch locale:(nullable NSLocale *)locale
{
    if(searchString == nil){
        return NSMakeRange(NSNotFound, 0);
    }
    if(rangeOfReceiverToSearch.location > self.length){
        rangeOfReceiverToSearch.location = 0;
    }
    if((rangeOfReceiverToSearch.location + rangeOfReceiverToSearch.length) > self.length){
        rangeOfReceiverToSearch.length = self.length - rangeOfReceiverToSearch.location;
    }
    return [self cfString_crashSafe_rangeOfString:searchString options:mask range:rangeOfReceiverToSearch locale:locale];
}


- (NSString*) cfString_crashSafe_substringFromIndex:(NSUInteger)from
{
    if(from > self.length){
        return self;
    }
    return [self cfString_crashSafe_substringFromIndex:from];
}
- (NSString *)cfString_crashSafe_substringToIndex:(NSUInteger)to
{
    if(to > self.length){
        to = self.length;
    }
    return [self cfString_crashSafe_substringToIndex:to];
}

// substringFromIndex 和 substringToIndex 最终也会调用这个，所以只需要监测这个方法就可以了
- (NSString *)cfString_crashSafe_substringWithRange:(NSRange)range;
{
    if(range.location > self.length){
        return self;
    }
    if((range.location + range.length) > self.length){
        range.length = self.length - range.location;
    }
    return [self cfString_crashSafe_substringWithRange:range];
}
- (NSString *)cfString_crashSafe_stringByReplacingOccurrencesOfString:(NSString *)target withString:(NSString *)replacement options:(NSStringCompareOptions)options range:(NSRange)searchRange
{
    if(ObjIsNil(target) == YES
       || ObjIsNil(replacement) == YES){
        return self;
    }
    if(searchRange.location > self.length){
        searchRange.location = 0;
    }
    if((searchRange.location + searchRange.length) > self.length){
        searchRange.length = self.length - searchRange.location;
    }
    return [self cfString_crashSafe_stringByReplacingOccurrencesOfString:target withString:replacement options:options range:searchRange];
}
- (NSString *)cfString_crashSafe_stringByReplacingOccurrencesOfString:(NSString *)target withString:(NSString *)replacement
{
    if(ObjIsNil(target) == YES
       || ObjIsNil(replacement) == YES){
        return self;
    }
    return [self cfString_crashSafe_stringByReplacingOccurrencesOfString:target withString:replacement];
}
- (NSString *)cfString_crashSafe_stringByReplacingCharactersInRange:(NSRange)range withString:(NSString *)replacement
{
    if(ObjIsNil(replacement) == YES){
        return self;
    }
    if(range.location > self.length){
        return self;
    }
    if((range.location + range.length) > self.length){
        range.length = self.length - range.location;
    }
    return [self cfString_crashSafe_stringByReplacingCharactersInRange:range withString:replacement];
}








// ================================================================================================================
// pragma mark - NSMutableString
- (void)cfString_crashSafe_replaceCharactersInRange:(NSRange)range withString:(NSString *)aString
{
    if(ObjIsNil(aString) == YES){
        return;
    }
    if(range.location > self.length){
        return;
    }
    if((range.location + range.length) > self.length){
        range.length = self.length - range.location;
    }
    return [self cfString_crashSafe_replaceCharactersInRange:range withString:aString];
}
- (void)cfString_crashSafe_insertString:(NSString *)aString atIndex:(NSUInteger)loc
{
    if(ObjIsNil(aString) == YES){
        return;
    }
    if(loc > self.length){
        loc = self.length;
    }
    return [self cfString_crashSafe_insertString:aString atIndex:loc];
}
- (void)cfString_crashSafe_deleteCharactersInRange:(NSRange)range
{
    if(range.location > self.length){
        return;
    }
    if((range.location + range.length) > self.length){
        range.length = self.length - range.location;
    }
    return [self cfString_crashSafe_deleteCharactersInRange:range];
}
- (NSUInteger)cfString_crashSafe_replaceOccurrencesOfString:(NSString *)target withString:(NSString *)replacement options:(NSStringCompareOptions)options range:(NSRange)searchRange
{
    if(ObjIsNil(target) == YES
       || ObjIsNil(replacement) == YES){
        return 0;
    }
    if(searchRange.location > self.length){
        return 0;
    }
    if((searchRange.location + searchRange.length) > self.length){
        searchRange.length = self.length - searchRange.location;
    }
    return [self cfString_crashSafe_replaceOccurrencesOfString:target withString:replacement options:options range:searchRange];
}
- (void)cfString_crashSafe_appendString:(NSString *)aString
{
    if(aString == nil){
        return;
    }
    return [self cfString_crashSafe_appendString:aString];
}
- (void)cfString_crashSafe_appendFormat:(NSString *)format, ... 
{
    if(format == nil){
        return;
    }
    va_list argumentList;
    va_start(argumentList, format);
    NSString *appendStr = [[NSString alloc] initWithFormat:format arguments:argumentList];
    va_end(argumentList);
    
    return [self cfString_crashSafe_appendFormat:appendStr];
}
- (void)cfString_crashSafe_setString:(NSString *)aString
{
    if(aString == nil){
        return;
    }
    return [self cfString_crashSafe_setString:aString];
}





// ================================================================================================================
// pragma mark - NSTaggedPointerString
- (NSString *)taggedPointerString_crashSafe_stringByAppendingString:(NSString *)aString
{
    if(aString == nil){
        return self;
    }
    return [self taggedPointerString_crashSafe_stringByAppendingString:aString];
}
- (NSString*) taggedPointerString_crashSafe_substringFromIndex:(NSUInteger)from
{
    if(from > self.length){
        return self;
    }
    return [self taggedPointerString_crashSafe_substringFromIndex:from];
}
- (NSString *)taggedPointerString_crashSafe_substringToIndex:(NSUInteger)to
{
    if(to > self.length){
        to = self.length;
    }
    return [self taggedPointerString_crashSafe_substringToIndex:to];
}

// substringFromIndex 和 substringToIndex 最终也会调用这个，所以只需要监测这个方法就可以了
- (NSString *)taggedPointerString_crashSafe_substringWithRange:(NSRange)range;
{
    if(range.location > self.length){
        return self;
    }
    if((range.location + range.length) > self.length){
        range.length = self.length - range.location;
    }
    return [self taggedPointerString_crashSafe_substringWithRange:range];
}
- (NSString *)taggedPointerString_crashSafe_stringByReplacingOccurrencesOfString:(NSString *)target withString:(NSString *)replacement options:(NSStringCompareOptions)options range:(NSRange)searchRange
{
    if(ObjIsNil(target) == YES
       || ObjIsNil(replacement) == YES){
        return self;
    }
    if(searchRange.location > self.length){
        return self;
    }
    if((searchRange.location + searchRange.length) > self.length){
        searchRange.length = self.length - searchRange.location;
    }
    return [self taggedPointerString_crashSafe_stringByReplacingOccurrencesOfString:target withString:replacement options:options range:searchRange];
}
- (NSString *)taggedPointerString_crashSafe_stringByReplacingCharactersInRange:(NSRange)range withString:(NSString *)replacement
{
    if(ObjIsNil(replacement) == YES){
        return self;
    }
    if(range.location > self.length){
        return self;
    }
    if((range.location + range.length) > self.length){
        range.length = self.length - range.location;
    }
    return [self taggedPointerString_crashSafe_stringByReplacingCharactersInRange:range withString:replacement];
}
- (NSString *)taggedPointerString_crashSafe_stringByAppendingFormat:(NSString *)format, ...
{
    if(format == nil){
        return self;
    }
    va_list args;
    va_start(args, format);
    NSString *strResult = [[NSString alloc]initWithFormat:format arguments:args];
    va_end(args);
    
    return [self taggedPointerString_crashSafe_stringByAppendingFormat:strResult];
}
- (NSString *)taggedPointerString_crashSafe_stringByAppendingPathComponent:(NSString *)str
{
    if(str == nil){
        return self;
    }
    
    return [self taggedPointerString_crashSafe_stringByAppendingPathComponent:str];
}
- (nullable NSString *)taggedPointerString_crashSafe_stringByAppendingPathExtension:(NSString *)str
{
    if(str == nil){
        return self;
    }
    return [self taggedPointerString_crashSafe_stringByAppendingPathExtension:str];
}
- (NSArray<NSString *> *)taggedPointerString_crashSafe_componentsSeparatedByString:(NSString *)separator
{
    if(separator == nil){
        return nil;
    }
    return [self taggedPointerString_crashSafe_componentsSeparatedByString:separator];
}
- (BOOL)taggedPointerString_crashSafe_containsString:(NSString *)str
{
    if(str == nil){
        return NO;
    }
    return [self taggedPointerString_crashSafe_containsString:str];
}
- (NSRange)taggedPointerString_crashSafe_rangeOfString:(NSString *)searchString options:(NSStringCompareOptions)mask range:(NSRange)rangeOfReceiverToSearch locale:(nullable NSLocale *)locale
{
    if(searchString == nil){
        return NSMakeRange(NSNotFound, 0);
    }
    if(rangeOfReceiverToSearch.location > self.length){
        rangeOfReceiverToSearch.location = 0;
    }
    if((rangeOfReceiverToSearch.location + rangeOfReceiverToSearch.length) > self.length){
        rangeOfReceiverToSearch.length = self.length - rangeOfReceiverToSearch.location;
    }
    return [self taggedPointerString_crashSafe_rangeOfString:searchString options:mask range:rangeOfReceiverToSearch locale:locale];
}


@end
