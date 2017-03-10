//
//  NetworkTools.h
//  NetNews
//
//  Created by Lukj on 2017/3/10.
//  Copyright © 2017年 lukj. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
//网络请求工具类
typedef enum : NSUInteger {
    GET,
    POST
} RequestType;

@interface NetworkTools : AFHTTPSessionManager

+ (instancetype)sharedTools;

/**
 通用的请求方式
 
 @param requestType 请求的类型
 @param urlStr 请求的地址
 @param params 请求的参数
 @param successBlock 成功的回调
 @param failureBlock 失败的回调
 */
- (void)requestWithType:(RequestType)requestType andUrlStr:(NSString *)urlStr andParams:(id)params andSuccessBlock:(void(^)(id responseObject))successBlock andFailureBlock:(void(^)(id error))failureBlock;

@end
