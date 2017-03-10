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
#import "NewsCollectionViewCell.h"
@interface HomeViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

//频道视图
@property (weak, nonatomic) IBOutlet UIScrollView *channelScrollView;
//新闻视图
@property (weak, nonatomic) IBOutlet UICollectionView *newsCollectionView;
//布局对象
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) NSArray *channelModelArray;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self requestChannelData];
    [self setupNewsCollectionView];
    
     //  iOS7 提供的,如果有导航栏显示的滚动的视图(UITextView, UITableView, UICollectionView, UIScrollView)内容会自动往下偏移64, 设置no表示不让其偏移
    self.automaticallyAdjustsScrollViewInsets = NO;
    
}
//请求频道数据
- (void)requestChannelData{
    //获取频道的数据源
    self.channelModelArray = [ChannelModel getChannelModelArray];
  
    //设置频道lable大小
    CGFloat labelH = 44;
    CGFloat labelW = 80;
    
    for (int i = 0; i < self.channelModelArray.count; i++) {
        //获取对应的模型数据
        ChannelModel *model = self.channelModelArray[i];
        //创建频道Label
        ChannelLabel *channelLabel = [[ChannelLabel alloc] initWithFrame:CGRectMake(i * labelW, 0, labelW, labelH)];
        channelLabel.text = model.tname;
        //设置文字大小和居中
        channelLabel.font = [UIFont systemFontOfSize:15];
        channelLabel.textAlignment = NSTextAlignmentCenter;
        
        [self.channelScrollView addSubview:channelLabel];
    }
    //设置scrollView内容的大小
    self.channelScrollView.contentSize = CGSizeMake(labelW * self.channelModelArray.count, 0);
    //不显示垂直和水平方向的指示器
    self.channelScrollView.showsVerticalScrollIndicator = NO;
    self.channelScrollView.showsHorizontalScrollIndicator = NO;
}


- (void)setupNewsCollectionView{
    
    //设置数据源代理
    self.newsCollectionView.dataSource = self;
    //设置代理
    self.newsCollectionView.delegate = self;
    //设置每项item的大小
    self.flowLayout.itemSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height - 64 - 44);
    //垂直间距
    self.flowLayout.minimumLineSpacing = 0;
    //水平间距
    self.flowLayout.minimumInteritemSpacing = 0;
    //设置滚动方式
    self.flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //取消滚动条
    self.newsCollectionView.showsHorizontalScrollIndicator = NO;
    self.newsCollectionView.showsVerticalScrollIndicator = NO;
    //设置分页
    self.newsCollectionView.pagingEnabled = YES;
    //取消弹簧效果
    self.newsCollectionView.bounces = NO;
    
    //  ios 10 提供了一个预加载, 预加载提供collectionview的性能,提起给会把下一个显示的cell给你准备好.
//        self.newsCollectionView.prefetchingEnabled = YES;
    
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    
    return self.channelModelArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NewsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"newsCell" forIndexPath:indexPath];
    
    ChannelModel *model = self.channelModelArray[indexPath.item];
    
    cell.urlStr = [NSString stringWithFormat:@"%@/0-20.html",model.tid];

    return cell;
    
}

@end
