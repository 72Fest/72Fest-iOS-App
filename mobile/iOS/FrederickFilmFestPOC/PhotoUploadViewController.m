//
//  PhotoUploadViewController.m
//  FrederickFilmFestPOC
//
//  Created by Mass Defect on 9/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PhotoUploadViewController.h"
#import "UIImage+Resize.h"
#import "InfoViewController.h"
#import "Reachability.h"
#import "ConnectionInfo.h"
#import "CountDownView.h"
#import "FrederickFilmFestPOCAppDelegate.h"
#import "IOSCompatability.h"

@implementation PhotoUploadViewController
@synthesize curImage = _curImage;
@synthesize fullSizeImage = _fullSizeImage;
@synthesize curConnection = _curConnection;
@synthesize selectPhotoFromSource = _selectPhotoFromSource;
@synthesize uploadBtn = _uploadBtn;
@synthesize uploadTxt = _uploadTxt;
@synthesize progressView = _progressView;
@synthesize selectedImage = _selectedImage;
@synthesize activityIndicator = _activityIndicator;
@synthesize countDownTimer = _countDownTimer;
@synthesize parentTabBar = _parentTabBar;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //init the flag to NO
        cameraWasUsed = NO;
    }
    return self;
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setUploadState:NO];
    [self.uploadBtn setHidden:YES];
    
    [self.selectedImage setImage:self.curImage];
    
    [self.uploadBtn setEnabled:([self.selectedImage image] == nil) ? NO : YES];

    //set up custom font
    [self.uploadTextLabel setFont:LABEL_FONT];
    
    
    // add a bg image
    CGRect frame = [[UIScreen mainScreen] bounds];
    //push the bg down
    frame.origin.y = self.navigationController.navigationBar.frame.size.height;

    UIView *v = [[UIView alloc] initWithFrame:frame];
    UIImage *i = [UIImage imageNamed:@"bkg.png"];
    UIColor *c = [[UIColor alloc] initWithPatternImage:i];
    v.backgroundColor = c;
    [[self view] insertSubview:v atIndex:0];
    
    //set up image
    UIImageView *iv = 
        [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"filmFestLogo.png"]];
    [[self navigationItem] setTitleView:iv];
    
    //set up tab item
    UIBarButtonItem *infoBtnItem = 
        [[UIBarButtonItem alloc] initWithTitle:@"Info" style:UIBarButtonItemStylePlain target:self action:@selector(infoItemPressed:)];
    
    [[self navigationItem] setRightBarButtonItem:infoBtnItem];
    
    
    // attempt to retrieve the count down metata data
    [self requestCountdownMetadata:COUNTDOWN_METADATA_URL];
    
    if (SYSTEM_IS_IOS7) {
        CGRect containerFrame = self.uploadContainer.frame;
        containerFrame.origin.y += self.navigationController.navigationBar.frame.size.height + 20.0;
        self.uploadContainer.frame = containerFrame;
    }
}


