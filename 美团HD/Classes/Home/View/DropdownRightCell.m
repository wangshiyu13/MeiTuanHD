//
//  DropdownRightCell.m
//  美团HD
//
//  Created by wangshiyu13 on 15/2/17.
//  Copyright (c) 2015年 wangshiyu13. All rights reserved.
//

#import "DropdownRightCell.h"

@implementation DropdownRightCell
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *rightID = @"right";
    DropdownRightCell *cell = [tableView dequeueReusableCellWithIdentifier:rightID];
    if (cell == nil) {
        cell = [[DropdownRightCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:rightID];
        cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_dropdown_rightpart"]];
        cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_dropdown_right_selected"]];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
    }
    return cell;
}
@end
