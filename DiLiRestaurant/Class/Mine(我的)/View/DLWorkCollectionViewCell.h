//
//  DLWorkCollectionViewCell.h
//  DiLiRestaurant
//
//  Created by 地利 on 2017/3/16.
//  Copyright © 2017年 地利. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLWorkdetailInfo.h"
@interface DLWorkCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIButton *namebutton;


@property(strong,nonatomic)DLWorkdetailInfo *workinfo;

@end
