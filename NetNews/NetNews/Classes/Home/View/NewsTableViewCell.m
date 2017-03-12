//
//  NewsTableViewCell.m
//  NetNews
//
//  Created by Lukj on 2017/3/12.
//  Copyright © 2017年 lukj. All rights reserved.
//

#import "NewsTableViewCell.h"
#import <UIImageView+WebCache.h>
@interface NewsTableViewCell ()

//图片
@property (weak, nonatomic) IBOutlet UIImageView *imgsrcImg;
//标题
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
//来源
@property (weak, nonatomic) IBOutlet UILabel *sourceLabel;
//回复数
@property (weak, nonatomic) IBOutlet UILabel *replyCountLabel;

@end

@implementation NewsTableViewCell


- (void)setNewsModel:(NewsModel *)newsModel{
    
    _newsModel = newsModel;
    
    [self.imgsrcImg sd_setImageWithURL:[NSURL URLWithString:newsModel.imgsrc] placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
    
    self.titleLabel.text = newsModel.title;
    
    self.sourceLabel.text = newsModel.source;
    
    self.replyCountLabel.text = @(newsModel.replyCount).description;
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    //  保持图片原始比例显示
    self.imgsrcImg.contentMode = UIViewContentModeScaleAspectFill;
    //  设置设置了等比显示图片，那么需要剪切超出部分的图片
    self.imgsrcImg.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
