//
//  NetWorkManager.h
//
//  Created by 财神软件 on 17/2/16.
//  Copyright © 2017年 财神软件. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

typedef enum{
    GET,
    POST
} RequestType;

@interface GLNetWorkManager : AFHTTPSessionManager

+ (instancetype)shareManager;
- (void)requestType:(RequestType)type andURL:(NSString *)urlstr andServers:(NSString *)server andParmas:(id)parmas andComplition:(void (^)(id response,BOOL isuccess))complition;
@end
