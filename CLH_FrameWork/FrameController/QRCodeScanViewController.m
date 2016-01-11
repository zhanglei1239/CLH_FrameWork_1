//
//  QRCodeScanViewController.m
//  CLH_FrameWork
//
//  Created by Mac on 16/1/8.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "QRCodeScanViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AVFoundation/AVCaptureOutput.h>
@interface QRCodeScanViewController ()
{
    NSTimer * timer;
    int num;
    BOOL upOrdown;
    UIImageView * line;
}
@end

@implementation QRCodeScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:RGBACOLOR(240, 245, 248, 1)];
    [self.lblTitle setText:@"扫一扫"];
    [content setHidden:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setupCamera];
}
- (void)setupCamera
{
    // Device
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // Input
    _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    
    // Output
    _output = [[AVCaptureMetadataOutput alloc]init];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    [_output setRectOfInterest:CGRectMake(((UI_SCREEN_HEIGHT+60-220)/2)/UI_SCREEN_HEIGHT,((UI_SCREEN_WIDTH-220)/2)/UI_SCREEN_WIDTH,220/UI_SCREEN_HEIGHT,220/UI_SCREEN_WIDTH)];
    // Session
    _session = [[AVCaptureSession alloc]init];
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    if ([_session canAddInput:self.input])
    {
        [_session addInput:self.input];
    }
    
    if ([_session canAddOutput:self.output])
    {
        [_session addOutput:self.output];
    }
    
    // 条码类型 AVMetadataObjectTypeQRCode
    _output.metadataObjectTypes =@[AVMetadataObjectTypeCode128Code,AVMetadataObjectTypeUPCECode,AVMetadataObjectTypeCode39Code,AVMetadataObjectTypeCode39Mod43Code,AVMetadataObjectTypeEAN13Code,AVMetadataObjectTypeEAN8Code,AVMetadataObjectTypeCode93Code,AVMetadataObjectTypePDF417Code,AVMetadataObjectTypeQRCode,AVMetadataObjectTypeAztecCode,AVMetadataObjectTypeInterleaved2of5Code,AVMetadataObjectTypeITF14Code,AVMetadataObjectTypeDataMatrixCode] ;
    
    // Preview
    _preview =[AVCaptureVideoPreviewLayer layerWithSession:self.session];
    _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    _preview.frame =CGRectMake(0,60,UI_SCREEN_WIDTH,UI_SCREEN_HEIGHT-60);
    
    [self.view.layer insertSublayer:self.preview atIndex:0];
    
    float offy = 60;
    float offx = 0;
    
    UIView * topCover =  [[UIView alloc] initWithFrame:CGRectMake(offx, offy, UI_SCREEN_WIDTH, 60+(UI_SCREEN_HEIGHT-60-60-220)/2+8)];
    [topCover setBackgroundColor:[UIColor blackColor]];
    [topCover setAlpha:.7];
    [self.view addSubview:topCover];
    
    offy = offy+60+(UI_SCREEN_HEIGHT-60-60-220)/2+8;
    
    UIView * leftCover = [[UIView alloc] initWithFrame:CGRectMake(offx, offy, (UI_SCREEN_WIDTH-220)/2+8, 220-16)];
    [leftCover setBackgroundColor:[UIColor blackColor]];
    [leftCover setAlpha:.7];
    [self.view addSubview:leftCover];
    
    offx = offx +(UI_SCREEN_WIDTH-220)/2+220;
    
    UIView * rightCover = [[UIView alloc] initWithFrame:CGRectMake(offx-8, offy, (UI_SCREEN_WIDTH-220)/2+8, 220-16)];
    [rightCover setBackgroundColor:[UIColor blackColor]];
    [rightCover setAlpha:.7];
    [self.view addSubview:rightCover];
    
    offy = offy + 220-8;
    
    UIView * bottomCover = [[UIView alloc] initWithFrame:CGRectMake(0, offy-8, UI_SCREEN_WIDTH, (UI_SCREEN_HEIGHT-60-60-220)/2+8)];
    [bottomCover setBackgroundColor:[UIColor blackColor]];
    [bottomCover setAlpha:.7];
    [self.view addSubview:bottomCover];
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(10,120, UI_SCREEN_WIDTH-20, 20)];
    [label setText:@"将二维码放入框内，即可自动完成扫描"];
    [label setTextColor:[UIColor lightTextColor]];
    [label setFont:[UIFont fontWithName:TEXT_FONT_NAME size:16]];
    [label setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:label];
    
    num = 1;
    upOrdown = NO;
    
    UIImageView * image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pick_bg"]];
    image.frame = CGRectMake(0, 0, 220, 220);
    image.center = CGPointMake(UI_SCREEN_WIDTH/2, UI_SCREEN_HEIGHT/2+60);
    [self.view addSubview:image];
    
    line = [[UIImageView alloc] initWithFrame:CGRectMake(2, 2, 216, 2)];
    line.image = [UIImage imageNamed:@"line"];
    [image addSubview:line];
    
    //定时器，设定时间过1.5秒，
    timer = [NSTimer scheduledTimerWithTimeInterval:.02 target:self selector:@selector(animation1) userInfo:nil repeats:YES];
    
    // Start
    [_session startRunning];
}

-(void)animation1
{
    if (upOrdown == NO) {
        num ++;
        line.frame = CGRectMake(2, (2)*num, 216, 2);
        if (2*num == 216) {
            upOrdown = YES;
        }
    }
    else {
        num --;
        line.frame = CGRectMake(2, 2*num, 216, 2);
        if (num == 1) {
            upOrdown = NO;
        }
    }
}

#pragma mark AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    
    NSString *stringValue;
    
    if ([metadataObjects count] >0)
    {
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
    }
    
    [_session stopRunning];
    [timer invalidate];
    
    if (_delegate && [_delegate respondsToSelector:@selector(scanFinish:)]) {
        [_delegate scanFinish:stringValue];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)back:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
