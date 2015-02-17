//
//  HomeTopItem.m
//  美团HD
//
//  Created by wangshiyu13 on 15/2/16.
//  Copyright (c) 2015年 wangshiyu13. All rights reserved.
//

#import "HomeTopItem.h"

@interface HomeTopItem()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;
@property (weak, nonatomic) IBOutlet UIButton *iconButton;
@end
@implementation HomeTopItem
+ (instancetype)item {
    return [[[NSBundle mainBundle] loadNibNamed:@"HomeTopItem" owner:nil options:nil] firstObject];
}

- (void)awakeFromNib {
    self.autoresizingMask = UIViewAutoresizingNone;
}

- (void)addTarget:(id)target action:(SEL)action {
    [self.iconButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}

- (void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
}
- (void)setSubtitle:(NSString *)subtitle {
    self.subtitleLabel.text = subtitle;
}
- (void)setIcon:(NSString *)icon highIcon:(NSString *)highIcon {
    [self.iconButton setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [self.iconButton setImage:[UIImage imageNamed:highIcon] forState:UIControlStateHighlighted];
}

@end
