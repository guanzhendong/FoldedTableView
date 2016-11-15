//
//  FoldedTableViewCell.m
//  FoldedTableView
//
//  Created by ec on 2016/11/8.
//  Copyright © 2016年 Code Geass. All rights reserved.
//

#import "FoldedTableViewCell.h"
#import "FoldedTableViewCellModel.h"
#import "UIImageView+Letters.h"

@implementation FoldedTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _imageViewMaskLayer = [CALayer layer];
    _imageViewMaskLayer.frame = CGRectMake(0, 0, 40, 40);
    _imageViewMaskLayer.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.7].CGColor;
    _imageViewMaskLayer.masksToBounds = YES;
    _imageViewMaskLayer.cornerRadius = 20;
    _imageViewMaskLayer.hidden = YES;
    [_leftImageView.layer addSublayer:_imageViewMaskLayer];
}

- (void)setupWithModel:(FoldedTableViewCellModel *)model {
    [_leftImageView setImageWithString:model.imageName color:nil circular:YES];
    _titleLabel.text = model.title;
    _contentLabel.text = model.content;
    if (model.isOnline) {
        _imageViewMaskLayer.hidden = YES;
    }else {
        _imageViewMaskLayer.hidden = NO;
    }
}

@end
