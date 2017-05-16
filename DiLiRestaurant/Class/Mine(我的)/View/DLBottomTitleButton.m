//
//  DLBottomTitleButton.m
//  DiLiRestaurant
//
//  Created by 地利 on 2017/3/9.
//  Copyright © 2017年 地利. All rights reserved.
//

#import "DLBottomTitleButton.h"

@implementation DLBottomTitleButton
- (instancetype)init
{
    if (self=[super init]) {
        self.titleLabel.textAlignment=NSTextAlignmentCenter;
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.frame=CGRectMake(10, 10, self.width-20, self.width-20);
    self.titleLabel.frame=CGRectMake(0, CGRectGetMaxY(self.imageView.frame)+10, self.width, 20);
    self.titleLabel.textAlignment=NSTextAlignmentCenter;
//    self.imageView.centerX=self.width/2.0;
//    self.titleLabel.y=self.width+20;
//    self.titleLabel.centerX=self.width/2.0;
}
@end
