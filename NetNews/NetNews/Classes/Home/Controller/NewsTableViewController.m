//
//  NewsTableViewController.m
//  NetNews
//
//  Created by Lukj on 2017/3/10.
//  Copyright © 2017年 lukj. All rights reserved.
//

#import "NewsTableViewController.h"
#import "NewsModel.h"

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
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"newsCell"];
    
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
        
        NSLog(@"%@",modelArray);
        self.newsModelArray = modelArray;
        
        [self.tableView reloadData];
        
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.newsModelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"newsCell" forIndexPath:indexPath];
    
    NewsModel *model = self.newsModelArray[indexPath.row];
    //显示新闻的标题
    cell.textLabel.text = model.title;
    
    return cell;
}

@end