- (void)viewDidUnload
{
    self.progressView = nil;
    
    self.selectedImage = nil;
    
    self.selectPhotoFromSource = nil;
    
    self.uploadTxt = nil;
    
    self.activityIndicator = nil;
    
    self.parentTabBar = nil;
    
    [self setCountDownTimer:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;    
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}

#pragma mark - Upload code
- (void)uploadImage:(UIImage *)img {
    NSMutableURLRequest *request = 
        [NSMutableURLRequest requestWithURL:[NSURL URLWithString:UPLOAD_URL_STR]];
        NSString *boundary = 
            [NSString stringWithFormat:@"----------14737809831466499882%d",arc4random() % 74];
    
    
    //[request addValue:@"multipart/form-data" forHTTPHeaderField:@"enctype"];
    [request addValue:[NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary] forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5" forHTTPHeaderField:@"Accept"];

    
    [request setValue:@"PhotoApp iOS" forHTTPHeaderField:@"User-agent"];
    
    [request setHTTPMethod:@"POST"];
    
    //set up data to send
    NSData *imageData = [NSData dataWithData:UIImageJPEGRepresentation(img, 95)];
    
    NSMutableData *body = [NSMutableData data];
    
    //build body
    
    //separate each form data item with boundary
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    //[body appendData:[[NSString stringWithString:@"Content-Disposition: form-data; name=\"caption\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    //[body appendData:[[NSString stringWithString:@"Caption Text"] dataUsingEncoding:NSUTF8StringEncoding]]; 
    //[body appendData:[[NSString stringWithFormat:@"\r\n%--@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[@"Content-Disposition: form-data; name=\"file\";  filename=\"iPhoneImg.jpg\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]]; 
    [body appendData:imageData];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];

    [request setHTTPBody:body];
    
    self.curConnection = [NSURLConnection connectionWithRequest:request delegate:self];
}

- (void)setUploadState:(BOOL)isUploading {
    [self.uploadTxt setHidden:!isUploading];
    [self.progressView setHidden:!isUploading];
    
    //[uploadBtn setEnabled:NO];
    [self.selectPhotoFromSource setEnabled:!isUploading];
    
    if (isUploading) {
        [self.uploadBtn setHidden:isUploading];
        [self.activityIndicator startAnimating];
    } else {
        [self.activityIndicator stopAnimating];
    }
}

#pragma mark - Countdown code
- (void)requestCountdownMetadata:(NSString *)countDownURLStr {
    Reachability *r = [Reachability reachabilityForInternetConnection];
    NetworkStatus netStatus = [r currentReachabilityStatus];
    
    //if we can get a connection lets move forward
    if (netStatus == NotReachable) {
        //there is nothing else to do here
        return;
    }

    //create a queue to pull the URL
    dispatch_queue_t countDownRetreivalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async(countDownRetreivalQueue, ^{
        NSURLResponse *response;
        NSError *err;
        NSError *jsonErr;
        
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:countDownURLStr]];
        
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
        
        if (!data) {
            //For now we will just return
            return ;
        }
        
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:nil error:&jsonErr];
        NSString *messageDict = [jsonDict valueForKey:kMessageKey];
        
        NSString *countdownCaption = (NSString *)[messageDict valueForKey:kCountdownCaption];
        
        NSDictionary *countdownTime = (NSDictionary *)[messageDict valueForKey:kCountdownTime];
        
        NSNumber *cdYear = (NSNumber *)[countdownTime valueForKey:kCountdownTimeYear];
        NSNumber *cdMonth = (NSNumber *)[countdownTime valueForKey:kCountdownTimeMonth];
        NSNumber *cdDay = (NSNumber *)[countdownTime valueForKey:kCountdownTimeDay];
        NSNumber *cdHour = (NSNumber *)[countdownTime valueForKey:kCountdownTimeHour];
        NSNumber *cdMinute = (NSNumber *)[countdownTime valueForKey:kCountdownTimeMin];
        NSNumber *cdSecond = (NSNumber *)[countdownTime valueForKey:kCountdownTimeSec];
        
        //now convert json data to NSDate to make itself usefule
        NSDateComponents *comp = [[NSDateComponents alloc] init];
        [comp setYear:[cdYear integerValue]];
        [comp setMonth:[cdMonth integerValue]];
        [comp setDay:[cdDay integerValue]];
        [comp setHour:[cdHour integerValue]];
        [comp setMinute:[cdMinute integerValue]];
        [comp setSecond:[cdSecond integerValue]];
        
        NSCalendar *cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDate *countDownDate = [cal dateFromComponents:comp];
        NSDate *curDate = [NSDate date];
        
        //lets check to see if the date has expired
        if ([curDate compare:countDownDate] == NSOrderedDescending) {
            NSLog(@"Countdown date has expired!");
            dispatch_async(dispatch_get_main_queue(), ^ {
                [self displayCountdownWithCaption:@"Countdown expired!"
                                          andDate:countDownDate];
            });
        } else {
            NSLog(@"Retrieved countdown date:%@", countDownDate);
            
            //run the following code in the main thread
            dispatch_async(dispatch_get_main_queue(), ^ {
                [self displayCountdownWithCaption:countdownCaption
                                          andDate:countDownDate];
            });
        }
        
        
    });
}

- (void)displayCountdownWithCaption:(NSString *)captionStr andDate:(NSDate *)countDownDate {
    CGRect cFrame = CGRectMake(43, 7, 235, 80);
    
    //adjust placement for iOS7
    if (SYSTEM_IS_IOS7) {
        cFrame.origin.y += self.navigationController.navigationBar.frame.size.height + 20.0;
    }
    
    CountDownView *cdv = [[CountDownView alloc] initWithFrame:cFrame andCountDownDate:countDownDate];
    [cdv setCaption:captionStr];
    
    [self.view addSubview:cdv];
}

#pragma mark - NSURL delegate methods
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    
    NSString *content = [NSString stringWithUTF8String:[data bytes]];
    NSLog(@"got data:%@", content );
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"finished loading"); 
    [self setUploadState:NO];
    
    //reset the flag to the default value of no
    cameraWasUsed = NO;

    UIAlertView *alert = 
    [[UIAlertView alloc] initWithTitle:@"Success" 
                               message:@"The image has been submitted for approval!" 
                              delegate:nil 
                     cancelButtonTitle:@"Dismiss" 
                     otherButtonTitles:nil];
    [alert show];
    
    [self.selectedImage setImage:nil];
    //[self setCurImage:nil];
    [self.uploadBtn setEnabled:NO];
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"failed");
    [self setUploadState:NO];
    
    //we still want to give them another try to upload though
    [self.uploadBtn setEnabled:YES];
    
    
    UIAlertView *failAlert = 
        [[UIAlertView alloc] initWithTitle:@"Failed!" 
                                   message:[NSString stringWithFormat:@"The image failed to upload! %@", [error localizedDescription]] 
                                  delegate:nil 
                         cancelButtonTitle:@"Dismiss" 
                         otherButtonTitles:nil];
    [failAlert show];
    
}

