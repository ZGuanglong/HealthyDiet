//
//  DLHaveMealsTableViewCell.m
//  DiLiRestaurant
//
//  Created by 地利 on 2017/4/6.
//  Copyright © 2017年 地利. All rights reserved.
//

#import "DLHaveMealsTableViewCell.h"

@interface DLHaveMealsTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *weightLabel;

@property (weak, nonatomic) IBOutlet UILabel *energyLabel;


@end

@implementation DLHaveMealsTableViewCell
- (void)awakeFromNib
{
    [super awakeFromNib];
    self.energyLabel.layer.borderColor=[UIColor redColor].CGColor;
}

- (void)setMearsInfo:(DLHaveMealsInfo *)mearsInfo
{
    _mearsInfo=mearsInfo;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:mearsInfo.imageUrl] placeholderImage:[UIImage imageNamed:@"food_icon_default"]];
    self.nameLabel.text=mearsInfo.dishesName;
    self.weightLabel.text=[NSString stringWithFormat:@"%.02fg",mearsInfo.weight];
    self.energyLabel.text=[NSString stringWithFormat:@"%.02fkcal",mearsInfo.energyKc];
}
@end
