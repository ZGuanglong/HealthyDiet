//
//  UIBarButtonItemAdditions.h
//  CityGuide
//
//  Created by COLD FRONT on 12-6-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem(Additions)

+ (UIBarButtonItem *)leftBarButtonItemWithImage:(UIImage *)image
                                    highlighted:(UIImage *)highlightedImage
                                         target:(id)target
                                       selector:(SEL)selector;

+ (UIBarButtonItem *)rightBarButtonItemWithImage:(UIImage *)image
                                     highlighted:(UIImage *)highlightedImage
                                          target:(id)target
                                        selector:(SEL)selector;

+ (UIBarButtonItem *) leftBarButtonItemWithTitle:(NSString *)title
                                          target:(id)target
                                        selector:(SEL)selector;

+ (UIBarButtonItem *)rightBarButtonItemWithTitle:(NSString *)title
                                          target:(id)target
                                        selector:(SEL)selector;
+(UIBarButtonItem *)rightsBarButtonItemWithtarget:(id)target andleftImage:(UIImage *)leftImage selector:(SEL)leftselector andrightImage:(UIImage *)rightImage selector:(SEL)rightselector;

+(UIBarButtonItem *)rightsBarButtonItemWithtarget:(id)target andleftTitle:(NSString *)lefttitle selector:(SEL)leftselector andrightTitle:(NSString *)righttitle selector:(SEL)rightselector;
@end
