//
//  UIImage+SFExts.h
//  StarFish
//
//  Created by 李阳 on 2021/2/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (SFExts)

/** 图片压缩*/
- (NSData *)compressBySizeWithMaxLength:(NSUInteger)maxLength;
// 根据 aSize 返回一个新的image
- (UIImage *)drawImageBySize:(CGSize)aSize;

/** 颜色创建图片 */
+ (UIImage*)createImageWithColor:(UIColor*)color;
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

@end

NS_ASSUME_NONNULL_END
