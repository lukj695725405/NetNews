//
//  NewsModel.m
//  NetNews
//
//  Created by Lukj on 2017/3/10.
//  Copyright © 2017年 lukj. All rights reserved.
//

#import "NewsModel.h"
#import "NetworkTools.h"
#import <YYModel.h>
@implementation NewsModel

+ (void)requestNewsModelArrayWithUrlStr:(NSString *)urlStr andCompletionBlock:(void(^)(NSArray *modelArray))completionBlock{
    
    [[NetworkTools sharedTools] requestWithType:GET andUrlStr:urlStr andParams:nil andSuccessBlock:^(id responseObject) {
        
        NSDictionary *dic = (NSDictionary *)responseObject;
        //因为这个字典里面只有一个key,获取这个字典里面的key
        NSString *key = dic.allKeys.firstObject;
        //通过key获取新闻的字典数组
        NSArray *dicArray = [dic objectForKey:key];
        //通过YYModel完成字典转模型
        NSArray *modelArray = [NSArray yy_modelArrayWithClass:[NewsModel class] json:dicArray];
        //回调主线程 AFN回调主线程给你进行回调的
        completionBlock(modelArray);
        
    } andFailureBlock:^(id error) {
        
        NSLog(@"error:%@",error);
        
    }];
    
}

@end
