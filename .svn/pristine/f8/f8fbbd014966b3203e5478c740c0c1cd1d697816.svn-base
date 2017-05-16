//
//  DLStarView.m
//  DiLiRestaurant
//
//  Created by 地利 on 2017/4/11.
//  Copyright © 2017年 地利. All rights reserved.
//

#import "DLStarView.h"

@implementation DLStarView
- (instancetype)init
{
    if (self=[super init]) {
        
        [self CreatUI];
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        [self CreatUI];
    }
    return self;
}

- (void)CreatUI{
    CGFloat margin=10;
    CGFloat buttonW=30;
    for (int i=0; i<5; i++) {
        UIButton *starebutton=[[UIButton alloc]initWithFrame:CGRectMake(margin+(margin+buttonW)*i,(self.height-buttonW)/2.0, buttonW, buttonW)];
        [starebutton setImage:[UIImage imageNamed:@"star_normal"] forState:UIControlStateNormal];
        [starebutton setImage:[UIImage imageNamed:@"star_selected"] forState:UIControlStateSelected];
        [starebutton addTarget:self action:@selector(starClick:) forControlEvents:UIControlEventTouchUpInside];
        starebutton.tag=i;
        [self addSubview:starebutton];
    }
}
- (void)starClick:(UIButton *)sender{
    for (UIButton *obj in self.subviews) {
        if (obj.tag<=sender.tag) {
            obj.selected=YES;
        }
        else
            obj.selected=NO;
    }
    __weak typeof(self) unself=self;
    if (unself.selectNum) {
        unself.selectNum(sender.tag+1);
    }
}
@end
