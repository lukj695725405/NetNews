//
//  NetworkTools.m
//  NetNews
//
//  Created by Lukj on 2017/3/10.
//  Copyright © 2017年 lukj. All rights reserved.
//

#import "NetworkTools.h"

@implementation NetworkTools

+ (instancetype)sharedTools{
    
    static NetworkTools *tools;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tools = [[NetworkTools alloc] initWithBaseURL:[NSURL URLWithString:@"http://c.m.163.com/nc/article/list/"]];
    });
    
    return tools;
}


/**
 通用的请求方式

 @param requestType 请求的类型
 @param urlStr 请求的地址
 @param params 请求的参数
 @param successBlock 成功的回调
 @param failureBlock 失败的回调
 */
- (void)requestWithType:(RequestType)requestType andUrlStr:(NSString *)urlStr andParams:(id)params andSuccessBlock:(void(^)(id responseObject))successBlock andFailureBlock:(void(^)(id error))failureBlock{
    
    if (requestType == GET) {
        
        [self GET:urlStr parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            successBlock(responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            failureBlock(error);
        }];
        
    }else{
        
        [self POST:urlStr parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            successBlock(responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"error:%@",error);
            failureBlock(error);
        }];
    }
    
    
}

@end
