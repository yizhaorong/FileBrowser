//
//  FBFileCell.m
//  FileBrowser
//
//  Created by 昭荣伊 on 2020/10/4.
//

#import "FBFileCell.h"
#import "FBFile.h"
#import <Masonry/Masonry.h>

@interface FBFileCell ()

@property (nonatomic, strong) FBFile *file;

@property (nonatomic, strong) UIImageView *iconView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *detailLabel;

@end

@implementation FBFileCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
        [self setupConstraints];
    }
    return self;
}

- (void)setupViews {
    [self.contentView addSubview:self.iconView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.detailLabel];
}

- (void)setupConstraints {
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(64);
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(0);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(self.iconView.mas_bottom).offset(4);
    }];
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(4);
        make.centerX.mas_equalTo(0);
    }];
}

- (void)setFile:(FBFile *)file {
    _file = file;
    self.iconView.image = file.icon;
    self.titleLabel.text = file.name;
    self.detailLabel.text = file.detail;
}

#pragma mark - Setters And Getters
- (UIImageView *)iconView {
    if (!_iconView) {
        _iconView = [UIImageView new];
    }
    return _iconView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont systemFontOfSize:12];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.numberOfLines = 2;
        _titleLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
    }
    return _titleLabel;
}

- (UILabel *)detailLabel {
    if (!_detailLabel) {
        _detailLabel = [UILabel new];
        _detailLabel.font = [UIFont systemFontOfSize:10];
        _detailLabel.textAlignment = NSTextAlignmentCenter;
        _detailLabel.textColor = [UIColor lightGrayColor];
        _detailLabel.numberOfLines = 1;
        _detailLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
        _detailLabel.text = @"10项";
    }
    return _detailLabel;
}

@end
