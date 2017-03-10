//
//  ChannelModel.h
//  NetNews
//
//  Created by Lukj on 2017/3/10.
//  Copyright © 2017年 lukj. All rights reserved.
//

#import <Foundation/Foundation.h>
//频道模型
@interface ChannelModel : NSObject

//  频道id
@property (nonatomic, copy) NSString *tid;
//  频道名称
@property (nonatomic, copy) NSString *tname;
//获取频道里的模型数据
+ (NSArray *)getChannelModelArray;

@end
