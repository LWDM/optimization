//
//  Model.h
//  DemoNormal
//
//  Created by 芦旺达 on 2020/4/30.
//  Copyright © 2020 com.xiaowangzi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Model : NSObject
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *pic;
@property(nonatomic,copy)NSString *from;
@property(nonatomic,copy)NSString *pvs;
@property(nonatomic,copy)NSArray *imglist;

@end

NS_ASSUME_NONNULL_END
