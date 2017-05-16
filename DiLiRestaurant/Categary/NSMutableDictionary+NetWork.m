//
//  NSObject+NetWork.m
//  DiLiRestaurant
//
//  Created by 地利 on 2017/3/13.
//  Copyright © 2017年 地利. All rights reserved.
//

#import "NSMutableDictionary+NetWork.h"

@implementation NSMutableDictionary (NetWork)



- (void)setTransCode:(NSString *)transCode
{
    [self setObject:transCode forKey:@"transCode"];
}
- (void)setType:(NSString *)type
{
    [self setObject:type forKey:@"type"];
}
- (void)setCurrentPage:(NSNumber *)currentPage
{
    [self setObject:currentPage forKey:@"currentPage"];
}

- (void)setPageSize:(NSNumber *)pageSize
{
    [self setObject:pageSize forKey:@"pageSize"];
}
- (NSString *)transCode
{
    return self.transCode;
}

- (NSString *)type
{
    return self.type;
}

- (NSNumber *)currentPage
{
    return self.currentPage;
}

- (NSNumber *)pageSize
{
    return self.pageSize;
}
@end
