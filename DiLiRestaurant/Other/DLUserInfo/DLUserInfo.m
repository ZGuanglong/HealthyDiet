//
//  DLUserInfo.m
//  DiLiRestaurant
//
//  Created by 地利 on 2017/3/10.
//  Copyright © 2017年 地利. All rights reserved.
//

#import "DLUserInfo.h"

#define Versiontype @"versiontype"

@implementation DLUserInfo
+ (NSString *)filepath{
    NSString *plistPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) lastObject];
    //得到完整的文件名
    NSString *filename=[plistPath stringByAppendingPathComponent:@"userinfo.plist"];
    return filename;
}
+(NSString *)filePathappendName:(NSString *)name{
    NSString *plistPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) lastObject];
    //得到完整的文件名
    NSString *filename=[plistPath stringByAppendingPathComponent:name];
    return filename;

}

+(VersionType)GetVersionType{
    if (strIsEmpty([[NSUserDefaults standardUserDefaults]objectForKey:Versiontype])) {
        return NoneType;
    }
    else
    {
        NSString *num=[[NSUserDefaults standardUserDefaults]objectForKey:Versiontype];
        return num.boolValue;
    }
}

+(void)SaveVersionType:(VersionType)type{
    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%ld",(long)type] forKey:Versiontype];
}

+(void)SaveUserInfoFromDic:(NSDictionary *)dic
{
    BOOL resut=[NSKeyedArchiver archiveRootObject:dic toFile:[DLUserInfo filepath]];
    MyLog(@"存入情况%i",resut);
}
+(DLUser *)getUser{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL result = [fileManager fileExistsAtPath:[DLUserInfo filepath]];
    if (!result) {
        return nil;
    }
    else{
        NSDictionary *userdic=[NSKeyedUnarchiver unarchiveObjectWithFile:[DLUserInfo filepath]][@"user"];
        DLUser *user=[DLUser mj_objectWithKeyValues:userdic];
        return user;
    }

}

+ (void)removeUserInfo
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL result = [fileManager fileExistsAtPath:[DLUserInfo filepath]];
    if (result) {
        NSError *error=nil;
        if ([fileManager removeItemAtPath:[DLUserInfo filepath] error:&error]) {
            MyLog(@"删除个人信息成功");
        }
        
    }

}

+ (void)SaveStoreInfo:(DLStoreListInfo *)storeinfo
{
    BOOL resut=[NSKeyedArchiver archiveRootObject:storeinfo toFile:[DLUserInfo filePathappendName:@"storeinfo.plist"]];
    MyLog(@"存入情况%i",resut);
}

+(DLUserDetail *)getUserDetail{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL result = [fileManager fileExistsAtPath:[DLUserInfo filepath]];
    if (!result) {
        return nil;
    }
    else{
    NSDictionary *userDetaildic=[NSKeyedUnarchiver unarchiveObjectWithFile:[DLUserInfo filepath]][@"userDetail"];
    [DLUserDetail mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{@"ID":@"id"};
    }];
    DLUserDetail *userdetail=[DLUserDetail mj_objectWithKeyValues:userDetaildic];
    return userdetail;
    }
}

+(DLStoreListInfo*)getUserStore{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL result = [fileManager fileExistsAtPath:[DLUserInfo filePathappendName:@"storeinfo.plist"]];
    if (!result) {
        return nil;
    }
    else{
        DLStoreListInfo *storeInfo=[NSKeyedUnarchiver unarchiveObjectWithFile:[DLUserInfo filePathappendName:@"storeinfo.plist"]];
        return storeInfo;
    }
}

+(void)SaveLocationCity:(NSDictionary *)dic{
    BOOL resut=[NSKeyedArchiver archiveRootObject:dic toFile:[DLUserInfo filePathappendName:@"locationcity.plist"]];
    MyLog(@"存入情况%i",resut);
}
+ (DLCityCode *)getLocationCity
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL result = [fileManager fileExistsAtPath:[DLUserInfo filePathappendName:@"locationcity.plist"]];
    if (!result) {
        return nil;
    }
    else{
        NSDictionary *storedic=[NSKeyedUnarchiver unarchiveObjectWithFile:[DLUserInfo filePathappendName:@"locationcity.plist"]];
        return [DLCityCode mj_objectWithKeyValues:storedic];
    }
}
@end