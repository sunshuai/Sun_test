//
//  UI_ZbarReaderViewController.m
//  Sun_test
//
//  Created by Shuai Sun on 12-9-10.
//  Copyright (c) 2012年 Yek.me. All rights reserved.
//

#import "UI_ZbarReaderViewController.h"

@interface UI_ZbarReaderViewController ()

@end

@implementation UI_ZbarReaderViewController
@synthesize zBarView;
@synthesize history_Button;
@synthesize goBack_Button;
@synthesize camera_Button;
@synthesize top_view;
@synthesize bottom_view;
@synthesize m_camara;
@synthesize camera_simulator;
@synthesize resultText;
@synthesize resultImage;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        zBarView = [[ZBarReaderView alloc] initWithImageScanner:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.m_camara = [[[UIImagePickerController alloc] init] autorelease];
    zBarView.readerDelegate = self;
    
    m_camara.sourceType = UIImagePickerControllerSourceTypeCamera;
    m_camara.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
    m_camara.cameraFlashMode = UIImagePickerControllerCameraFlashModeAuto;
    [UIImagePickerController isFlashAvailableForCameraDevice:UIImagePickerControllerCameraDeviceRear];
    // you can use this to support the simulator
    if(TARGET_IPHONE_SIMULATOR) {
        camera_simulator = [[ZBarCameraSimulator alloc]
					 initWithViewController: self];
        camera_simulator.readerView = zBarView;
    }
    

    
//    ZBarReaderViewController *reader = [ZBarReaderViewController new];  
//    reader.readerDelegate = self;  
//    ZBarImageScanner *scanner = reader.scanner;  
//    [scanner setSymbology: ZBAR_QRCODE  
//                   config: ZBAR_CFG_ENABLE  
//                       to: 0];
//reader.modalTransitionStyle = UIModalTransitionStylePartialCurl;
//reader.hidesBottomBarWhenPushed = YES;
//    [self presentModalViewController: reader  
//                            animated: YES];  
//    [reader release]; 
//    reader.readerView.zoom = 1.0;
// Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.zBarView start];
    //[m_camara startVideoCapture];
    [super viewWillAppear:animated];
//    [[UIApplication sharedApplication] setStatusBarHidden:YES];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.zBarView stop];
}

- (void)viewDidUnload
{
    [self setZBarView:nil];
    [self setHistory_Button:nil];
    [self setGoBack_Button:nil];
    [self setCamera_Button:nil];
    [self setTop_view:nil];
    [self setBottom_view:nil];
    [self setM_camara:nil];
    [self setCamera_simulator:nil];
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [zBarView release];
    [history_Button release];
    [goBack_Button release];
    [camera_Button release];
    [top_view release];
    [bottom_view release];
    [m_camara release];
    [camera_simulator release];
    
    [super dealloc];
}


-(IBAction)CancelView:(id)sender{
    [self dismissModalViewControllerAnimated:YES];
}

-(IBAction)cmara:(id)sender{
    
    //self.m_camara =[self.camera_simulator picker]; ;
    
//    self.m_camara.cameraFlashMode = UIImagePickerControllerCameraFlashModeOn;
    NSLog(@"%d",self.m_camara.cameraFlashMode);
    
    if (self.m_camara.cameraFlashMode = UIImagePickerControllerCameraFlashModeOff) {
        [camera_Button setTitle:@"打开" forState:UIControlStateNormal];
         self.m_camara.cameraFlashMode = UIImagePickerControllerCameraFlashModeOn;
    }else if (self.m_camara.cameraFlashMode = UIImagePickerControllerCameraFlashModeOn) {
        [camera_Button setTitle:@"自动" forState:UIControlStateNormal];
        self.m_camara.cameraFlashMode = UIImagePickerControllerCameraFlashModeAuto;
    }else if (self.m_camara.cameraFlashMode = UIImagePickerControllerCameraFlashModeAuto) {
        [camera_Button setTitle:@"关闭" forState:UIControlStateNormal];
        self.m_camara.cameraFlashMode = UIImagePickerControllerCameraFlashModeOff;
    }
}

-(IBAction)GotoHistory:(id)sender{
    
}

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [zBarView willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
}

-(void)readerView:(ZBarReaderView *)readerView didReadSymbols:(ZBarSymbolSet *)symbols fromImage:(UIImage *)image
{
    for (ZBarSymbol *symBol in symbols) {
         resultText.text = symBol.data;
        NSLog(@"%@",symBol.data);
       
    }
}

#pragma mark -  QR代理
//-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
//    id<NSFastEnumeration> results =
//    [info objectForKey: ZBarReaderControllerResults];
//    ZBarSymbol *symbol = nil;
//    for(symbol in results)
//        // EXAMPLE: just grab the first barcode
//        break;
//    
//    // EXAMPLE: do something useful with the barcode data
//    resultText.text = symbol.data;
//    
//    // EXAMPLE: do something useful with the barcode image
//    resultImage.image =
//    [info objectForKey: UIImagePickerControllerOriginalImage];
//    
//    // ADD: dismiss the controller (NB dismiss from the *reader*!)
//    [picker dismissModalViewControllerAnimated: YES];
//}






@end
