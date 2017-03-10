//
//  HomeViewController.m
//  NetNews
//
//  Created by Lukj on 2017/3/10.
//  Copyright © 2017年 lukj. All rights reserved.
//

#import "HomeViewController.h"
#import <YYModel.h>
#import "ChannelModel.h"
@interface HomeViewController ()

//频道视图
@property (weak, nonatomic) IBOutlet UIScrollView *channelScrollView;
//新闻视图
@property (weak, nonatomic) IBOutlet UICollectionView *newsCollectionView;
//布局对象
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self requestChannelData];
}
//请求频道数据
- (void)requestChannelData{
    
    NSArray *modelArray = [ChannelModel getChannelModelArray];
    for (ChannelModel *m in modelArray) {
        NSLog(@"%@",m);
    }
    
    
}

@end
