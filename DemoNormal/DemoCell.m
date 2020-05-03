//
//  DemoCell.m
//  DemoNormal
//
//  Created by 芦旺达 on 2020/4/30.
//  Copyright © 2020 com.xiaowangzi. All rights reserved.
//

#import "DemoCell.h"
#import <Masonry.h>
#import <UIImageView+WebCache.h>
#import "Model.h"
#import "DemoCellLayout.h"
#import "UIImage+cornerRadious.h"

@interface DemoCell()

@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *fromLabel;//来源
@property(nonatomic,strong)UILabel *pvsLabel;//阅读量
@property(nonatomic,strong)UIImageView *image;//Cell里面只有一个图片的时候
@property(nonatomic,strong)UIView *imageViews;//Cell里面有多个图片
@property(nonatomic,strong)DemoCellLayout *layout;

@end

@implementation DemoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

- (void)configureLayout:(DemoCellLayout *)layout{
    _layout = layout;
    self.titleLabel.frame = layout.titleRect;
    self.titleLabel.text = layout.dataModel.title;
    
    self.image.frame = layout.imageRect;
    [self.image sd_setImageWithURL:[NSURL URLWithString:layout.dataModel.pic] placeholderImage:nil options:SDWebImageAvoidAutoSetImage completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        [self.image setImage:[image cornerRadius:5 size:self.image.bounds.size]];
    }];
    
    self.fromLabel.frame = layout.fromLabelRect;
    self.fromLabel.text = layout.dataModel.from;
    
    self.pvsLabel.frame = layout.pvsLabelRect;
    self.pvsLabel.text = layout.dataModel.pvs;
}

-(void)createUI{
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.font = [UIFont systemFontOfSize:16];
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.numberOfLines = 0;
    [self.contentView addSubview:self.titleLabel];
    
    self.image = [[UIImageView alloc]init];
    [self.contentView addSubview:self.image];
    
    self.fromLabel = [[UILabel alloc]init];
    self.fromLabel.font = [UIFont systemFontOfSize:14];
    self.fromLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:self.fromLabel];
    
    self.pvsLabel = [[UILabel alloc]init];
    self.pvsLabel.font = [UIFont systemFontOfSize:14];
    self.pvsLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:self.pvsLabel];
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
