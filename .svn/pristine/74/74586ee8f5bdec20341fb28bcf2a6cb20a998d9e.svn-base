//
//  DLWorkHeadCollectionReusableView.m
//  DiLiRestaurant
//
//  Created by 地利 on 2017/3/16.
//  Copyright © 2017年 地利. All rights reserved.
//

#import "DLWorkHeadCollectionReusableView.h"

@interface DLWorkHeadCollectionReusableView ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *detailLabel;


@end

@implementation DLWorkHeadCollectionReusableView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setIndex:(NSInteger)index
{
    _index=index;
    switch (index) {
        case 0:
            self.nameLabel.text=@"轻体力";
            self.detailLabel.text=@"75%时间坐或站立；25%时间站着活动";
            break;
        case 1:
            self.nameLabel.text=@"中等体力";
            self.detailLabel.text=@"25%时间坐或站立；75%时间特殊活";
            break;
        case 2:
            self.nameLabel.text=@"重体力";
            self.detailLabel.text=@"40%时间坐或站立；60%时间特殊职业活动";
            break;
        default:
            break;
    }
}
@end
