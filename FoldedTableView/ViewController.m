//
//  ViewController.m
//  FoldedTableView
//
//  Created by ec on 2016/11/8.
//  Copyright © 2016年 Code Geass. All rights reserved.
//

#import "ViewController.h"
#import "FoldedTableViewCell.h"
#import "FoldedTableViewCellModel.h"
#import "FoldedTableViewHeaderFooterView.h"
#import "FoldedTableViewHeaderFooterViewModel.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *sectionData;
@end

@implementation ViewController

- (NSMutableArray *)sectionData{
    if (!_sectionData) {
        _sectionData = [[NSMutableArray alloc] init];
        
        NSArray *sectionArray = @[@"特别关心",@"常用群聊",@"家人",@"亲人",@"朋友",@"工作",@"大学同学",@"高中同学",@"米线",@"初中同学",@"手机通讯录",@"我的设备"];
        
        NSArray *imageNameArray = @[@"魏一",@"蜀二",@"张三",@"李四",@"王五",@"赵六",@"刘七",@"秦八",@"梁九",@"夏十"];
        
        NSArray *onlineContentArray = @[@"[4G在线]haha",@"[4G在线]哈哈",
                                        @"[WiFi在线]😝",@"[WiFi在线]hehe",
                                        @"[iPhone在线]呵呵",@"[iPhone在线]😑",
                                        @"[2G在线]I love you",@"[2G在线]我爱你",
                                        @"[3G在线]What fine weather it is!",@"[3G在线]今天天气真好",
                                        @"[手机在线]Do you like me ?",@"[手机在线]你喜欢我吗？",
                                        @"[4G在线]MacBook Pro",@"[手机在线]iPhone",@"[iPhone在线]iPad",@"[WiFi在线]Apple Watch"];
        
        NSArray *offlineContentArray = @[@"[离线请留言]haha",@"[离线请留言]哈哈",@"[离线请留言]😝",
                                         @"[离线请留言]hehe",@"[离线请留言]呵呵",@"[离线请留言]😑",
                                         @"[离线请留言]I love you",@"[离线请留言]我爱你",
                                         @"[离线请留言]What fine weather it is!",@"[离线请留言]今天天气真好",
                                         @"[离线请留言]Do you like me ?",@"[离线请留言]你喜欢我吗？",
                                         @"[离线请留言]MacBook Pro",@"[离线请留言]iPhone",@"[离线请留言]iPad",@"[离线请留言]Apple Watch"];
        
        for (int i = 0; i < sectionArray.count; i++) {
            FoldedTableViewHeaderFooterViewModel *viewModel = [[FoldedTableViewHeaderFooterViewModel alloc] init];
            viewModel.title = sectionArray[i];
            
            // 在线数据
            NSInteger onlineNumber = arc4random()%50;
            NSMutableArray *array = [[NSMutableArray alloc] init];
            for (int j = 0; j < onlineNumber; j++) {
                FoldedTableViewCellModel *cellModel = [[FoldedTableViewCellModel alloc] init];
                cellModel.imageName = imageNameArray[arc4random_uniform((u_int32_t)imageNameArray.count)];
                cellModel.title = cellModel.imageName;
                cellModel.content = onlineContentArray[arc4random_uniform((u_int32_t)onlineContentArray.count)];
                cellModel.online = YES;
                [array addObject:cellModel];
            }
            
            // 离线数据
            NSInteger offlineNumber = arc4random()%50;
            for (int j = 0; j < offlineNumber; j++) {
                FoldedTableViewCellModel *cellModel = [[FoldedTableViewCellModel alloc] init];
                cellModel.imageName = imageNameArray[arc4random_uniform((u_int32_t)imageNameArray.count)];
                cellModel.title = cellModel.imageName;
                cellModel.content = offlineContentArray[arc4random_uniform((u_int32_t)offlineContentArray.count)];
                cellModel.online = NO;
                [array addObject:cellModel];
            }
            viewModel.cellModelArray = array;
            
            viewModel.number = [NSString stringWithFormat:@"%lu/%lu",onlineNumber,array.count];
            [_sectionData addObject:viewModel];
        }
    }
    return _sectionData;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 60;
    _tableView.sectionHeaderHeight = 50;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.tableFooterView = [UIView new];
    [_tableView registerNib:[UINib nibWithNibName:@"FoldedTableViewCell" bundle:nil] forCellReuseIdentifier:@"FoldedTableViewCell"];
    [_tableView registerClass:[FoldedTableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"FoldedTableViewHeaderFooterView"];
    [self.view addSubview:_tableView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    FoldedTableViewHeaderFooterViewModel *model = self.sectionData[section];
    return model.isExpanded ? model.cellModelArray.count : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FoldedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FoldedTableViewCell" forIndexPath:indexPath];
    FoldedTableViewHeaderFooterViewModel *viewModel = self.sectionData[indexPath.section];
    FoldedTableViewCellModel *cellModel = viewModel.cellModelArray[indexPath.row];
    [cell setupWithModel:cellModel];
    if (indexPath.row == viewModel.cellModelArray.count - 1) {
        cell.bottomLineView.hidden = YES;
    }else {
        cell.bottomLineView.hidden = NO;
    }
    return cell;
}

#pragma mark - UITableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    FoldedTableViewHeaderFooterView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"FoldedTableViewHeaderFooterView"];
    FoldedTableViewHeaderFooterViewModel *model = self.sectionData[section];
    [view setupWithModel:model section:section didSelectBlock:^{
//        [tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationFade];
        [tableView reloadData];
    }];
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    FoldedTableViewHeaderFooterViewModel *model = self.sectionData[section];
    if ([model.title isEqualToString:@"常用群聊"] || [model.title isEqualToString:@"初中同学"]) {
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.2];
        return view;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    FoldedTableViewHeaderFooterViewModel *model = self.sectionData[section];
    if ([model.title isEqualToString:@"常用群聊"] || [model.title isEqualToString:@"初中同学"]) {
        return 20;
    }
    return CGFLOAT_MIN;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
