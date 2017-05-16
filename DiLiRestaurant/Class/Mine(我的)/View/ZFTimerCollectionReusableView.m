//
//  ZFTimerCollectionReusableView.m
//  slyjg
//
//  Created by 王小腊 on 16/3/9.
//  Copyright © 2016年 王小腊. All rights reserved.
//

#import "ZFTimerCollectionReusableView.h"
@implementation ZFTimerCollectionReusableView


- (void)updateTimer:(NSArray*)array;
{
    self.timerLabel.text = [NSString stringWithFormat:@"%@年%@月",array[0],array[1]];

}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)leftClick:(UIButton *)sender {
    if (self.NextClick) {
        self.NextClick((int)sender.tag);
    }
}

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com
