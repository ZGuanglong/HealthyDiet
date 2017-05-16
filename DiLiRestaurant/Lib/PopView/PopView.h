//
//  PopViewLikeQQView.h
//
//  Created by  on 16/1/22.
//  Copyright © 2016年 . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopView : UIView

+ (void)configCustomPopViewWithFrame:(CGRect)frame imagesArr:(NSArray *)imagesArr dataSourceArr:(NSArray *)dataourceArr anchorPoint:(CGPoint)anchorPoint seletedRowForIndex:(void(^)(NSInteger index))action animation:(BOOL)animation timeForCome:(NSTimeInterval)come timeForGo:(NSTimeInterval)go;
+ (void)removed;

@end
