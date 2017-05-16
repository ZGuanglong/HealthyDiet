//
//  DLTabooTableViewCell.h
//  DiLiRestaurant
//
//  Created by 地利 on 2017/3/20.
//  Copyright © 2017年 地利. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLTabooInfo.h"
@interface DLTabooTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *CheckButton;


@property(copy,nonatomic)void (^RadioBlock)(UIButton *button);

@property(strong,nonatomic)DLTabooInfo *tabooInfo;

@end
