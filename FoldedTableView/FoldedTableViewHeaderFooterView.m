//
//  FoldedTableViewHeaderFooterView.m
//  FoldedTableView
//
//  Created by ec on 2016/11/8.
//  Copyright © 2016年 Code Geass. All rights reserved.
//

#import "FoldedTableViewHeaderFooterView.h"
#import "FoldedTableViewHeaderFooterViewModel.h"

static CGFloat const kHeight = 50;
static CGFloat const kMargin = 15;
static CGFloat const kArrowImageViewWidth = 12;

@interface FoldedTableViewHeaderFooterView ()
@property (nonatomic, strong) FoldedTableViewHeaderFooterViewModel *model;
@property (nonatomic, copy) DidSelectBlock block;
@end

@implementation FoldedTableViewHeaderFooterView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        
        // 三角图标
        _arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kMargin, (kHeight - kArrowImageViewWidth)/2 , kArrowImageViewWidth, kArrowImageViewWidth)];
        _arrowImageView.image = [UIImage imageNamed:@"arrow_right"];
        [self.contentView addSubview:_arrowImageView];
        
        // 标题
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_arrowImageView.frame) + kMargin, 0, width - (kMargin + kArrowImageViewWidth + kMargin) - (kMargin + 40 + kMargin), kHeight)];
        _titleLabel.font = [UIFont systemFontOfSize:18];
        [self.contentView addSubview:_titleLabel];
        
        // 人数
        _numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_titleLabel.frame) + kMargin, 0, 40, kHeight)];
        _numberLabel.font = [UIFont systemFontOfSize:12];
        _numberLabel.textColor = [UIColor lightGrayColor];
        _numberLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_numberLabel];
        
        
        _topLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 0.5)];
        _topLineView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self.contentView addSubview:_topLineView];
        
        
        _bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, kHeight - 0.5, width, 0.5)];
        _bottomLineView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self.contentView addSubview:_bottomLineView];
        
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        [self.contentView addGestureRecognizer:tap];
    }
    return self;
}

- (void)tap {
    _model.expanded = ! _model.isExpanded;

    if (_block) {
        _block(_model.isExpanded);
    }
}

- (void)setupWithModel:(FoldedTableViewHeaderFooterViewModel *)model
               section:(NSInteger)section
        didSelectBlock:(DidSelectBlock)block
{
    _model = model;
    _block = block;
    
    _titleLabel.text = model.title;
    _numberLabel.text = model.number;
    
    if (!model.isExpanded) {
        _arrowImageView.transform = CGAffineTransformIdentity;
        _bottomLineView.hidden = NO;
    }else{
        _arrowImageView.transform = CGAffineTransformMakeRotation(M_PI_2);
        _bottomLineView.hidden = YES;
    }
    
    if (section == 0) {
        _topLineView.hidden = NO;
    }else {
        _topLineView.hidden = YES;
    }
}

@end
