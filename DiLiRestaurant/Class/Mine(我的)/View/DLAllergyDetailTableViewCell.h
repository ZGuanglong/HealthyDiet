//
//  DLAllergyDetailTableViewCell.h
//  DiLiRestaurant
//
//  Created by 地利 on 2017/3/23.
//  Copyright © 2017年 地利. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLAllergyDetailInfo.h"
@interface DLAllergyDetailTableViewCell : UITableViewCell

@property(strong,nonatomic)DLAllergyDetailInfo *detailInfo;

@property(copy,nonatomic)void (^selectClick)(DLAllergyDetailInfo *info, BOOL Isselect);

@end
