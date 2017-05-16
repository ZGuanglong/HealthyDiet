//
//  DLRoundEdgeButton.m
//  DiLiRestaurant
//
//  Created by 地利 on 2017/4/7.
//  Copyright © 2017年 地利. All rights reserved.
//

#import "DLRoundEdgeButton.h"

@implementation DLRoundEdgeButton

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.layer.cornerRadius=self.height/2.0;
    self.layer.masksToBounds=YES;
}
@end
