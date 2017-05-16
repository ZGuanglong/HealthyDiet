//
//  DLAllergyCategaryTableViewCell.m
//  DiLiRestaurant
//
//  Created by 地利 on 2017/3/23.
//  Copyright © 2017年 地利. All rights reserved.
//

#import "DLAllergyCategaryTableViewCell.h"
#import "DLBottomTitleButton.h"
@interface DLAllergyCategaryTableViewCell ()

@property (weak, nonatomic) IBOutlet DLBottomTitleButton *nameButton;


@end

@implementation DLAllergyCategaryTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.nameButton.titleLabel.textAlignment=NSTextAlignmentCenter;
    // Initialization code
}
- (void)setAllergyInfo:(DLAllergyInfo *)allergyInfo
{
    _allergyInfo=allergyInfo;
    [self.nameButton setTitle:allergyInfo.allergyType1 forState:UIControlStateNormal];
    [self.nameButton setImage:[UIImage imageNamed:allergyInfo.allergyType1] forState:UIControlStateNormal];
    [self.nameButton setTitle:allergyInfo.allergyType1 forState:UIControlStateSelected];
    [self.nameButton setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_pressed",allergyInfo.allergyType1]] forState:UIControlStateSelected];
}

- (void)setCategaryInfo:(DLStoreCategaryInfo *)categaryInfo
{
    _categaryInfo=categaryInfo;
    [self.nameButton setTitle:categaryInfo.dishesTypeName forState:UIControlStateNormal];
    [self.nameButton setImage:[UIImage imageNamed:categaryInfo.dishesTypeName] forState:UIControlStateNormal];
    [self.nameButton setTitle:categaryInfo.dishesTypeName forState:UIControlStateSelected];
    [self.nameButton setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_press",categaryInfo.dishesTypeName]] forState:UIControlStateSelected];
    
}

- (void)setCustomInfo:(DLCustomFoodsCategaryInfo *)customInfo{
    _customInfo=customInfo;
    [self.nameButton setTitle:customInfo.dictName forState:UIControlStateNormal];
    [self.nameButton setImage:[UIImage imageNamed:customInfo.dictName] forState:UIControlStateNormal];
    [self.nameButton setTitle:customInfo.dictName forState:UIControlStateSelected];
    [self.nameButton setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_press",customInfo.dictName]] forState:UIControlStateSelected];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.nameButton.selected=selected;
    self.contentView.backgroundColor = selected ? [UIColor whiteColor]:RGBColor(240, 240, 240);
    // Configure the view for the selected state
}

@end
