//
//  NSObject+NetWork.h
//  DiLiRestaurant
//
//  Created by 地利 on 2017/3/13.
//  Copyright © 2017年 地利. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (NetWork)

@property(copy,nonatomic)NSString *transCode;

@property(copy,nonatomic)NSString *type;

@property(strong,nonatomic)NSNumber *currentPage;

@property(strong,nonatomic)NSNumber *pageSize;
@end
