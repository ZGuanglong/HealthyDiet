//
//  DLAlonePickView.m
//  DiLiRestaurant
//
//  Created by 地利 on 2017/3/17.
//  Copyright © 2017年 地利. All rights reserved.
//

#import "DLAlonePickView.h"
#define kPickerSize self.pickView.frame.size

@interface DLAlonePickView ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property(weak,nonatomic)UIPickerView *pickView;

@end

@implementation DLAlonePickView
- (void)setDataArray:(NSArray *)dataArray
{
    _dataArray=dataArray;
    [self.pickView reloadAllComponents];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor=[UIColor whiteColor];
        [self setupUI];
    }
    return self;
}
- (void)setLastString:(NSString *)lastString
{
    _lastString=[lastString copy];
    [self addLabelWithName:[lastString componentsSeparatedByString:@","]];
}
- (void)setupUI{
    UIPickerView  *pickview=[[UIPickerView alloc]initWithFrame:self.bounds];
    pickview.showsSelectionIndicator=YES;
    pickview.delegate=self;
    pickview.dataSource=self;
    [self addSubview:pickview];
    self.pickView=pickview;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.dataArray.count;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 44;
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *label=(UILabel *)view;
    if (!label) {
        label=[[UILabel alloc]init];
        label.textAlignment=NSTextAlignmentCenter;
    }
    label.text=self.dataArray[row];
    return label;
}

-(void)addLabelWithName:(NSArray *)nameArr {
    for (id subView in self.subviews) {
        if ([subView isKindOfClass:[UILabel class]]) {
            [subView removeFromSuperview];
        }
    }
    for (int i=0; i<nameArr.count; i++) {
        CGFloat labelX = kPickerSize.width/(nameArr.count*2)+18+kPickerSize.width/nameArr.count*i;
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(labelX, self.frame.size.height/2-40/2.0, 40, 40)];
        label.text = nameArr[i];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:24];
        label.textColor = self.themeColor;
        label.backgroundColor = [UIColor clearColor];
        [self addSubview:label];
    }
}
- (void)setDefaultValue:(NSString *)defaultValue
{
    _defaultValue=[defaultValue copy];
    self.resultValue=defaultValue;
    [self.pickView selectRow:[self.dataArray indexOfObject:defaultValue] inComponent:0 animated:YES];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.resultValue=self.dataArray[row];
}
@end
