//
//  DLTabooTableViewCell.m
//  DiLiRestaurant
//
//  Created by 地利 on 2017/3/20.
//  Copyright © 2017年 地利. All rights reserved.
//

#import "DLTabooTableViewCell.h"

@interface DLTabooTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;


@end

@implementation DLTabooTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)buttonCheck:(UIButton *)sender {
    sender.selected=!sender.selected;
    self.tabooInfo.isSelect=sender.isSelected;
    if (self.RadioBlock) {
        self.RadioBlock(sender);
    }
}

- (void)setTabooInfo:(DLTabooInfo *)tabooInfo
{
    _tabooInfo=tabooInfo;
    self.nameLabel.text=tabooInfo.dictName;
    self.CheckButton.selected=tabooInfo.isSelect;
}
@end
