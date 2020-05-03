//
//  DemoCell2.h
//  DemoNormal
//
//  Created by 芦旺达 on 2020/5/1.
//  Copyright © 2020 com.xiaowangzi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Model,DemoCellLayout;


NS_ASSUME_NONNULL_BEGIN

@interface DemoCell2 : UITableViewCell
@property(nonatomic,strong)Model *model;
- (void)configureLayout:(DemoCellLayout *)layout;

@end

NS_ASSUME_NONNULL_END
