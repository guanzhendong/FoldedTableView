//
//  FoldedTableViewCell.h
//  FoldedTableView
//
//  Created by ec on 2016/11/8.
//  Copyright © 2016年 Code Geass. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FoldedTableViewCellModel;

@interface FoldedTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIView *bottomLineView;
@property (nonatomic, strong) CALayer *imageViewMaskLayer;///< 离线头像蒙版

- (void)setupWithModel:(FoldedTableViewCellModel *)model;

@end
