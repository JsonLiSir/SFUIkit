//
//  UIColor+SFExts.m
//  StarFish
//
//  Created by 李阳 on 2021/3/12.
//

#import "UIColor+SFExts.h"

@implementation UIColor (SFExts)

+(UIColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha {
    NSString *colorString = [[hexString stringByReplacingOccurrencesOfString: @"#" withString: @""] uppercaseString];
      CGFloat red, blue, green;
      switch ([colorString length]) {
          case 3: // #RGB
              red   = [self colorComponentFrom: colorString start: 0 length: 1];
              green = [self colorComponentFrom: colorString start: 1 length: 1];
              blue  = [self colorComponentFrom: colorString start: 2 length: 1];
              break;
          case 4: // #ARGB
              alpha = [self colorComponentFrom: colorString start: 0 length: 1];
              red   = [self colorComponentFrom: colorString start: 1 length: 1];
              green = [self colorComponentFrom: colorString start: 2 length: 1];
              blue  = [self colorComponentFrom: colorString start: 3 length: 1];
              break;
          case 6: // #RRGGBB
              red   = [self colorComponentFrom: colorString start: 0 length: 2];
              green = [self colorComponentFrom: colorString start: 2 length: 2];
              blue  = [self colorComponentFrom: colorString start: 4 length: 2];
              break;
          case 8: // #AARRGGBB
              alpha = [self colorComponentFrom: colorString start: 0 length: 2];
              red   = [self colorComponentFrom: colorString start: 2 length: 2];
              green = [self colorComponentFrom: colorString start: 4 length: 2];
              blue  = [self colorComponentFrom: colorString start: 6 length: 2];
              break;
          default:
              blue=0;
              green=0;
              red=0;
              break;
      }
      return [UIColor colorWithRed: red green: green blue: blue alpha: alpha];
}

+(CGFloat) colorComponentFrom: (NSString *) string start: (NSUInteger) start length: (NSUInteger) length
{
    NSString *substring = [string substringWithRange: NSMakeRange(start, length)];
    NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat: @"%@%@", substring, substring];
    unsigned hexComponent;
    [[NSScanner scannerWithString: fullHex] scanHexInt: &hexComponent];
    return hexComponent / 255.0;
}

+ (UIColor *) colorWithHexString: (NSString *)color
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    // 判断前缀
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    // 从六位数值中找到RGB对应的位数并转换
    NSRange range;
    range.location = 0;
    range.length = 2;
    //R、G、B
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}

+ (UIColor *)questionCategoryColor:(NSInteger)index {
    NSArray *colorArr = [NSArray arrayWithObjects:@"#76BCFE",@"#FEC938",@"#C0E084",@"#FC7485", nil];
    return [UIColor colorWithHexString:colorArr[index % 4]];
}
@end
