//
//  DLAllergyDetailTableViewCell.m
//  DiLiRestaurant
//
//  Created by 地利 on 2017/3/23.
//  Copyright © 2017年 地利. All rights reserved.
//

#import "DLAllergyDetailTableViewCell.h"

@interface DLAllergyDetailTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UIButton *selectButton;


@end

@implementation DLAllergyDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setDetailInfo:(DLAllergyDetailInfo *)detailInfo
{
    _detailInfo=detailInfo;
    self.nameLabel.text=detailInfo.allergyName;
    self.selectButton.selected=detailInfo.isSelect;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)clickButton:(UIButton *)sender {
    sender.selected=!sender.selected;
    self.detailInfo.isSelect=sender.isSelected;
    if (self.selectClick) {
        self.selectClick(self.detailInfo,sender.isSelected);
    }
}

@end
