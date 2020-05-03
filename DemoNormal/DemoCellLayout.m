//
//  DemoCellLayout.m
//  DemoNormal
//
//  Created by 芦旺达 on 2020/5/1.
//  Copyright © 2020 com.xiaowangzi. All rights reserved.
//

#import "DemoCellLayout.h"
#import "Model.h"
#import <CoreText/CoreText.h>


@implementation DemoCellLayout
//这里的代码可以直接复制粘贴使用
- (instancetype)initWithModel:(Model *)dataModel{
    if (!dataModel) return nil;
    self = [super init];
    if (self) {
        _dataModel = dataModel;
        [self layout];
    }
    return self;
}

-(void)setDataModel:(Model *)dataModel{
    _dataModel = dataModel;
    [self layout];
}

- (void)layout{
   CGFloat sWidth = [UIScreen mainScreen].bounds.size.width;
    
      //计算title的宽和高
    CGFloat titleWidth = sWidth-180;
    CGFloat titleHeight = [self calcLabelHeight:_dataModel.pvs fontSize:14 width:titleWidth];
    self.titleRect = CGRectMake(15, 10, titleWidth, titleHeight);

}

#pragma mark -- Caculate Method
//计算文本宽度
- (CGFloat)calcWidthWithTitle:(NSString *)title font:(CGFloat)font {
    NSStringDrawingOptions options =  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    CGRect rect = [title boundingRectWithSize:CGSizeMake(MAXFLOAT,MAXFLOAT) options:options attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil];
    
    CGFloat realWidth = ceilf(rect.size.width);
    return realWidth;
}
//计算文本高度
- (CGFloat)calcLabelHeight:(NSString *)str fontSize:(CGFloat)fontSize width:(CGFloat)width {
    NSStringDrawingOptions options =  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    
    CGRect rect = [str boundingRectWithSize:CGSizeMake(width,MAXFLOAT) options:options attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil];
    
    CGFloat realHeight = ceilf(rect.size.height);
    return realHeight;
}
//计算富文本宽度
- (int)caculateAttributeLabelHeightWithString:(NSAttributedString *)string  width:(int)width {
    int total_height = 0;
    
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)string);    //string 为要计算高度的NSAttributedString
    CGRect drawingRect = CGRectMake(0, 0, width, 100000);  //这里的高要设置足够大
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, drawingRect);
    CTFrameRef textFrame = CTFramesetterCreateFrame(framesetter,CFRangeMake(0,0), path, NULL);
    CGPathRelease(path);
    CFRelease(framesetter);
    
    NSArray *linesArray = (NSArray *) CTFrameGetLines(textFrame);
    
    CGPoint origins[[linesArray count]];
    CTFrameGetLineOrigins(textFrame, CFRangeMake(0, 0), origins);
    
    int line_y = (int) origins[[linesArray count] -1].y;  //最后一行line的原点y坐标
    
    CGFloat ascent;
    CGFloat descent;
    CGFloat leading;
    
    CTLineRef line = (__bridge CTLineRef) [linesArray objectAtIndex:[linesArray count]-1];
    CTLineGetTypographicBounds(line, &ascent, &descent, &leading);
    
    total_height = 100000 - line_y + (int) descent +1;    //+1为了纠正descent转换成int小数点后舍去的值
    
    CFRelease(textFrame);
    
    return total_height;
}


/**
 
 CGFloat sWidth = [UIScreen mainScreen].bounds.size.width;
    //计算title的宽度
    CGFloat titleWidth = sWidth-180;
    CGFloat titleHeight = 0;
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc]init];
    [paraStyle setLineSpacing:5];
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:16],
    NSForegroundColorAttributeName: [UIColor colorWithRed:26/255.0 green:26/255.0 blue:26/255.0 alpha:1]
    ,NSParagraphStyleAttributeName: paraStyle
    ,NSKernAttributeName:@0
    };
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:_dataModel.title attributes:attributes];
    //计算title的高度
    titleHeight = [self caculateAttributeLabelHeightWithString:attrStr width:titleWidth];
    self.titleRect = CGRectMake(15, 10, titleWidth, titleHeight);
    
    //计算title的宽度
    CGFloat titleWidth2 = sWidth-30;
    CGFloat titleHeight2 = 0;
    NSMutableParagraphStyle *paraStyle2 = [[NSMutableParagraphStyle alloc]init];
    [paraStyle setLineSpacing:5];
    NSDictionary *attributes2 = @{NSFontAttributeName: [UIFont systemFontOfSize:16],
    NSForegroundColorAttributeName: [UIColor colorWithRed:26/255.0 green:26/255.0 blue:26/255.0 alpha:1]
    ,NSParagraphStyleAttributeName: paraStyle2
    ,NSKernAttributeName:@0
    };
    NSMutableAttributedString *attrStr2 = [[NSMutableAttributedString alloc] initWithString:_dataModel.title attributes:attributes2];
    //计算title的高度
    titleHeight2 = [self caculateAttributeLabelHeightWithString:attrStr2 width:titleWidth2];
    self.titleRect2 = CGRectMake(15, 10, titleWidth2, titleHeight2);
    
    //计算图片的位置
    self.imagesArr = [[NSMutableArray alloc] init];
    if (_dataModel.imglist.count < 3) {
        self.imageRect = CGRectMake(CGRectGetMaxX(self.titleRect)+10, 15, 140, 120);
    }else{
        for (int i = 0; i<3; i++) {
            CGRect imageRect = CGRectMake(((sWidth-50)/3 * i + i * 10 + 15), CGRectGetMaxY(self.titleRect2) + 10, 120, 100);
            [self.imagesArr addObject:@(imageRect)];
        }
    }
    
    //计算来源位置
    CGFloat fromWidth = [self calcWidthWithTitle:_dataModel.from font:14];
    CGFloat fromHeight = [self calcLabelHeight:_dataModel.from fontSize:14 width:fromWidth];
    self.fromLabelRect = CGRectMake(15, CGRectGetMaxY(self.titleRect)+90, fromWidth, fromHeight);
     
    
    //计算阅读量位置
    CGFloat pvsWidth = [self calcWidthWithTitle:_dataModel.pvs font:14];
    CGFloat pvsHeight = [self calcLabelHeight:_dataModel.pvs fontSize:14 width:pvsWidth];
    self.pvsLabelRect = CGRectMake(CGRectGetMaxX(self.fromLabelRect)+10, CGRectGetMaxY(self.titleRect)+90, pvsWidth, pvsHeight);
    
    self.height = CGRectGetMaxY(self.pvsLabelRect);
 
 */

@end
