//
//  DLUserDetail.m
//  DiLiRestaurant
//
//  Created by 地利 on 2017/3/10.
//  Copyright © 2017年 地利. All rights reserved.
//

#import "DLUserDetail.h"

@implementation DLUserDetail
-(NSString *)allergyName
{
    if (strIsEmpty(_allergyName)) {
        return @"";
    }
    return _allergyName;
}

- (NSString *)periodNum
{
    if (strIsEmpty(_periodNum)) {
        return @"";
    }
    return _periodNum;
}

- (NSString *)periodStartTime
{
    if (strIsEmpty(_periodStartTime)) {
        return @"";
    }
    return _periodStartTime;
}

- (NSString *)periodEndTime
{
    if (strIsEmpty(_periodEndTime)) {
        return @"";
    }
    return _periodEndTime;
}
@end
