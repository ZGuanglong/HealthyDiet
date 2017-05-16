//
//  DLAllergyDetailInfo.h
//  DiLiRestaurant
//
//  Created by 地利 on 2017/3/23.
//  Copyright © 2017年 地利. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DLAllergyDetailInfo : NSObject

@property(copy,nonatomic)NSString *ID;

@property(copy,nonatomic)NSString *status;

@property(copy,nonatomic)NSString *allergyType1;

@property(copy,nonatomic)NSString *allergyType2;

@property(copy,nonatomic)NSString *allergyName;

@property(assign,nonatomic)BOOL isSelect;


@end
