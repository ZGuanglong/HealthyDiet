//
//  DLAllergyCategaryTableViewCell.h
//  DiLiRestaurant
//
//  Created by 地利 on 2017/3/23.
//  Copyright © 2017年 地利. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLAllergyInfo.h"
#import "DLStoreCategaryInfo.h"
#import "DLCustomFoodsCategaryInfo.h"
@interface DLAllergyCategaryTableViewCell : UITableViewCell

@property(strong,nonatomic)DLAllergyInfo *allergyInfo;

@property(strong,nonatomic)DLStoreCategaryInfo *categaryInfo;

@property(strong,nonatomic)DLCustomFoodsCategaryInfo *customInfo;
@end
