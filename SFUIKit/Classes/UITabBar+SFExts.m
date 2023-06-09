//
//  UITabBar+SFExts.m
//  StarFish
//
//  Created by 李阳 on 2021/2/4.
//

#import "UITabBar+SFExts.h"
#import "SFUIKit.h"

@implementation UITabBar (SFExts)

- (void)showBadgeOnItemIndex:(int)index badgeTitle:(NSString *)title {
    if(index>=2) index++;//因为中间有按钮
    //移除之前的小红点
    [self removeBadgeOnItemIndex:index];
    //新建小红点
    UIView *badgeView = [[UIView alloc]init];
    badgeView.tag = 888 + index;
    badgeView.backgroundColor = SF_RGB_COLOR(254, 80, 80);
    UILabel *numsLabel = [[UILabel alloc]init];
    numsLabel.textColor = [UIColor whiteColor];
    numsLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightRegular];
    numsLabel.text = title;
    [badgeView addSubview:numsLabel];
    CGSize titleSize = [title sizeWithAttributes:@{NSFontAttributeName:numsLabel.font}];
     CGFloat bgWidth = ceilf(titleSize.width) + 5 > 16 ? ceilf(titleSize.width) + 5 : 16;
    numsLabel.frame = CGRectMake((bgWidth - ceilf(titleSize.width))/2, 0, ceilf(titleSize.width), 16);
    CGRect tabFrame = self.frame;
    //确定小红点的位置
    float percentX = (index + 0.65) / 5;
    CGFloat x = ceilf(percentX * tabFrame.size.width) - 7;
    CGFloat y = 5;
    
    badgeView.frame = CGRectMake(x, y, bgWidth, 16);
//    badgeView.layer.cornerRadius = 8;
//    badgeView.layer.masksToBounds = YES;
//    badgeView.layer.borderWidth = 1;
//    badgeView.layer.borderColor = UIColor.whiteColor.CGColor;
    [self addSubview:badgeView];
    [badgeView clipRadius:8 bolderColor:UIColor.whiteColor bolderWidht:1];

    
}
//展示小红点 不展示数字
- (void)showBadgeOnItemIndex:(int)index {
    if(index >= 2) index++;//因为中间有按钮
    //移除之前的小红点
    [self removeBadgeOnItemIndex:index];
    
    //新建小红点
    UIView *badgeView = [[UIView alloc]init];
    badgeView.tag = 888 + index;
//    badgeView.layer.cornerRadius = 4;
//    badgeView.layer.masksToBounds = YES;
//    badgeView.layer.borderWidth = 1;
//    badgeView.layer.borderColor = UIColor.whiteColor.CGColor;
    badgeView.backgroundColor =  SF_RGB_COLOR(254, 80, 80);;
    CGRect tabFrame = self.frame;
    
    //确定小红点的位置
    float ratio = 0.56;
    if (index == 4) ratio = -0.05;
    float percentX = (index + ratio) / (self.items.count);
    CGFloat x = ceilf(percentX * tabFrame.size.width) - 30;
    CGFloat y = 10;
    badgeView.frame = CGRectMake(x, y, 8, 8);
    [self addSubview:badgeView];
    [badgeView clipRadius:4 bolderColor:UIColor.whiteColor bolderWidht:1];

}
- (void)hideBadgeOnItemIndex:(int)index {
    if(index>=2) index++; // 因为中间有按钮
    //移除小红点
    [self removeBadgeOnItemIndex:index];
}

- (void)removeBadgeOnItemIndex:(int)index {
    //按照tag值进行移除
    for (UIView *subView in self.subviews) {
        if (subView.tag == 888+index) [subView removeFromSuperview];
    }
}


@end
