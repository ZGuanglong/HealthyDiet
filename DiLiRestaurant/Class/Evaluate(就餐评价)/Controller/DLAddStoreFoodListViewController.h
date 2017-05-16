//
//  DLAddFoodDetailViewController.h
//  DiLiRestaurant
//
//  Created by 地利 on 2017/4/1.
//  Copyright © 2017年 地利. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DLAllergyCategaryTableViewCell.h"

@interface DLAddStoreFoodListViewController : UIViewController
@property(assign,nonatomic)EatChoiceType eatType;

@property(assign,nonatomic)NSInteger Eatingtime;


@property(copy,nonatomic)NSString *currentDate;

@property(strong,nonatomic)NSMutableArray <DLStoreCategaryInfo*>*dataArray;

@end
