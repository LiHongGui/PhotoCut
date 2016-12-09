//
//  ViewController.m
//  裁剪YuanHuan
//
//  Created by lihonggui on 2016/12/8.
//  Copyright © 2016年 lihonggui. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self test1];
    
}

- (IBAction)imageCut:(UIButton *)sender {
    //加载图片
    UIImage *image = [UIImage imageNamed:@"VR33755OW9YP"];
    //开启图形上下文(比图片稍大的)
    CGSize size = CGSizeMake(image.size.width+10, image.size.height+10);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    //获取图形上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    //画圆环
    CGFloat radius = MIN(image.size.width, image.size.height)/2.5;
    CGPoint center = CGPointMake(size.width/2, size.height/2);
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:0 endAngle:2*M_PI clockwise:YES];
    
    //设置圆环线宽
    CGContextSetLineWidth(context, 10);
    [[UIColor redColor]setStroke];
    
    //添加到图形上下文
    CGContextAddPath(context, path.CGPath);
    CGContextStrokePath(context);
//    CGContextClip(context);
    
    
    
    //再画一个裁剪圆环
    UIBezierPath *path1 = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:0 endAngle:2*M_PI clockwise:YES];
    //添加到图形上下文中
    CGContextAddPath(context, path1.CGPath);
    //裁剪
    CGContextClip(context);
    //绘图(手动绘图----绘制到图形上下文中)
//    [image drawAtPoint:CGPointMake(5, 5)];
    [image drawAtPoint:CGPointZero];

    //获取图片
    UIImage *imageGet =  UIGraphicsGetImageFromCurrentImageContext();
    //关图形上下文
    UIGraphicsEndImageContext();
    self.imageView.image = imageGet;
    
    
    
}

-(void)test1
{
    //加载需要裁剪的图片
    UIImage *image = [UIImage imageNamed:@"img05"];
    //开启图形上下文
    UIGraphicsBeginImageContextWithOptions(image.size, YES, 0);
    
    //把图片绘制到图形上下文中
    [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    
    //添加文字
    NSString *text = @"214212421124121241241121241";
    //文字绘制到图形上下文中
    NSDictionary *dict = @{NSFontAttributeName:[UIFont systemFontOfSize:15]};
    [text drawInRect:CGRectMake(400, 400, 100, 100) withAttributes:dict];
    //添加水印图片
    UIImage *imageyin = [UIImage imageNamed:@"logo"];
    [imageyin drawInRect:CGRectMake(100, 500, 100, 100)];
    //获取图形上下文的图片
    UIImage *getImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //结束图形上下文
    UIGraphicsEndImageContext();
    //保存图片
    
    UIImageWriteToSavedPhotosAlbum(getImage, nil, nil, nil);
    
}

@end
