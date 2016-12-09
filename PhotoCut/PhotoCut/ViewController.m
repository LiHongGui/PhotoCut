//
//  ViewController.m
//  PhotoCut
//
//  Created by lihonggui on 2016/12/8.
//  Copyright © 2016年 lihonggui. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(nonatomic,strong) UIImageView *imageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"77dc212580524c0e99297bcd3f5dab91"]];
    _imageView = imageView;
    imageView.frame = CGRectMake(0, 0, 200, 200);
    imageView.center = self.view.center;
    [self.view addSubview: imageView];
    
}
- (IBAction)clickChangePhotoButton:(UIButton *)sender {
//    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"77dc212580524c0e99297bcd3f5dab91"]];
//    imageView.frame = CGRectMake(0, 0, 200, 200);
//    imageView.center = self.view.center;
//    [self.view addSubview: imageView];
//
//    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"562c11dfa9ec8a137bae6da5f403918fa0ecc03a.jpg"]];
//    _imageView = imageView;
//    imageView.frame = CGRectMake(20, 40, 200, 200);
//    imageView.center = self.view.center;
//    [self.view addSubview: imageView];
}
#pragma mark
#pragma mark -  点击裁剪图片
- (IBAction)clickContext:(UIButton *)sender {
    
    /*
     这个方法需要手动开启图形上下文
     */
    //获取裁剪的对象图片
    self.imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"dst2"]];
    _imageView.frame = CGRectMake(100, 100, 200, 200);
    [self.view addSubview:_imageView];
    //开启图形上下文
    UIGraphicsBeginImageContextWithOptions(self.imageView.frame.size, NO, 0.0);
    //获取图形上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    //创建路径---圆形
   CGPoint center = CGPointMake(self.imageView.frame.size.width/2, self.imageView.frame.size.height/2);
    CGFloat radius = MIN(self.imageView.frame.size.width,self.imageView.frame.size.height)/2;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius -20 startAngle:0 endAngle:2*M_PI clockwise:YES];
    //画圆
    UIBezierPath *pathYuan = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, self.imageView.frame.size.width, self.imageView.frame.size.height) cornerRadius:radius+20 ];
    CGContextSetLineWidth(context, 20);
    [pathYuan closePath];
    [[UIColor redColor]setStroke];
    CGContextDrawPath(context, kCGPathFillStroke);
    CGContextAddPath(context, pathYuan.CGPath);
    CGContextAddPath(context, path.CGPath);
    
    //裁剪
    CGContextClip(context);
    //绘制图形
    [_imageView drawRect:CGRectZero];
    //获取图片
    UIImage *getImage = UIGraphicsGetImageFromCurrentImageContext();
    
    #warning 裁剪指定区域
    //当前设备的分辨率
    CGFloat scale = [UIScreen mainScreen].scale;
    
    CGFloat y = (self.imageView.frame.size.height - 2*radius)/2;
    y = y*scale;
    CGFloat width = 2*radius;
    CGFloat height =2*radius;
    width = width*scale;
    height = height*scale;
    CGImageRef imageRef = CGImageCreateWithImageInRect(getImage.CGImage, CGRectMake(0, y, width, height));
    
    
    //关闭图形上下文
    UIGraphicsEndImageContext();
    //赋值
    #warning 裁剪后的图片
//    self.imageView.image = [UIImage imageWithCGImage:imageRef];
    
    
    getImage = [UIImage imageWithCGImage:imageRef];
    self.imageView.image = getImage;
    /*
     把裁剪的图片保存到相册
     */
    UIImageWriteToSavedPhotosAlbum(getImage, nil, @selector(image:didFinishSavingWithError:contextInfo:), @"相册");
    
    /*
     把裁剪的图片保存到沙盒中
     */
    //创建文件
    NSString *documents = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    //拼接文件
    NSString *file = [documents stringByAppendingPathComponent:@"111.png"];
    NSLog(@"%@",file);
    //写入图片到沙盒
    NSData *data = UIImagePNGRepresentation(getImage);
//    NSData *saveData = [NSData dataWithData:data];
    [data writeToFile:file atomically:YES];
}
#warning 保存相册要调用这个方法
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    NSLog(@"相册已保存---%@",contextInfo);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
