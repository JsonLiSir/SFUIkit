//
//  SFDButton.h
//  SFUIKit
//
//  Created by zhouxr on 2021/11/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    SFDButtonImageLocationLeft,  ///图片在左侧
    SFDButtonImageLocationRight, ///图片在右侧
    SFDButtonImageLocationTop,   ///图片在上方
    SFDButtonImageLocationBottom ///图片在下方
} SFDButtonImageLocation;

@interface SFDButton : UIButton

/*
  图片相对按钮的位置
 */
@property (nonatomic) SFDButtonImageLocation sf_imageLocation;

/*
 图片和标题的间距
 */
@property (nonatomic) CGFloat sf_imageTitleSpace;

- (void)sf_setBackgroundColor:(UIColor *)color forState:(UIControlState)state;
- (UIColor *)sf_backgroundColorForState:(UIControlState)state;

@end

NS_ASSUME_NONNULL_END
