//
//  DLOtherDemandViewController.m
//  DiLiRestaurant
//
//  Created by 地利 on 2017/3/15.
//  Copyright © 2017年 地利. All rights reserved.
//

#import "DLOtherDemandViewController.h"
#import "DLTabooTableViewCell.h"
#import "ZHRulerView.h"
@interface DLOtherDemandViewController ()<UITableViewDelegate,UITableViewDataSource,ZHRulerViewDelegate>
@property(weak,nonatomic)UITableView *tableView;

@property(weak,nonatomic)UIButton *selectBotton;

@property(assign,nonatomic)CGFloat targetValue;

@property(weak,nonatomic)UILabel *targetWeight;

@property(weak,nonatomic)ZHRulerView *RulerView;

@end

@implementation DLOtherDemandViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"其他需求";
    self.titleLabel.text=@"请选择要达到的其他目的";
    self.baseValue=[DLUserInfo getUserDetail].otherReq;
    if (strIsEmpty([DLUserInfo getUserDetail].targetWeight)) {
        if (self.type==FirstType) {
            if ([[DLUser share].sex isEqualToString:@"1"]) {
                self.targetValue=50;
            }
            else
                self.targetValue=60;
        }
        else
        {
            if ([[DLUserInfo getUser].sex isEqualToString:@"1"]) {
                self.targetValue=50;
            }
            else
                self.targetValue=60;

        }
    }
    else
        self.targetValue=[DLUserInfo getUserDetail].targetWeight.floatValue;
    UITableView *tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 60, kScreenW, kScreenH-64-60) style:UITableViewStylePlain];
    tableView.delegate=self;
    tableView.dataSource=self;
    [self.ContentView addSubview:tableView];
    self.tableView=tableView;
    tableView.backgroundColor=[UIColor clearColor];
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DLTabooTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"check"];
    [self getData];

    // Do any additional setup after loading the view.
}

