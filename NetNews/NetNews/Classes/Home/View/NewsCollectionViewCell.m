//
//  NewsCollectionViewCell.m
//  NetNews
//
//  Created by Lukj on 2017/3/10.
//  Copyright © 2017年 lukj. All rights reserved.
//

#import "NewsCollectionViewCell.h"
#import "NewsTableViewController.h"
@implementation NewsCollectionViewCell{
    
    NewsTableViewController *_newsTableVC;
}

- (void)awakeFromNib{
    
    [super awakeFromNib];
    //创建新闻列表控制器
    _newsTableVC = [[NewsTableViewController alloc] init];
    //设置tableView的大小
    _newsTableVC.tableView.frame = self.contentView.bounds;
    //设置tableView的随机颜色
    _newsTableVC.tableView.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256) / 255.0 green:arc4random_uniform(256) / 255.0 blue:arc4random_uniform(256) / 255.0 alpha:1];

    [self.contentView addSubview:_newsTableVC.tableView];
}

- (void)setUrlStr:(NSString *)urlStr{
    
    _urlStr = urlStr;
    
    //获取请求地址
    _newsTableVC.urlStr = urlStr;
    
}


@end
