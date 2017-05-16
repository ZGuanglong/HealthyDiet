//
//  DLStoreFoodsTableViewCell.h
//  DiLiRestaurant
//
//  Created by 地利 on 2017/4/1.
//  Copyright © 2017年 地利. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLStorefoodsInfo.h"
@interface DLStoreFoodsTableViewCell : UITableViewCell

@property(copy,nonatomic)void (^commitBlock)(DLStorefoodsInfo *foodinfo);

@property(assign,nonatomic)EatChoiceType eatType;
//区别是不是来自首页门店
@property(assign,nonatomic)BOOL isStore;


@property(strong,nonatomic)DLStorefoodsInfo *foodsInfo;


@end
