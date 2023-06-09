//
//  UITableView+SFRoundCorner.m
//  SFUIKit
//
//  Created by zhouxr on 2021/12/29.
//

#import "UITableView+SFRoundCorner.h"
#import <objc/runtime.h>
#import "SFUIKit.h"

@implementation UITableView (SFRoundCorner)

- (void)sf_base_tableView:(UITableView *)tableView
          willDisplayCell:(UITableViewCell *)cell
   forRowAtIndexPath:(NSIndexPath *)indexPath  {
    [self sf_base_tableView:tableView willDisplayCell:cell forRowAtIndexPath:indexPath cellBgColor:[UIColor whiteColor]];
}

- (void)sf_base_tableView:(UITableView *)tableView
          willDisplayCell:(UITableViewCell *)cell
        forRowAtIndexPath:(NSIndexPath *)indexPath
              cellBgColor:(UIColor *)cellBgColor  {
    
    if ([cell respondsToSelector:@selector(tintColor)]) {
        if (tableView == self) {
            CGFloat cornerRadius = self.sf_cornerRadius;
            cell.backgroundColor = UIColor.clearColor;
            CAShapeLayer *layer = [[CAShapeLayer alloc] init];
            CGMutablePathRef pathRef = CGPathCreateMutable();
            CGRect bounds = CGRectInset(CGRectMake(self.sf_leftMargin, 0, SCREEN_WIDTH -  2 * self.sf_leftMargin, cell.contentView.height), 0, 0);
            if (indexPath.row == 0 && indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {
                CGPathAddRoundedRect(pathRef, nil, bounds, cornerRadius, cornerRadius);
            } else if (indexPath.row == 0) {
                CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds));
                CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds), CGRectGetMidX(bounds), CGRectGetMinY(bounds), cornerRadius);
                CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
                CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds));
            } else if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {
                CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds));
                CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds), CGRectGetMidX(bounds), CGRectGetMaxY(bounds), cornerRadius);
                CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
                CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds));
            } else {
                CGPathAddRect(pathRef, nil, bounds);
            }
            layer.path = pathRef;
            CFRelease(pathRef);
            layer.fillColor = cellBgColor.CGColor;
            
            UIView *roundView = [[UIView alloc] initWithFrame:bounds];
            [roundView.layer insertSublayer:layer atIndex:0];
            roundView.backgroundColor = UIColor.clearColor;
            cell.backgroundView = roundView;
            
        }
    }
    
}

#pragma mark -
- (void)setSf_cornerRadius:(double)sf_cornerRadius {
    objc_setAssociatedObject(self,
                             @selector(sf_cornerRadius),
                             [NSNumber numberWithDouble:sf_cornerRadius],
                             OBJC_ASSOCIATION_RETAIN);
}

- (double)sf_cornerRadius {
    return [objc_getAssociatedObject(self,
                                     @selector(sf_cornerRadius)) doubleValue];
}


- (void)setSf_leftMargin:(double)sf_leftMargin {
    objc_setAssociatedObject(self,
                             @selector(sf_leftMargin),
                             [NSNumber numberWithDouble:sf_leftMargin],
                             OBJC_ASSOCIATION_RETAIN);
}

- (double)sf_leftMargin {
    return [objc_getAssociatedObject(self,
                                     @selector(sf_leftMargin)) doubleValue];
}


@end
