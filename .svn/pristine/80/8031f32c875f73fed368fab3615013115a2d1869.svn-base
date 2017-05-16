//
//  DLStoreListInfo.m
//  DiLiRestaurant
//
//  Created by 地利 on 2017/3/13.
//  Copyright © 2017年 地利. All rights reserved.
//

#import "DLStoreListInfo.h"

@interface DLStoreListInfo ()<NSCoding>



@end

@implementation DLStoreListInfo

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self=[super init]) {
        self.name=[aDecoder decodeObjectForKey:@"name"];
        self.address=[aDecoder decodeObjectForKey:@"address"];
        self.storeId=[aDecoder decodeObjectForKey:@"storeId"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.address forKey:@"address"];
    [aCoder encodeObject:self.storeId forKey:@"storeId"];
}

@end
