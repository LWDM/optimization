//
//  DemoCellLayout.h
//  DemoNormal
//
//  Created by 芦旺达 on 2020/5/1.
//  Copyright © 2020 com.xiaowangzi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class Model;
@interface DemoCellLayout : NSObject
@property(nonatomic,assign)CGRect titleRect;//标题位置
@property(nonatomic,strong)Model *dataModel;


@property(nonatomic,assign)CGRect titleRect2;//标题位置（下面是3张图片的标题位置）
@property(nonatomic,assign)CGRect imageRect;//标题右侧的图片
@property(nonatomic,assign)CGRect pvsLabelRect;//阅读量
@property(nonatomic,assign)CGRect fromLabelRect;//来源
@property(nonatomic,assign)CGFloat height;//cell的高度
@property(nonatomic,strong)NSMutableArray *imagesArr;

- (instancetype)initWithModel:(Model *)dataModel;

@end

NS_ASSUME_NONNULL_END
