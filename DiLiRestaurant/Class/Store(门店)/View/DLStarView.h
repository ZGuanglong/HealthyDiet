//
//  DLStarView.h
//  DiLiRestaurant
//
//  Created by 地利 on 2017/4/11.
//  Copyright © 2017年 地利. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DLStarView : UIView

@property(copy,nonatomic)void (^selectNum)(NSInteger num);

@end
