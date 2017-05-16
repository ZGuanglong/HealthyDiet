//
//  ChoiceView.m
//  EveryDay
//
//  Created by tidoo on 16/4/23.
//  Copyright © 2016年 Tidoo. All rights reserved.
//

#import "ChoiceView.h"

@interface ChoiceView ()

@property(nonatomic,strong)NSArray *titleArray;

@property(nonatomic,weak)UIButton *selectbutton;

@property(nonatomic,strong)NSMutableArray *buttonArray;

@property(nonatomic,weak)UIView *lineView;
@end

@implementation ChoiceView

- (NSMutableArray *)buttonArray
{
    if (!_buttonArray) {
        _buttonArray=[NSMutableArray array];
    }
    return _buttonArray;
}

- (instancetype)initWithFrame:(CGRect)frame andtitleArray:(NSArray *)titlearray{
    if (self=[super initWithFrame:frame]) {
        self.titleArray=titlearray;
        [self creatView];
    }
    return self;
}
- (void)creatView{
    CGFloat buttonW=CGRectGetWidth(self.bounds)/self.titleArray.count-1;
    CGFloat buttonH=CGRectGetHeight(self.bounds)-1;
    for (int i=0; i<self.titleArray.count; i++) {
        UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(i*(buttonW+1), 0, buttonW, buttonH)];
        [self addSubview:button];
        [button setTitle:self.titleArray[i] forState:UIControlStateNormal];
        [button setTitle:self.titleArray[i] forState:UIControlStateSelected];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:THEMECOLOR forState:UIControlStateSelected];
        button.titleLabel.font=[UIFont systemFontOfSize:16];
        [button addTarget:self action:@selector(didselectbutton:) forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.textAlignment=NSTextAlignmentCenter;
        button.tag=i;
        UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(button.frame), 2, 1, buttonH-3)];
        lineView.backgroundColor=[UIColor lightGrayColor];
        [self addSubview:lineView];
        
        [self.buttonArray addObject:button];
        if (!i) {
            button.selected=YES;
            self.selectbutton=button;
            
            UIView *bottomlineView=[[UIView alloc]initWithFrame:CGRectMake(0, buttonH, buttonW+1, 1)];
            bottomlineView.backgroundColor=THEMECOLOR;
            [self addSubview:bottomlineView];
            self.lineView=bottomlineView;
        }
    }
}

- (void)didselectbutton:(UIButton *)sender{
    [self buttonclick:sender];
    if (self.clickbuttonblock) {
        self.clickbuttonblock(sender.tag);
    }
}

- (void)buttonclick:(UIButton *)sender{
    self.selectbutton.backgroundColor=self.backgroundcolor;
    self.selectbutton.selected=NO;
    sender.backgroundColor=self.selectbackgroundcolor;
    sender.selected=YES;
    self.selectbutton=sender;
    
    CGRect rect=sender.frame;
    rect.origin.y=rect.size.height;
    rect.size.height=1.0;
    [UIView animateWithDuration:0.75 animations:^{
        self.lineView.frame=rect;
    }];
}
- (void)clickbuttonAtIndex:(NSInteger)index{
    UIButton *button=self.buttonArray[index];
    [self buttonclick:button];
}

- (void)setBackgroundcolor:(UIColor *)backgroundcolor
{
    _backgroundcolor=backgroundcolor;
    for (int i=0; i<self.buttonArray.count; i++) {
        if (i) {
            [(UIButton *)self.buttonArray[i] setBackgroundColor:backgroundcolor];
        }
    }
}

- (void)setSelectbackgroundcolor:(UIColor *)selectbackgroundcolor
{
    _selectbackgroundcolor=selectbackgroundcolor;
    [(UIButton *)self.buttonArray[0] setBackgroundColor:selectbackgroundcolor];
}

- (void)setTitlecolor:(UIColor *)titlecolor{
    _titlecolor=titlecolor;
    [self.buttonArray enumerateObjectsUsingBlock:^(UIButton  *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj setTitleColor:titlecolor forState:UIControlStateNormal];
    }];
}

- (void)setSelecttitlecolor:(UIColor *)selecttitlecolor
{
    _selecttitlecolor=selecttitlecolor;
    [self.buttonArray enumerateObjectsUsingBlock:^(UIButton  *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj setTitleColor:selecttitlecolor forState:UIControlStateSelected];
    }];

}

- (void)setFontSize:(CGFloat)FontSize
{
    _FontSize=FontSize;
    [self.buttonArray enumerateObjectsUsingBlock:^(UIButton  *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.titleLabel.font=[UIFont systemFontOfSize:FontSize];
    }];

}
@end
