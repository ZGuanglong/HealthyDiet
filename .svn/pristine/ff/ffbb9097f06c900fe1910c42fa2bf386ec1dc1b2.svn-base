//
//  DLMineViewController.m
//  DiLiRestaurant
//
//  Created by 地利 on 2017/3/9.
//  Copyright © 2017年 地利. All rights reserved.
//

#import "DLMineViewController.h"
#import "JSTextView.h"
#import "DLMineDataViewController.h"
#import "DLSettingViewController.h"
#import "DLServerCenterViewController.h"
#define MAX_STARWORDS_LENGTH 500
@interface DLMineViewController ()<UITextViewDelegate>
@property(nonatomic,strong) UIImageView * imageView;

@property(nonatomic,strong)UIView * tableHeaderView;

@property(nonatomic,weak)UIImageView * headImageView;

@property(strong,nonatomic)NSArray *titleArray;

@property(weak,nonatomic)JSTextView *textView;
@end

@implementation DLMineViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    //    self.navigationController.navigationBarHidden=YES;
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
-(UIView *)tableHeaderView{
    if (!_tableHeaderView) {
        _tableHeaderView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0,kScreenW, 200*kScreenW/375)];
        _tableHeaderView.userInteractionEnabled=YES;
    }
    return _tableHeaderView;
}

-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 200*kScreenW/375)];
        _imageView.autoresizingMask=UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _imageView.clipsToBounds=YES;
        _imageView.userInteractionEnabled=YES;
        _imageView.contentMode=UIViewContentModeScaleAspectFill;
    }
    return _imageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    MyLog(@"%@",[DLUserInfo getUser].sex.empty);
    if ([DLUserInfo getUser]) {
        [self getuserinfo];
    }
//    self.tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    self.titleArray=@[@"iv_user_icon",@"我的资料",@"mine_set",@"设置",@"wachat",@"服务中心"];
    self.imageView.image=[UIImage imageNamed:@"head_bg"];
    [self.tableHeaderView addSubview:self.imageView];
    self.tableView.tableHeaderView=self.tableHeaderView;
    CGFloat headviewWidth=self.imageView.width*0.2;
    UIImageView *headView=[[UIImageView alloc]initWithFrame:CGRectMake(self.imageView.centerX-headviewWidth/2,60 , headviewWidth, headviewWidth)];
    headView.userInteractionEnabled=YES;
    headView.layer.cornerRadius=headviewWidth/2;
    headView.layer.masksToBounds=YES;
    UITapGestureRecognizer *headTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ChoiceImage)];
    [headView addGestureRecognizer:headTap];
    [headView sd_setImageWithURL:[NSURL URLWithString:[Globel getUserInfoIcon]] placeholderImage:[UIImage imageNamed:@"defaultHead"]];
    [self.imageView addSubview:headView];
    self.headImageView=headView;

    UILabel *namelabel=[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(headView.frame)+20, CGRectGetWidth(self.imageView.frame), 20)];
    namelabel.textAlignment=NSTextAlignmentCenter;
    namelabel.text=strIsEmpty([DLUserInfo getUser].mobileNum)?[DLUserInfo getUser].userName:[DLUserInfo getUser].mobileNum;
    namelabel.textColor=[UIColor whiteColor];
    [self.imageView addSubview:namelabel];
    
    // Do any additional setup after loading the view.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section) {
        return 1;
    }
    else
        return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!indexPath.section) {
        static NSString *cellID=@"cell0";
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            UIView *lineview=[[UIView alloc]initWithFrame:CGRectMake(10, [self tableView:tableView heightForRowAtIndexPath:indexPath]-0.5, kScreenW-20, 0.5)];
            lineview.backgroundColor=shouldgraycolor;
            [cell.contentView addSubview:lineview];
        }
        cell.imageView.image=[UIImage imageNamed:self.titleArray[indexPath.row*2]];
        cell.textLabel.text=self.titleArray[indexPath.row*2+1];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        return cell;

    }
    else if (indexPath.section==1){
        static NSString *cellID=@"cell1";
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            UIView *lineview=[[UIView alloc]initWithFrame:CGRectMake(10, [self tableView:tableView heightForRowAtIndexPath:indexPath]-0.5, kScreenW-20, 0.5)];
            lineview.backgroundColor=shouldgraycolor;
            [cell.contentView addSubview:lineview];

        }
        cell.imageView.image=[UIImage imageNamed:@"change_user"];
        NSString *title=[DLUserInfo GetVersionType]==PersonalType?@"切换为团体版":@"切换为个人版";
        cell.textLabel.text=title;
        UISwitch *switchView=[[UISwitch alloc]initWithFrame:CGRectMake(0, 0, 80, 30)];
        [switchView addTarget:self action:@selector(changeInfo:) forControlEvents:UIControlEventValueChanged];
        cell.accessoryView=switchView;
        return cell;

    }
    static NSString *cellID=@"cell2";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    UILabel *titlebel=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, kScreenW-20, 20)];
    titlebel.text=@"请输入您的宝贵意见:";
    titlebel.font=font14;
    [cell.contentView addSubview:titlebel];
    JSTextView *textView=[[JSTextView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(titlebel.frame), kScreenW-20, 100)];
    textView.myPlaceholder=@"500字";
    textView.delegate=self;
    textView.backgroundColor=RGBColor(239, 240, 241);
    [cell.contentView addSubview:textView];
    self.textView=textView;
    
    UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(30, CGRectGetMaxY(textView.frame)+10, kScreenW-60, 44)];
    button.backgroundColor=THEMECOLOR;
    button.layer.cornerRadius=button.height/2.0;
    [button addTarget:self action:@selector(commit:) forControlEvents:UIControlEventTouchUpInside];
    button.layer.masksToBounds=YES;
    [button setTitle:@"提交" forState:UIControlStateNormal];
    [cell.contentView addSubview:button];
    return cell;

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==2) {
        return 194;
    }
    return 55;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    __weak typeof(self) unself=self;
    if (!indexPath.section) {
        if (!indexPath.row) {
            DLMineDataViewController *minedataVC=[[DLMineDataViewController alloc]init];
            minedataVC.changeIcon=^{
                [unself getuserinfo];
            };
            [self.navigationController pushViewController:minedataVC animated:YES];
        }
        else if (indexPath.row==1){
            DLSettingViewController *setVC=[[DLSettingViewController alloc]init];
            [self.navigationController pushViewController:setVC animated:YES];
        }
        else if (indexPath.row==2){
            DLServerCenterViewController *serverVC=[[DLServerCenterViewController alloc]init];
            [self.navigationController pushViewController:serverVC animated:YES];
        }

    }
    
}

