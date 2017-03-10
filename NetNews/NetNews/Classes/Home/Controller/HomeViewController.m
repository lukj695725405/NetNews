//
//  HomeViewController.m
//  NetNews
//
//  Created by Lukj on 2017/3/10.
//  Copyright © 2017年 lukj. All rights reserved.
//

#import "HomeViewController.h"
#import "ChannelLabel.h"
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
     //  iOS7 提供的,如果有导航栏显示的滚动的视图(UITextView, UITableView, UICollectionView, UIScrollView)内容会自动往下偏移64, 设置no表示不让其偏移
    self.automaticallyAdjustsScrollViewInsets = NO;
    
}
//请求频道数据
- (void)requestChannelData{
    //获取频道的数据源
    NSArray *modelArray = [ChannelModel getChannelModelArray];
  
    //设置频道lable大小
    CGFloat labelH = 44;
    CGFloat labelW = 80;
    
    for (int i = 0; i < modelArray.count; i++) {
        //获取对应的模型数据
        ChannelModel *model = modelArray[i];
        //创建频道Label
        ChannelLabel *channelLabel = [[ChannelLabel alloc] initWithFrame:CGRectMake(i * labelW, 0, labelW, labelH)];
        channelLabel.text = model.tname;
        //设置文字大小和居中
        channelLabel.font = [UIFont systemFontOfSize:15];
        channelLabel.textAlignment = NSTextAlignmentCenter;
        
        [self.channelScrollView addSubview:channelLabel];
    }
    //设置scrollView内容的大小
    self.channelScrollView.contentSize = CGSizeMake(labelW * modelArray.count, 0);
    //不显示垂直和水平方向的指示器
    self.channelScrollView.showsVerticalScrollIndicator = NO;
    self.channelScrollView.showsHorizontalScrollIndicator = NO;
    
}

@end