- (void)getData{
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    dic.transCode=@"M0038";
    dic.type=@"findAll";
    [dic setObject:@25 forKey:@"dictType"];
    //    [dic setObject:@1 forKey:@"isShow"];
    //    [dic setObject:@1 forKey:@"status"];
    [[GLNetWorkManager shareManager]requestType:POST andURL:REQUESTURL andServers:GET_WORK_TYPE andParmas:dic andComplition:^(id response, BOOL isuccess) {
        if (isuccess&&[response[@"code"] isEqualToString:SUCCESSCODE]) {
            [self.dataArray addObjectsFromArray:[DLTabooInfo mj_objectArrayWithKeyValuesArray:response[@"list"]]];
            if (!strIsEmpty(self.baseValue)) {
                NSArray *selectCode=[self.baseValue componentsSeparatedByString:@","];
                [selectCode enumerateObjectsUsingBlock:^(NSString *code, NSUInteger idx, BOOL * _Nonnull stop) {
                    [self.dataArray enumerateObjectsUsingBlock:^(DLTabooInfo   *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        if ([code isEqualToString:obj.code]) {
                            obj.isSelect=YES;
                        }
                    }];
                }];
            }
            [self.tableView reloadData];
        }
        
        MyLog(@"%@",response);
    }];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    DLTabooInfo *info=self.dataArray[section];
    if ([info.code isEqualToString:@"250001"]&&info.isSelect) {
        return 3;
    }
    else if ([info.code isEqualToString:@"250002"]&info.isSelect)
        return 2;
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DLTabooInfo *tabooinfo=self.dataArray[indexPath.section];
    if (indexPath.row==1&&[tabooinfo.code isEqualToString:@"250001"]) {
        UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.contentView.backgroundColor=BackGroundColor;
        UILabel *titlelable=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 30)];
        titlelable.text=@"目标体重";
        titlelable.textAlignment=NSTextAlignmentCenter;
        [cell.contentView addSubview:titlelable];
        UILabel *target=[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(titlelable.frame), kScreenW, 30)];
        target.textColor=THEMECOLOR;
        target.textAlignment=NSTextAlignmentCenter;
        target.text=[NSString stringWithFormat:@"%.0fkg",self.targetValue];
        [cell.contentView addSubview:target];
        self.targetWeight=target;
        ZHRulerView *rulerView=[[ZHRulerView alloc]initWithMixNuber:40 maxNuber:200 showType:rulerViewshowHorizontalType rulerMultiple:1];
        rulerView.defaultVaule=self.targetValue;
        rulerView.frame=CGRectMake(0, CGRectGetMaxY(target.frame), kScreenW, 80);
        rulerView.delegate=self;
        [cell.contentView addSubview:rulerView];
        self.RulerView=rulerView;
        return cell;
    }
    else if (indexPath.row==2&&[tabooinfo.code isEqualToString:@"250001"]){
        UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.contentView.backgroundColor=BackGroundColor;

        NSArray *array=@[@"当前体重",@"需减总热量",@"建议用时",@"每天消耗热量"];
        for (int i=0; i<array.count; i++) {
            UIView *bgview=[[UIView alloc]initWithFrame:CGRectMake(i%2*kScreenW/2, i/2*60, kScreenW/2, 60)];
            bgview.layer.borderWidth=0.5;
            bgview.layer.borderColor=shouldgraycolor.CGColor;
            [cell.contentView addSubview:bgview];
            UILabel *titlelabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, bgview.width, bgview.height/2.0)];
            titlelabel.textAlignment=NSTextAlignmentCenter;
            titlelabel.text=array[i];
            [bgview addSubview:titlelabel];
            UILabel *contentLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, bgview.height/2.0, bgview.width, bgview.height/2.0)];
            contentLabel.textAlignment=NSTextAlignmentCenter;
            contentLabel.textColor=THEMECOLOR;
            [bgview addSubview:contentLabel];
            switch (i) {
                case 0:
                    contentLabel.text=[NSString stringWithFormat:@"%@kg",[DLUserInfo getUserDetail].weight];
                    break;
                case 1:
                {
                    CGFloat currentW=self.type==FirstType?[DLUser share].weight.floatValue:[DLUserInfo getUserDetail].weight.floatValue;
                    contentLabel.text=[NSString stringWithFormat:@"%.0fkcal",(currentW-self.targetValue)*7700];
                }
                    break;
                case 2:
                {
                    CGFloat currentW=self.type==FirstType?[DLUser share].weight.floatValue:[DLUserInfo getUserDetail].weight.floatValue;
                    contentLabel.text=[NSString stringWithFormat:@"%.0f周(%.0f)天",currentW-self.targetValue,(currentW-self.targetValue)*7];
                }
                    break;
                case 3:
                    contentLabel.text=@"550kcal";
                default:
                    break;
            }
//            bgview.backgroundColor=BackGroundColor;
        }
        return cell;
    }
    else if (indexPath.row==1&&indexPath.section&&[tabooinfo.code isEqualToString:@"250002"]){
        UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.contentView.backgroundColor=BackGroundColor;
        UILabel *contentLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, kScreenW-20, [self tableView:tableView heightForRowAtIndexPath:indexPath])];
        contentLabel.text=@"饮食方面要注意三餐定时定量，每天可增加100-300kcal的能量摄入，适当增加蛋白质摄入比例，同时要进行适当的体育锻炼，以避免增加的能量转化为脂肪增加身体患病风险。";
        contentLabel.font=font16;
        contentLabel.numberOfLines=0;
        [cell.contentView addSubview:contentLabel];
        return cell;
    }
    DLTabooTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"check" forIndexPath:indexPath];
    cell.tabooInfo=tabooinfo;
    if (tabooinfo.isSelect) {
        self.selectBotton=cell.CheckButton;
        objc_setAssociatedObject(self.selectBotton, @"lastSelect", tabooinfo, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    __weak typeof(self) unself=self;
    cell.RadioBlock=^(UIButton *sender){
        if (unself.selectBotton!=sender&&self.selectBotton) {
            unself.selectBotton.selected=NO;
            DLTabooInfo *info=objc_getAssociatedObject(self.selectBotton,  @"lastSelect");
            info.isSelect=NO;
        }
        unself.selectBotton=sender;
        objc_setAssociatedObject(self.selectBotton, @"lastSelect", tabooinfo, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [unself.tableView reloadData];
    };
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DLTabooInfo *info=self.dataArray[indexPath.section];
    if (indexPath.row==1&&[info.code isEqualToString:@"250001"]) {
        return 140;
    }
    else if (indexPath.row==2&&[info.code isEqualToString:@"250001"]){
        return 120;
    }
    else if (indexPath.row==1&&[info.code isEqualToString:@"250002"]){
        NSString *str=@"饮食方面要注意三餐定时定量，每天可增加100-300kcal的能量摄入，适当增加蛋白质摄入比例，同时要进行适当的体育锻炼，以避免增加的能量转化为脂肪增加身体患病风险。";
        CGFloat height=[Globel getSizeOfString:str maxWidth:kScreenW-20 maxHeight:CGFLOAT_MAX withFontSize:16.3].height;
        return height;
    }
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc]init];
    //    view.backgroundColor=[UIColor whiteColor];
    self.doneButton.frame=CGRectMake(50, 20, kScreenW-100, 40);
    [view addSubview:self.doneButton];
    if (self.type==FirstType) {
        CGRect rect=self.doneButton.frame;
        rect.origin.y+=60;
        self.skipButton.frame=rect;
        [view addSubview:self.skipButton];
    }
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section==[self numberOfSectionsInTableView:tableView]-1) {
        if (self.type==OtherType) {
            return 60;
        }
        return 100;

    }
    return 0;
}

