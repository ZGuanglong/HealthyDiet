//
//  DLUser.m
//  DiLiRestaurant
//
//  Created by 地利 on 2017/3/10.
//  Copyright © 2017年 地利. All rights reserved.
//

#import "DLUser.h"

@implementation DLUser
+(instancetype)share{
    static DLUser *user=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        user=[[DLUser alloc]init];
    });
    return user;
}
@end
