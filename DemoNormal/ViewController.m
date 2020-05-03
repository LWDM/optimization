//
//  ViewController.m
//  DemoNormal
//
//  Created by 芦旺达 on 2020/4/30.
//  Copyright © 2020 com.xiaowangzi. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking.h>
#import "Model.h"
#import "DemoCell.h"
#import "DemoCell2.h"
#import "DemoCellLayout.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *table;
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,strong)NSMutableArray<DemoCellLayout *> *layoutArr;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArr = [[NSMutableArray alloc]init];
    self.layoutArr = [[NSMutableArray alloc]init];
    [self createUI];
    [self loadData];
}

-(void)loadData{
    AFHTTPSessionManager *manager =[AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setValue:@"10" forKey:@"tpp"];
    [manager POST:@"https://api.0791look.com/api/ncwb/" parameters:dict progress:^(NSProgress * _Nonnull downloadProgress) {
    // 进度
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    // 请求成功
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSArray *arr = responseObject[@"data"];
            for (NSDictionary *dataDic in arr) {
                Model *model = [[Model alloc]init];
                model.from = dataDic[@"from"];
                model.pic = dataDic[@"pic"];
                model.pvs = dataDic[@"pvs"];
                model.title = dataDic[@"title"];
                model.imglist = dataDic[@"imglist"];
                [self.dataArr addObject:model];
            }
            [self.dataArr removeObjectAtIndex:1];//这个行代码忽略，去掉一个脏数据而已
            //预排版
            for (Model *dataModel in self.dataArr) {
                DemoCellLayout *cellLayout = [[DemoCellLayout alloc]initWithModel:dataModel];
                [self.layoutArr addObject:cellLayout];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.table reloadData];
            });
        });
            
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    // 请求失败
        NSLog(@"-----%@",error);
    }];
}

-(void)createUI{
    
    self.table = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.table.delegate = self;
    self.table.dataSource = self;
    self.table.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.table];
    [self.table registerClass:[DemoCell class] forCellReuseIdentifier:@"cell"];
    [self.table registerClass:[DemoCell2 class] forCellReuseIdentifier:@"cell2"];

    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.layoutArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.layoutArr[indexPath.row].height+10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.layoutArr[indexPath.row].dataModel.imglist.count <3) {
        DemoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        [cell configureLayout:self.layoutArr[indexPath.row]];
        return cell;
    }else{
        DemoCell2 *cell2 = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
        [cell2 configureLayout:self.layoutArr[indexPath.row]];
        return cell2;
    }
}






@end
