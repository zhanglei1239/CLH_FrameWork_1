//
//  QRCodeScanViewController.h
//  CLH_FrameWork
//
//  Created by Mac on 16/1/8.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "BaseViewController.h"
#import <AVFoundation/AVFoundation.h>
@interface QRCodeScanViewController : BaseViewController<AVCaptureMetadataOutputObjectsDelegate>
@property (nonatomic,assign) id delegate;
@property (nonatomic,strong) AVCaptureDevice * device;
@property (nonatomic,strong) AVCaptureDeviceInput *input;
@property (nonatomic,strong) AVCaptureMetadataOutput * output;
@property (nonatomic,strong) AVCaptureSession * session;
@property (nonatomic,strong) AVCaptureVideoPreviewLayer *preview;
@end
@protocol scanDelegate <NSObject>

-(void)scanFinish:(NSString *)data;

@end