-(void)getRulerValue:(CGFloat)rulerValue withScrollRulerView:(ZHRulerView *)rulerView{
    self.targetValue=rulerValue;
    self.targetWeight.text=[NSString stringWithFormat:@"%.01fkg",rulerValue];
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
}
- (void)done
{
    [super done];
    if (self.type==FirstType) {
        DLTabooInfo *info;
        for (int i=0; i<self.dataArray.count; i++) {
            if (((DLTabooInfo *)self.dataArray[i]).isSelect) {
                info=self.dataArray[i];
                break;
            }
        }

        if (info) {
            if ([info.code isEqualToString:@"250001"]) {
                [DLUser share].reqType=@"2";
                [DLUser share].targetWeight=[NSString stringWithFormat:@"%.0f",self.targetValue];
            }
            else if ([info.code isEqualToString:@"250002"]){
                [DLUser share].reqType=@"1";
                [DLUser share].targetWeight=@"";
            }
            else
            {
                [DLUser share].reqType=@"0";
                [DLUser share].targetWeight=@"";
            }
        }
        [DLUser share].otherReq=info.code;
        [self skipMain];
    }
    else
    {
        [self updateInfo];
    }
}


- (void)updateInfo
{
    DLTabooInfo *info;
    for (int i=0; i<self.dataArray.count; i++) {
        if (((DLTabooInfo *)self.dataArray[i]).isSelect) {
            info=self.dataArray[i];
            break;
        }
    }
    NSMutableDictionary *updatedic=[NSMutableDictionary dictionary];
    [updatedic setObject:@"C0100" forKey:@"transCode"];
    [updatedic setObject:@"update" forKey:@"type"];
    [updatedic setObject:[DLUserInfo getUser].userId forKey:@"userId"];
    [updatedic setObject:@"" forKey:@"specialCrowdCode"];
    [updatedic setObject:[DLUserInfo getUserDetail].weight forKey:@"weight"];
    if ([info.code isEqualToString:@"250001"]) {
        [updatedic setObject:@2 forKey:@"reqType"];
        [updatedic setObject:[NSString stringWithFormat:@"%.0f",self.targetValue] forKey:@"targetWeight"];
    }
    else if ([info.code isEqualToString:@"250002"]){
        [updatedic setObject:@1 forKey:@"reqType"];
        [updatedic setObject:@"" forKey:@"targetWeight"];
    }
    else
    {
        [updatedic setObject:@3 forKey:@"reqType"];
        [updatedic setObject:@"" forKey:@"targetWeight"];
    }
    if (info) {
        [updatedic setObject:info.code forKey:@"otherReq"];
    }
    else
    {
        [updatedic setObject:@"" forKey:@"otherReq"];
    }
    [[GLNetWorkManager shareManager]requestType:POST andURL:REQUESTURL andServers:GET_WORK_TYPE andParmas:updatedic andComplition:^(id response, BOOL isuccess) {
        if (isuccess&&[response[@"code"] isEqualToString:SUCCESSCODE]) {
            self.returnValue=info.dictName;
            [self getuserinfo];
        }
    }];
    
}

@end
