//
//  NewsTableViewController.m
//  NetNews
//
//  Created by Lukj on 2017/3/10.
//  Copyright © 2017年 lukj. All rights reserved.
//

#import "NewsTableViewController.h"
#import "NewsModel.h"
#import "NewsTableViewCell.h"
//新闻列表tableView
@interface NewsTableViewController ()
//新闻列表数据源
@property (nonatomic, strong) NSArray *newsModelArray;

@end

@implementation NewsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupTableView];
    
}

- (void)setupTableView{
    
    [self.tableView registerNib:[UINib nibWithNibName:@"BaseCell" bundle:nil] forCellReuseIdentifier:@"baseCell"];
}

- (void)setUrlStr:(NSString *)urlStr{
    
    _urlStr = urlStr;
    
    //根据网络请求的地址加载网络数据
//    NSLog(@"url:%@",urlStr);
    
//    [[NetworkTools sharedTools] requestWithType:GET andUrlStr:urlStr andParams:nil andSuccessBlock:^(id responseObject) {
//        NSLog(@"%@",[responseObject class]);
//        
//        NSDictionary *dic = (NSDictionary *)responseObject;
//        //因为这个字典里面只有一个key 获取这个字典里的key
//        NSString *key = dic.allKeys.firstObject;
//        //通过key获取新闻的数组字典
//        NSArray *dicArry = [dic objectForKey:key];
//        
//        NSLog(@"%@",dicArry);
//        
//    } andFailureBlock:^(id error) {
//        
//        NSLog(@"%@",error);
//        
//    }];
    
    [NewsModel requestNewsModelArrayWithUrlStr:urlStr andCompletionBlock:^(NSArray *modelArray) {
        
//        NSLog(@"%@",modelArray);
        self.newsModelArray = modelArray;

        [self.tableView reloadData];
        
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.newsModelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"baseCell" forIndexPath:indexPath];
    
    NewsModel *model = self.newsModelArray[indexPath.row];
    //显示新闻的标题
    cell.newsModel = model;
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    NewsModel *model = self.newsModelArray[indexPath.row];
//    if (model.imgType) {
//        return 130;
//    } else if (model.imgextra.count == 2) {
//        return 180;
//    } else {
//        return 80;
//    }
    return 80;
    
}

@end
