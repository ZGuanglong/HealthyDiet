//
//  DLFoodsCommitViewController.m
//  DiLiRestaurant
//
//  Created by 地利 on 2017/4/11.
//  Copyright © 2017年 地利. All rights reserved.
//

#import "DLFoodsCommitViewController.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "JSTextView.h"
#import "DLStarView.h"
#define MAX_STARWORDS_LENGTH 120
@interface DLFoodsCommitViewController ()<UITextViewDelegate>

@property(assign,nonatomic)NSInteger tasteNum;

@property(assign,nonatomic)NSInteger costNum;


@property(weak,nonatomic)JSTextView *textView;

@end

@implementation DLFoodsCommitViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"菜品评价";
    self.view.backgroundColor=BackGroundColor;
    TPKeyboardAvoidingScrollView *scrollView=[[TPKeyboardAvoidingScrollView alloc]initWithFrame:ViewRect];
    scrollView.contentSize=CGSizeMake(0, scrollView.height+1);
    scrollView.showsHorizontalScrollIndicator=NO;
    [self.view addSubview:scrollView];
    
    UILabel *nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 60)];
    nameLabel.textAlignment=NSTextAlignmentCenter;
    nameLabel.text=_foodsinfo.dishesName;
    [scrollView addSubview:nameLabel];
    
    UILabel  *titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 20+CGRectGetMaxY(nameLabel.frame), 60, 30)];
    titleLabel.text=@"口味:";
    [scrollView addSubview:titleLabel];
    
    DLStarView *starview=[[DLStarView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(titleLabel.frame), CGRectGetMinY(titleLabel.frame), kScreenW-CGRectGetMaxX(titleLabel.frame)-20, 30)];
    __weak typeof(self) unself=self;
    starview.selectNum=^(NSInteger num){
        unself.tasteNum=num;
    };
    [scrollView addSubview:starview];
    
    UILabel  *costLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 20+CGRectGetMaxY(titleLabel.frame), 60, 30)];
    costLabel.text=@"性价比:";
    [scrollView addSubview:costLabel];
    
    DLStarView *costview=[[DLStarView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(costLabel.frame), CGRectGetMinY(costLabel.frame), kScreenW-CGRectGetMaxX(costLabel.frame)-20, 30)];

    costview.selectNum=^(NSInteger num){
        unself.costNum=num;
    };
    [scrollView addSubview:costview];
    
    UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(costview.frame)+10, kScreenW, 1)];
    lineView.backgroundColor=[UIColor lightGrayColor];
    [scrollView addSubview:lineView];
    
    JSTextView *textView=[[JSTextView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(lineView.frame)+10, kScreenW-20, kScreenW*3/5)];
    textView.myPlaceholder=@"亲:说说您对菜品的印象?";
    textView.delegate=self;
    textView.backgroundColor=[UIColor whiteColor];
    [scrollView addSubview:textView];
    self.textView=textView;
    
    
    DLRoundEdgeButton *commitButton=[[DLRoundEdgeButton alloc]initWithFrame:CGRectMake(50, CGRectGetMaxY(textView.frame)+20, kScreenW-100, 44)];
    [commitButton addTarget:self action:@selector(finishCommit) forControlEvents:UIControlEventTouchUpInside];
    commitButton.backgroundColor=THEMECOLOR;
    [commitButton setTitle:@"提交评价" forState:UIControlStateNormal];
    [scrollView addSubview:commitButton];

    
    // Do any additional setup after loading the view.
}

- (void)finishCommit{
    if (!self.tasteNum) {
        [MBProgressHUD showMessage:@"请选择口味等级"];
        return;
    }
    if (!self.costNum) {
        [MBProgressHUD showMessage:@"请选择性价比等级"];
        return;
    }

    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    dic.transCode=@"C0110";
    dic.type=@"add";
    [dic setObject:@1 forKey:@"evalType"];
    [dic setObject:@(self.eattime+20000) forKey:@"mealType"];
    [dic setObject:[DLUserInfo getUser].userId forKeyedSubscript:@"userId"];
    [dic setObject:@(self.tasteNum) forKey:@"tasteLevel"];
    [dic setObject:@(self.costNum) forKey:@"costLevel"];
    [dic setObject:self.foodsinfo.dishesCode forKey:@"dishesCode"];

    [dic setObject:self.textView.text forKey:@"content"];
    [dic setObject:[DLUserInfo getUserStore].storeId forKey:@"storeId"];
    [dic setObject:self.currentDate forKey:@"supplyDate"];
    [[GLNetWorkManager shareManager]requestType:POST andURL:REQUESTURL andServers:GETBANNER andParmas:dic andComplition:^(id response, BOOL isuccess) {
        MyLog(@"%@",response);
        if (isuccess&&[response[@"code"] isEqualToString:@"000000"]) {
            [MBProgressHUD showMessage:@"评论成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        }
    }];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        
        [textView resignFirstResponder];
        
        return NO;
        
    }
    
    return YES;
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)textViewDidChange:(UITextView *)textView
{
    NSString *toBeString = textView.text;
    
    NSArray *current = [UITextInputMode activeInputModes];
    
    UITextInputMode *currentInputMode = [current firstObject];
    
    NSString *lang = [currentInputMode primaryLanguage]; // 键盘输入模式
    
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        
        //获取高亮部分
        
        UITextRange *selectedRange = [textView markedTextRange];
        
        UITextPosition *position = [textView positionFromPosition:selectedRange.start offset:0];
        
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        
        if (!position) {
            
            if (toBeString.length > MAX_STARWORDS_LENGTH)
                
            {
                
                NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:MAX_STARWORDS_LENGTH];
                
                if (rangeIndex.length == 1){
                    
                    textView.text = [toBeString substringToIndex:MAX_STARWORDS_LENGTH];
                    
                }else{
                    
                    NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, MAX_STARWORDS_LENGTH)];
                    
                    textView.text = [toBeString substringWithRange:rangeRange];
                    
                }
                
            }
            
        }else{//有高亮选择的字符串，则暂不对文字进行统计和限制
            
            
            
        }
        
    }else {// 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
        
        if (toBeString.length > MAX_STARWORDS_LENGTH){
            
            NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:MAX_STARWORDS_LENGTH];
            
            if (rangeIndex.length == 1){
                
                textView.text = [toBeString substringToIndex:MAX_STARWORDS_LENGTH];
                
            }else{
                
                NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, MAX_STARWORDS_LENGTH)];
                
                textView.text = [toBeString substringWithRange:rangeRange];
                
            }
            
        }
        
    }
}

@end
