//
//  DropdownLeftCell.m
//  美团HD
//
//  Created by wangshiyu13 on 15/2/17.
//  Copyright (c) 2015年 wangshiyu13. All rights reserved.
//

#import "DropdownLeftCell.h"

@implementation DropdownLeftCell
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *leftID = @"left";
    DropdownLeftCell *cell = [tableView dequeueReusableCellWithIdentifier:leftID];
    if (cell == nil) {
        cell = [[DropdownLeftCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:leftID];
        cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_dropdown_leftpart"]];
        cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_dropdown_left_selected"]];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
    }
    return cell;
}
@end
