//
//  FoldedTableViewCellModel.h
//  FoldedTableView
//
//  Created by ec on 2016/11/8.
//  Copyright © 2016年 Code Geass. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FoldedTableViewCellModel : NSObject

@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, assign, getter=isOnline) BOOL online;///< 是否在线

@end
