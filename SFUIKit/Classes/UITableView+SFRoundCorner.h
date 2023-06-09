//
//  UITableView+SFRoundCorner.h
//  SFUIKit
//
//  Created by zhouxr on 2021/12/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (SFRoundCorner)

@property (nonatomic, assign) double sf_cornerRadius;
@property (nonatomic, assign) double sf_leftMargin;


- (void)sf_base_tableView:(UITableView *)tableView
          willDisplayCell:(UITableViewCell *)cell
        forRowAtIndexPath:(NSIndexPath *)indexPath;


- (void)sf_base_tableView:(UITableView *)tableView
          willDisplayCell:(UITableViewCell *)cell
        forRowAtIndexPath:(NSIndexPath *)indexPath
              cellBgColor:(UIColor *)cellBgColor;

@end

NS_ASSUME_NONNULL_END
