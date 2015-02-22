//
//  DealCell.m
//  美团HD
//
//  Created by wangshiyu13 on 15/2/20.
//  Copyright (c) 2015年 wangshiyu13. All rights reserved.
//

#import "DealCell.h"
#import "Deal.h"
#import <UIImageView+WebCache.h>
@interface DealCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *listPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *purchaseCountLabel;
@property (weak, nonatomic) IBOutlet UIImageView *dealNewMark;
@property (weak, nonatomic) IBOutlet UIButton *cover;
@property (weak, nonatomic) IBOutlet UIImageView *checkmark;

@end
@implementation DealCell

- (void)setDeal:(Deal *)deal {
    _deal = deal;
    // 图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:deal.image_url] placeholderImage:[UIImage imageNamed:@"placeholder_deal"]];
    // 标题
    self.titleLabel.text = deal.title;
    // 描述
    self.descLabel.text = deal.desc;
    // 原价
    self.listPriceLabel.text = [NSString stringWithFormat:@"¥%@", deal.list_price];
    // 现价
    self.currentPriceLabel.text = [NSString stringWithFormat:@"¥%@", deal.current_price];
    // 购买数
    self.purchaseCountLabel.text = [NSString stringWithFormat:@"已售%d", deal.purchase_count];
    // 新单
    self.dealNewMark.hidden = ([deal.publish_date compare:[NSDate date]] == NSOrderedAscending);
    // 根据模型的editing属性来判断是否进入编辑模式
    self.cover.hidden = !deal.editing;
    // 根据模型的checked属性来确定是否要显示checkmark
    self.checkmark.hidden = !self.deal.isChecked;
}

- (IBAction)coverClick {
    // 永久修改模型状态
    self.deal.checked = !self.deal.isChecked;
    // 重新调用set方法
    self.deal = self.deal;
    // 发出点击通知
    [WSYNoteCenter postNotificationName:CellCoverDidClickNotification object:nil];
}

- (void)awakeFromNib {
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_dealcell"]];
}

@end
