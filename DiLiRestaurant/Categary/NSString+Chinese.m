//
//  NSString+Chinese.m
//  DaYoERP
//
//  Created by 财神软件 on 16/11/2.
//  Copyright © 2016年 财神软件. All rights reserved.
//

#import "NSString+Chinese.h"

@implementation NSString (Chinese)
-(NSString *)empty
{
    if (strIsEmpty(self)) {
        return @"";
    }
    else
        return self;
}
- (BOOL)isChinese
{
    NSString *match = @"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:self];
}

- (BOOL)includeChinese
{
    for(int i=0; i< [self length];i++)
    {
        int a =[self characterAtIndex:i];
        if( a >0x4e00&& a <0x9fff){
            return YES;
        }
    }
    return NO;
}

+ (NSString *)lr_stringDate {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    return dateString;
}
@end
