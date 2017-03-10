//
//  ChannelModel.m
//  NetNews
//
//  Created by Lukj on 2017/3/10.
//  Copyright © 2017年 lukj. All rights reserved.
//

#import "ChannelModel.h"
#import <YYModel.h>
@implementation ChannelModel
//获取频道里的模型数据
+ (NSArray *)getChannelModelArray{
    
    //json文件路径
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"topic_news.json" ofType:nil];
    //获取文件对应的json的二进制数据
    NSData *data = [NSData dataWithContentsOfFile:jsonPath];
    //反序列化json数据
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
    //获取tList对应的频道数组字典数据
    NSArray *channelDicArray = [dic objectForKey:@"tList"];
    //使用YYModel完成字典转模型操作
    NSArray *modelArray = [NSArray yy_modelArrayWithClass:[ChannelModel class] json:channelDicArray];

    return modelArray;
    
}



- (NSString *)description{
    
    NSString *str = [NSString stringWithFormat:@"%@",self.tname];
    
    return str;
}

@end
