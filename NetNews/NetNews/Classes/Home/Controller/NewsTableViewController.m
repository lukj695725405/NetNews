//
//  NewsTableViewController.m
//  NetNews
//
//  Created by Lukj on 2017/3/10.
//  Copyright © 2017年 lukj. All rights reserved.
//

#import "NewsTableViewController.h"
@interface NewsTableViewController ()

@end

@implementation NewsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    
}

- (void)setUrlStr:(NSString *)urlStr{
    
    _urlStr = urlStr;
    
    //根据网络请求的地址加载网络数据
    NSLog(@"url:%@",urlStr);
}


@end
