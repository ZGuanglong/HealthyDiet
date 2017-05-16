//
//  DLServerCenterViewController.m
//  DiLiRestaurant
//
//  Created by 地利 on 2017/4/14.
//  Copyright © 2017年 地利. All rights reserved.
//

#import "DLServerCenterViewController.h"

@interface DLServerCenterViewController ()<UIDocumentInteractionControllerDelegate>

@property(strong,nonatomic)UIDocumentInteractionController *documentController;

@end

@implementation DLServerCenterViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"服务中心";
    [self.dataArray addObjectsFromArray:@[@"iv_help",@"帮助中心",instructionUrL,@"iv_about",@"关于",aboutUsUrL]];
    [self createXLSFile];
    // Do any additional setup after loading the view.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count/3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID=@"cell0";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        UIView *lineview=[[UIView alloc]initWithFrame:CGRectMake(10, [self tableView:tableView heightForRowAtIndexPath:indexPath]-0.5, kScreenW-20, 0.5)];
        lineview.backgroundColor=shouldgraycolor;
        [cell.contentView addSubview:lineview];
    }
    cell.imageView.image=[UIImage imageNamed:self.dataArray[indexPath.row*3]];
    cell.textLabel.text=self.dataArray[indexPath.row*3+1];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WKWebViewController *webView=[[WKWebViewController alloc]init];
    webView.urlSring=[REQUEHTML5STURL stringByAppendingString:self.dataArray[indexPath.row*3+2]];
    [self.navigationController pushViewController:webView animated:YES];
//    NSString * filePath = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"xls"];
//    NSString * filePath =[[[NSBundle mainBundle] resourcePath]stringByAppendingPathComponent:@"test.xls"];
//    MyLog(@"%@",[NSData dataWithContentsOfFile:filePath]);
//    // 文件路径
//    NSString *path = NSHomeDirectory();
//    NSString *filePath = [path stringByAppendingPathComponent:@"/Documents/export.xls"];
//    _documentController = [UIDocumentInteractionController interactionControllerWithURL:[NSURL fileURLWithPath:filePath]];
//    
//    _documentController.delegate = self;
//    
//    _documentController.UTI = @"com.microsoft.excel.xls";//You need to set the UTI (Uniform Type Identifiers) for the documentController object so that it can help the system find the appropriate application to open your document. In this case, it is set to “com.adobe.pdf”, which represents a PDF document. Other common UTIs are "com.apple.quicktime-movie" (QuickTime movies), "public.html" (HTML documents), and "public.jpeg" (JPEG files)
//    
//    [_documentController presentOpenInMenuFromRect:CGRectZero inView:self.view animated:YES];
    
}

/**
 *  预览用的Controller
 */
-(UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller{
    return self;
}

/**
 *  预览用的View
 */
-(UIView *)documentInteractionControllerViewForPreview:(UIDocumentInteractionController *)controller{
    return self.view;
}

- (void)documentInteractionControllerWillBeginPreview:(UIDocumentInteractionController *)controller{
    MyLog(@"will begin preview");
}

- (void)documentInteractionControllerDidEndPreview:(UIDocumentInteractionController *)controller{
    MyLog(@"did end preview");
}

- (void)createXLSFile {
    // 创建存放XLS文件数据的数组
    NSMutableArray  *xlsDataMuArr = [[NSMutableArray alloc] init];
    // 第一行内容
    [xlsDataMuArr addObject:@"Time"];
    [xlsDataMuArr addObject:@"Address"];
    [xlsDataMuArr addObject:@"Person"];
    [xlsDataMuArr addObject:@"Reason"];
    [xlsDataMuArr addObject:@"Process"];
    [xlsDataMuArr addObject:@"Result"];
    // 100行数据
    for (int i = 0; i < 100; i ++) {
        [xlsDataMuArr addObject:@"2016-12-06 17:18:40"];
        [xlsDataMuArr addObject:@"GuangZhou"];
        [xlsDataMuArr addObject:@"Mr.Liu"];
        [xlsDataMuArr addObject:@"Buy"];
        [xlsDataMuArr addObject:@"TaoBao"];
        [xlsDataMuArr addObject:@"Debt"];
    }
    // 把数组拼接成字符串，连接符是 \t（功能同键盘上的tab键）
    NSString *fileContent = [xlsDataMuArr componentsJoinedByString:@"\t"];
    // 字符串转换为可变字符串，方便改变某些字符
    NSMutableString *muStr = [fileContent mutableCopy];
    // 新建一个可变数组，存储每行最后一个\t的下标（以便改为\n）
    NSMutableArray *subMuArr = [NSMutableArray array];
    for (int i = 0; i < muStr.length; i ++) {
        NSRange range = [muStr rangeOfString:@"\t" options:NSBackwardsSearch range:NSMakeRange(i, 1)];
        if (range.length == 1) {
            [subMuArr addObject:@(range.location)];
        }
    }
    // 替换末尾\t
    for (NSUInteger i = 0; i < subMuArr.count; i ++) {
//#warning  下面的6是列数，根据需求修改
        if ( i > 0 && (i%6 == 0) ) {
            [muStr replaceCharactersInRange:NSMakeRange([[subMuArr objectAtIndex:i-1] intValue], 1) withString:@"\n"];
        }
    }
    // 文件管理器
    NSFileManager *fileManager = [[NSFileManager alloc]init];
    //使用UTF16才能显示汉字；如果显示为#######是因为格子宽度不够，拉开即可
    NSData *fileData = [muStr dataUsingEncoding:NSUTF16StringEncoding];
    // 文件路径
//    NSString *path = NSHomeDirectory();
//    NSString *filePath = [path stringByAppendingPathComponent:@"/Documents/export.xls"];
//    MyLog(@"文件路径：\n%@",filePath);
    // 生成xls文件
    [fileManager createFileAtPath:[self shareFilePath:@"export.xls"] contents:fileData attributes:nil];
}

-(NSString*)shareFilePath:(NSString*)filePath {
    
    NSArray *paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    
    NSString*documentsDirectory = [paths objectAtIndex:0];
    
    return [documentsDirectory stringByAppendingPathComponent: filePath];
    
}
@end