- (void)connection:(NSURLConnection *)connection didSendBodyData:(NSInteger)bytesWritten totalBytesWritten:(NSInteger)totalBytesWritten totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite {
    [self.progressView setProgress:(float)totalBytesWritten / (float)totalBytesExpectedToWrite];
    //NSLog(@"Data:%d / %d", totalBytesWritten, totalBytesExpectedToWrite);
}

- (void)resetConnection:(NSURLConnection *)connection {
    [connection cancel];
    [self.progressView setProgress:0];
}

#pragma mark - Image Picker delegate methods
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *img = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    //save the fullsized image to reference later
    self.fullSizeImage = img;
    
    //resize image
    UIImage *scaledImg = [img resizedImageWithContentMode:UIViewContentModeScaleAspectFit 
                                                   bounds:CGSizeMake(1024, 1024) 
                                     interpolationQuality:kCGInterpolationMedium];
    
    //retrieve image from dictionary
    [self setCurImage:scaledImg];
    
    //[self uploadImage:newImg];
    [self.selectedImage setImage:self.curImage];
    
    //enable the upload btn
    [self.uploadBtn setEnabled:YES];
    [self.uploadBtn setHidden:NO];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Action Sheet delegate methods
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {

    switch (buttonIndex) {
        case 0:
            //cancel any upload that may have been started
            [self resetConnection:self.curConnection];
            
            [self choosePhotoBtnPressed];
            break;
        case 1:
            //cancel any upload that may have been started
            [self resetConnection:self.curConnection];
            
            [self takePhotoBtnPressed];
            break;
        default:
            break;
    }
}

#pragma mark - photo actions
- (void)takePhotoBtnPressed {
    //insure a camera is on board
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        return;
    }
    
    //flag that the camera was used for this photo
    cameraWasUsed = YES;
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
    [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
    [imagePicker setDelegate:self];

    [self presentViewController:imagePicker animated:YES completion:nil];
    
}

- (void)choosePhotoBtnPressed {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
    //flag that the camera was not used
    cameraWasUsed = NO;
    
    [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [imagePicker setDelegate:self];
    [imagePicker setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentViewController:imagePicker animated:YES completion:nil];
    
}

#pragma mark - nav bar actions
- (void)infoItemPressed:(id)sender {
    NSLog(@"DO SOMETHING");
    
    InfoViewController *newVC = [[InfoViewController alloc] init];
    
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:newVC];
    [nc.navigationBar setTintColor:THEME_CLR];
    
    //set up nav bar header
    
    
    [self presentViewController:nc animated:YES completion:nil];
}

- (void)infoViewClosed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - IBActions
- (IBAction)selectPhotoFromSourcePressed:(id)sender {
    UIActionSheet *sheet;
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        sheet = [[UIActionSheet alloc] initWithTitle:@"Select a photo source"
                                            delegate:self
                                   cancelButtonTitle:@"Cancel"
                              destructiveButtonTitle:nil
                                   otherButtonTitles:@"Photo Library", @"Camera", nil];
    } else {
        sheet = [[UIActionSheet alloc] initWithTitle:@"Select a photo source"
                                            delegate:self
                                   cancelButtonTitle:@"Cancel"
                              destructiveButtonTitle:nil
                                   otherButtonTitles:@"Photo Library", nil];
    }
    
    [sheet showFromTabBar:self.parentTabBar];
}

- (IBAction)uploadBtnPressed:(id)sender {
    if ([self.selectedImage image] == nil) {

        UIAlertView *failAlert = 
            [[UIAlertView alloc] initWithTitle:@"Error" 
                                       message:@"Please select an image to upload!" 
                                      delegate:nil 
                             cancelButtonTitle:@"Dismiss" 
                             otherButtonTitles:nil];
        [failAlert show];
        

        return;
    }
    
    if (cameraWasUsed) {
        //save original file to camera roll if the camera was used
        UIImageWriteToSavedPhotosAlbum(self.fullSizeImage, nil, nil, nil);
    }

    //we no longer need a reference to the original image
    self.fullSizeImage = nil;
    
    [self.progressView setProgress:0.0];
    
    //check to make sure we have a network connection
    Reachability *r = [Reachability reachabilityForInternetConnection];
    NetworkStatus netStatus = [r currentReachabilityStatus];
    
    if (netStatus == NotReachable) {
        UIAlertView *alert = 
        [[UIAlertView alloc] initWithTitle:@"Error" 
                                   message:@"Could not create a network connection!" 
                                  delegate:nil 
                         cancelButtonTitle:@"Dismiss" 
                         otherButtonTitles:nil];
        [alert show];
        
        
        return;
    } else {
        [self setUploadState:YES];
        [self uploadImage:[self.selectedImage image]];
        //[NSThread detachNewThreadSelector:@selector(uploadImage:) toTarget:self withObject:[selectedImage image]];

    }
}

@end
