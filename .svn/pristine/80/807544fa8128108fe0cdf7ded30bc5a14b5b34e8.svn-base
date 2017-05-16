//
//  DLStoreListTableViewCell.m
//  DiLiRestaurant
//
//  Created by 地利 on 2017/3/13.
//  Copyright © 2017年 地利. All rights reserved.
//

#import "DLStoreListTableViewCell.h"

@interface DLStoreListTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UILabel *location;

@end

@implementation DLStoreListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setStoreInfo:(DLStoreListInfo *)storeInfo
{
    _storeInfo=storeInfo;
    self.name.text=storeInfo.name;
    self.location.text=storeInfo.address;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    self.name.textColor=selected?[UIColor redColor]:THEMECOLOR;
    self.name.text=selected?[NSString stringWithFormat:@"[当前]%@",self.storeInfo.name]:self.storeInfo.name;
}
@end