- (void)ChoiceImage
{
    TZImagePickerController *PickerVC=[[TZImagePickerController alloc]initWithMaxImagesCount:1 delegate:nil];
    __weak typeof(self) unself=self;
    PickerVC.didFinishPickingPhotosHandle=^(NSArray<UIImage *> *photos,NSArray *assets,BOOL isSelectOriginalPhoto){
        unself.headImageView.image=photos[0];
        
        [unself loadHeadImage:photos[0]];
        
        
    };
    [self presentViewController:PickerVC animated:YES completion:nil];

}

- (void)loadHeadImage:(UIImage *)image{
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setObject:@"C0100" forKey:@"transCode"];
    [dic setObject:@"upload_head_photo" forKey:@"type"];
    
    NSData *data = UIImageJPEGRepresentation(image, 0.5);
    
    
    // 在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
    // 要解决此问题，
    // 可以在上传时使用当前的系统事件作为文件名
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // 设置时间格式
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *str = [formatter stringFromDate:[NSDate date]];
    NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
    
    [dic setObject:[data base64EncodedStringWithOptions:0] forKey:@"byteString"];
    [dic setObject:fileName forKey:@"fileName"];
    [[GLNetWorkManager shareManager]requestType:POST andURL:REQUESTURL andServers:UPLOAD_PHOTO andParmas:dic andComplition:^(id response, BOOL isuccess) {
        if ([response[@"code"] isEqualToString:@"000000"]) {
            NSMutableDictionary *updatedic=[NSMutableDictionary dictionary];
            [updatedic setObject:@"C0100" forKey:@"transCode"];
            [updatedic setObject:@"update" forKey:@"type"];
            [updatedic setObject:[DLUserInfo getUser].userId forKey:@"userId"];
            [updatedic setObject:response[@"suffixAddress"] forKey:@"headPhotoAdd"];
            [[GLNetWorkManager shareManager]requestType:POST andURL:REQUESTURL andServers:GET_WORK_TYPE andParmas:updatedic andComplition:^(id response, BOOL isuccess) {
                MyLog(@"%@",response);
            }];

        }
        MyLog(@"%@",response);
    }];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint offset = scrollView.contentOffset;
    if (offset.y < 0) {
        CGRect rect =self.tableHeaderView.frame;
        rect.origin.y = offset.y;
        rect.size.height =CGRectGetHeight(rect)-offset.y;
        self.imageView.frame = rect;
        self.tableHeaderView.clipsToBounds=NO;
    }
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

- (void)getuserinfo{
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setObject:[DLUserInfo getUser].userId forKey:@"userId"];
    [dic setObject:@"C0100" forKey:@"transCode"];
    [dic setObject:@"findDetail" forKey:@"type"];
    [[GLNetWorkManager shareManager]requestType:POST andURL:REQUESTURL andServers:GET_WORK_TYPE andParmas:dic andComplition:^(id response, BOOL isuccess) {
        if ([response[@"code"] isEqualToString:@"000000"]) {
            [DLUserInfo SaveUserInfoFromDic:response];
            [self.headImageView sd_setImageWithURL:[NSURL URLWithString:[Globel getUserInfoIcon]] placeholderImage:[UIImage imageNamed:@"defaultHead"]];
        }
        
        MyLog(@"%@",response);
    }];
}

- (void)changeInfo:(UISwitch *)sender{
    [DLUserInfo SaveVersionType:![DLUserInfo GetVersionType]];
    [((AppDelegate *)[UIApplication sharedApplication].delegate) enterMainVC];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        
        [textView resignFirstResponder];
        
        return NO;
        
    }
    
    return YES;
    
}

- (void)commit:(UIButton *)sender{
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    dic.transCode=@"C0110";
    dic.type=@"add";
    [dic setObject:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] forKey:@"version"];
    [dic setObject:[DLUserInfo getUser].userId forKeyedSubscript:@"userId"];
    [dic setObject:self.textView.text forKey:@"content"];
    [[GLNetWorkManager shareManager]requestType:POST andURL:REQUESTURL andServers:GETBANNER andParmas:dic andComplition:^(id response, BOOL isuccess) {
        MyLog(@"%@",response);
        if (isuccess&&[response[@"code"] isEqualToString:@"000000"]) {
            [MBProgressHUD showMessage:@"评论成功"];
        }
    }];

}
@end
