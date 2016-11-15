//
//  FoldedTableViewHeaderFooterViewModel.h
//  FoldedTableView
//
//  Created by ec on 2016/11/8.
//  Copyright © 2016年 Code Geass. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FoldedTableViewCellModel;

@interface FoldedTableViewHeaderFooterViewModel : NSObject

@property (nonatomic, assign, getter=isExpanded) BOOL expanded;///< 是否展开
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *number;
@property (nonatomic, strong) NSArray<FoldedTableViewCellModel *> *cellModelArray;

@end
