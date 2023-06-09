//
//  UIImage+SFExts.m
//  StarFish
//
//  Created by 李阳 on 2021/2/4.
//

#import "UIImage+SFExts.h"

@implementation UIImage (SFExts)

/** 图片压缩*/
- (NSData *)compressBySizeWithMaxLength:(NSUInteger)maxLength {
    
    // Compress by quality
      CGFloat compression = 1;
      NSData *data = UIImageJPEGRepresentation(self, compression);
      //NSLog(@"Before compressing quality, image size = %ld KB",data.length/1024);
      if (data.length < maxLength) return data;
      
      CGFloat max = 1;
      CGFloat min = 0;
      for (int i = 0; i < 6; ++i) {
          compression = (max + min) / 2;
          data = UIImageJPEGRepresentation(self, compression);
          //NSLog(@"Compression = %.1f", compression);
          //NSLog(@"In compressing quality loop, image size = %ld KB", data.length / 1024);
          if (data.length < maxLength * 0.9) {
              min = compression;
          } else if (data.length > maxLength) {
              max = compression;
          } else {
              break;
          }
      }
      //NSLog(@"After compressing quality, image size = %ld KB", data.length / 1024);
      if (data.length < maxLength) return data;
      UIImage *resultImage = [UIImage imageWithData:data];
      // Compress by size
      NSUInteger lastDataLength = 0;
      while (data.length > maxLength && data.length != lastDataLength) {
          lastDataLength = data.length;
          CGFloat ratio = (CGFloat)maxLength / data.length;
          //NSLog(@"Ratio = %.1f", ratio);
          CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)),
                                   (NSUInteger)(resultImage.size.height * sqrtf(ratio))); // Use NSUInteger to prevent white blank
          UIGraphicsBeginImageContext(size);
          [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
          resultImage = UIGraphicsGetImageFromCurrentImageContext();
          UIGraphicsEndImageContext();
          data = UIImageJPEGRepresentation(resultImage, compression);
          //NSLog(@"In compressing size loop, image size = %ld KB", data.length / 1024);
      }
      //NSLog(@"After compressing size loop, image size = %ld KB", data.length / 1024);
      return data;
}

// 根据 aSize 返回一个新的image
- (UIImage *)drawImageBySize:(CGSize)aSize{
    UIGraphicsBeginImageContext(aSize);
    [self drawInRect:CGRectMake(0, 0, aSize.width, aSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

/** color->image*/
+ (UIImage*)createImageWithColor:(UIColor*)color {
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
#pragma mark - public methods
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    if (!color || size.width <= 0 || size.height <= 0) return nil;
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
