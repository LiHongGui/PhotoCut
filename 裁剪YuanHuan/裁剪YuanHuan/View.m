//
//  View.m
//  裁剪YuanHuan
//
//  Created by lihonggui on 2016/12/8.
//  Copyright © 2016年 lihonggui. All rights reserved.
//

#import "View.h"

@implementation View


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    //获取图形上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    //画圆
    
    CGPoint center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    CGFloat radius = MIN(self.frame.size.width, self.frame.size.height)/3;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:0 endAngle:2*M_PI clockwise:YES];
    CGContextAddPath(context, path.CGPath);
    //    CGContextDrawPath(context, kCGPathStroke);
    //
    CGContextStrokePath(context);

}

@end
