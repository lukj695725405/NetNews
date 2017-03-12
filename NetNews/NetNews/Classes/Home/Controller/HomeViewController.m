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
//标签的数据源
@property (nonatomic, strong) NSArray *channelModelArray;
//存储频道标签
@property (nonatomic, strong) NSMutableArray *channelLabelArray;

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
    //初始化频道数组
    self.channelLabelArray = [NSMutableArray array];
    //设置频道lable大小
    CGFloat labelH = 44;
    CGFloat labelW = 80;
    NSLog(@"%zd",self.channelModelArray.count);
    for (int i = 0; i < self.channelModelArray.count; i++) {
        //获取对应的模型数据
        ChannelModel *model = self.channelModelArray[i];
        //创建频道Label
        ChannelLabel *channelLabel = [[ChannelLabel alloc] initWithFrame:CGRectMake(i * labelW, 0, labelW, labelH)];
        channelLabel.text = model.tname;
        //设置文字大小和居中
        channelLabel.font = [UIFont systemFontOfSize:15];
        channelLabel.textAlignment = NSTextAlignmentCenter;
        //添加
        [self.channelScrollView addSubview:channelLabel];
        //设置channelLabel的tag作为标记
        channelLabel.tag = i;
        //开启channelLabel用户交互
        channelLabel.userInteractionEnabled = YES;
        //添加label点击手势
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
        //手势添加到channelLabel上
        [channelLabel addGestureRecognizer:tapGesture];
        //将channelLabel添加到频道数组中
        [self.channelLabelArray addObject:channelLabel];
        
        
    }
    //设置scrollView内容的大小
    self.channelScrollView.contentSize = CGSizeMake(labelW * self.channelModelArray.count, 0);
    //不显示垂直和水平方向的指示器
    self.channelScrollView.showsVerticalScrollIndicator = NO;
    self.channelScrollView.showsHorizontalScrollIndicator = NO;
}

#pragma mark - 点击channelLabel标签
- (void)tapGesture:(UIGestureRecognizer *)tapGesture{
    //获得 channelLabel tapGesture就是channelLabel
    ChannelLabel *channelLabel = (ChannelLabel *)tapGesture.view;
    //通过tag 创建NSIndexPath获取索引下标
    NSIndexPath *index = [NSIndexPath indexPathForItem:channelLabel.tag inSection:0];
    //通过索引下标滚动cell
    [self.newsCollectionView scrollToItemAtIndexPath:index atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    //调用频道偏移的封装
    [self contentOffXWithChannelLabel:channelLabel];

}

//频道偏移的封装
- (void)contentOffXWithChannelLabel:(ChannelLabel *)channelLabel{
    
    //计算标签的偏移量
    CGFloat contentOffX = channelLabel.center.x - self.view.frame.size.width * .5;
    //最小偏移量
    CGFloat contentOffMinX = 0;
    //最大偏移量
    CGFloat contentOffMaxX = self.channelScrollView.contentSize.width - self.view.frame.size.width;
    
    if (contentOffX < contentOffMinX) {
        contentOffX = contentOffMinX;
    }
    if (contentOffX > contentOffMaxX) {
        contentOffX = contentOffMaxX;
    }
    
    //偏移
    [self.channelScrollView setContentOffset:CGPointMake(contentOffX, 0) animated:YES];
    
}
#pragma mark - UICollectionViewDelegate
//collection 移动停止调用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    //通过scrollView的偏移 / 屏幕的宽 获得索引下标
    int index = scrollView.contentOffset.x / scrollView.frame.size.width;
    //根据下标 获取频道数组中的标签
    ChannelLabel *channelLabel = self.channelLabelArray[index];
    //调用频道偏移的封装
    [self contentOffXWithChannelLabel:channelLabel];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    int index = scrollView.contentOffset.x / scrollView.frame.size.width;
    CGFloat floatIndex = scrollView.contentOffset.x / scrollView.frame.size.width;
    CGFloat persents = floatIndex - index;
//    NSLog(@"%f",persents);
    
//    //左边的label百分比
    CGFloat leftPersents = 1 - persents;
//    //右边lable的百分比
    CGFloat rightPersents = persents;
    NSLog(@"左:%f,右:%f",leftPersents,rightPersents);
    //左边标签索引
    int leftLabel = index;
    //右边标签索引
    int rightLabel = 1 + index;
    
    ChannelLabel *leftChannelLabel = self.channelLabelArray[leftLabel];
    leftChannelLabel.scale = leftPersents;
    
    if (rightLabel < self.channelLabelArray.count) {
        ChannelLabel *rightChannelLabel = self.channelLabelArray[rightLabel];
        rightChannelLabel.scale = rightPersents;
    }

    
}

//设置新闻视图
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
