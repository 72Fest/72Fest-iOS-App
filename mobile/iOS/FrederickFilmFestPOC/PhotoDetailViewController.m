//
//  PhotoDetailViewController.m
//  FrederickFilmFestPOC
//
//  Created by Lonny Gomes on 6/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PhotoDetailViewController.h"
#import "PhotoListParser.h"
#import "ImageCache.h"
#import "DiskCacheManager.h"
#import "VoteManager.h"
#import "ConnectionInfo.h"
//#define USE_DISK_CACHE

@interface PhotoDetailViewController ()
- (void)setupVoteIconWithVoteVal:(BOOL)hasVote;
- (NSString *)imageKeyForIndex:(NSInteger)imageIdx;
- (void)submitVoteWithVoteValue:(BOOL)hasVote andImageKey:(NSString *)imageKey;
- (NSString *)curImageKey;
- (void)displayVoteTotal;
- (void)setVoteTitleWithTotal:(NSInteger)voteTotal;

@property (nonatomic, strong) UIBarButtonItem *likeBtn;
@property (nonatomic, strong) UIBarButtonItem *unlikeBtn;
@property (nonatomic, strong) NSURLConnection *curConnection;
@end

@implementation PhotoDetailViewController
@synthesize photosList = _photosList;
@synthesize selectedPhotIndex = _selectedPhotIndex;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // By default, set the index to zero
        self.selectedPhotIndex = 0;
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
    self.photoAlbumView.dataSource = self;
    self.photoAlbumView.delegate = self;
    self.photoAlbumView.zoomingIsEnabled = NO;
    self.hidesChromeWhenScrolling = NO;
    self.chromeCanBeHidden = YES;
    
    //set up custom toolbar
    self.likeBtn = [[UIBarButtonItem alloc] initWithImage:VOTE_UP_ICON_IMG style:UIBarButtonItemStylePlain target:self action:@selector(likeBtnPressed:)];
    self.unlikeBtn = [[UIBarButtonItem alloc] initWithImage:VOTE_DOWN_ICON_IMG style:UIBarButtonItemStylePlain  target:self action:@selector(likeBtnPressed:)];
    
    [self setupVoteIconWithVoteVal:NO];
    
    //load up all the data
    [self.photoAlbumView reloadData];
    
    //jump to the selected photo
    [self.photoAlbumView moveToPageAtIndex:self.selectedPhotIndex animated:NO];
    
    //update the vote total
    //[self displayVoteTotal];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (NSString *)curImageKey {
    return [self imageKeyForIndex:self.photoAlbumView.centerPageIndex];
}

- (void)setupVoteIconWithVoteVal:(BOOL)hasVote {
    UIBarItem* flexibleSpace =
    [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemFlexibleSpace target: nil action: nil];
    
    if (hasVote) {
        self.toolbar.items = @[self.previousButton,
                               flexibleSpace, self.unlikeBtn, flexibleSpace,
                               self.nextButton];
    } else {
        self.toolbar.items = @[ self.previousButton,
                               flexibleSpace, self.likeBtn, flexibleSpace,
                               self.nextButton];
    }
}

- (NSString *)imageKeyForIndex:(NSInteger)imageIdx {
    NSDictionary *imgDict = (NSDictionary *)[self.photosList objectAtIndex:imageIdx];
    
    NSString *imgFile = [[imgDict valueForKey:XML_TAG_FULL_URL] lastPathComponent];
    NSRange range = [imgFile rangeOfString:@"."];
    NSString *imgKey = [imgFile substringToIndex:range.location];
    
    return imgKey;
}

- (void)displayVoteTotal {
    self.title = @"Loading ...";
    dispatch_async(dispatch_queue_create("Vote Update Queue", NULL), ^{
        NSInteger voteTotal = [[VoteManager defaultManager] getUpdatedTotalForId:self.curImageKey];
        
        dispatch_async(dispatch_get_main_queue(), ^ {
            [self setVoteTitleWithTotal:voteTotal];
        });
    });
    
}

- (void)setVoteTitleWithTotal:(NSInteger)voteTotal {
    self.title =
        [NSString stringWithFormat:@"%d vote%@", voteTotal, ((voteTotal == 1) ? @"": @"s")];
        //[NSString stringWithFormat:@"%d vote%@ for %@", voteTotal, ((voteTotal == 1) ? @"": @"s"), self.curImageKey ];
}

#pragma mark - action selectors
- (void)likeBtnPressed:(id)sender {
    NSLog(@"Like button pressed! %d",  self.photoAlbumView.centerPageIndex);
    
    BOOL hasVote = [[VoteManager defaultManager] toggleVoteForImgKey:self.curImageKey];

    NSString *keyVal = self.curImageKey;
    
    [self submitVoteWithVoteValue:hasVote andImageKey:keyVal];

    //toggle like icon (for some reason I'm colling it vote)
    [self setupVoteIconWithVoteVal:hasVote];
    
}

#pragma mark - subclassed methods
- (void)setChromeTitle {
    //[self displayVoteTotal];
}

#pragma mark - NIPagingScrollViewDelegate
- (void)pagingScrollViewDidChangePages:(NIPagingScrollView *)pagingScrollView {
    [super pagingScrollViewDidChangePages:pagingScrollView];
    NSString *imgKey = self.curImageKey;
    [self setupVoteIconWithVoteVal:[[VoteManager defaultManager] hasVoteForImgKey:imgKey]];
}

- (void)submitVoteWithVoteValue:(BOOL)hasVote andImageKey:(NSString *)imageKey {
    NSMutableURLRequest *request =
    [NSMutableURLRequest requestWithURL:[NSURL URLWithString:VOTE_URL_STR]];
    NSString *boundary =
    [NSString stringWithFormat:@"_14737809831466499882%d_",arc4random() % 74];
    
    
    [request addValue:[NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary] forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5" forHTTPHeaderField:@"Accept"];
    
    
    [request setValue:@"PhotoApp iOS" forHTTPHeaderField:@"User-agent"];
    
    [request setHTTPMethod:@"POST"];
    
    NSMutableData *body = [NSMutableData data];
    
    //build body
    
    //separate each form data item with boundary
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Disposition: form-data; name=\"id\"\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"%@", imageKey] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@%@\r\n",boundary, (hasVote) ? @"--" : @""] dataUsingEncoding:NSUTF8StringEncoding]];
    
    if (!hasVote) {
        [body appendData:[@"Content-Disposition: form-data; name=\"unlike\"\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"1" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    [request setHTTPBody:body];
    
    self.curConnection = [NSURLConnection connectionWithRequest:request delegate:self];
}

#pragma mark - NIPhotoAlbumScrollViewDataSource


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSInteger)numberOfPagesInPagingScrollView:(NIPhotoAlbumScrollView *)photoScrollView {
    return [self.photosList count];
}

- (UIImage *)photoAlbumScrollView: (NIPhotoAlbumScrollView *)photoAlbumScrollView
                     photoAtIndex: (NSInteger)photoIndex
                        photoSize: (NIPhotoScrollViewPhotoSize *)photoSize
                        isLoading: (BOOL *)isLoading
          originalPhotoDimensions: (CGSize *)originalPhotoDimensions {
    
    //set up like icon for image
    if (self.photoAlbumView.centerPageIndex == photoIndex) {
        NSString *imgKey = [self imageKeyForIndex:photoIndex];
        [self setupVoteIconWithVoteVal:[[VoteManager defaultManager] hasVoteForImgKey:imgKey]];
    }
    
    NSDictionary *imgDict = (NSDictionary *)[self.photosList objectAtIndex:photoIndex];
    
    NSString *imgThumbStr = [imgDict valueForKey:XML_TAG_THUMB_URL];
    UIImage* image = [[ImageCache sharedImageCache] thumbForKey:imgThumbStr];
    
    *isLoading = YES;

    //set up thumbnail size by default
    *photoSize = NIPhotoScrollViewPhotoSizeThumbnail;
    
    if(!image) {
        //we don't have a thumb so check the cache
        NSString *thumbFilename = [imgThumbStr lastPathComponent];
        if ([[DiskCacheManager defaultManager] existsInCache:thumbFilename]) {
            NSData *data = [[DiskCacheManager defaultManager] retrieveFromCache:thumbFilename];
            image = [UIImage imageWithData:data];
        } else {
            //we don't have a copy of this thumb in
            //the disk cache or image cache so show the defaul image
            image = [UIImage imageWithContentsOfFile:NIPathForBundleResource(nil, @"NimbusPhotos.bundle/gfx/default.png")];;
        }
        
        //*photoSize = NIPhotoScrollViewPhotoSizeThumbnail;
        
    }
    
     //Is this stuff needed?
    
    //TODO: cache large photo as well
    dispatch_queue_t largePhotoQueue = dispatch_queue_create("Large Photo Queue", NULL);
   
    dispatch_async(largePhotoQueue, ^{
        //NSString *fullUrlStr = [imgDict valueForKey:XML_TAG_FULL_URL];
        //NSString *fileName = [fullUrlStr lastPathComponent];
        NSData *imgData = nil;
        
#ifdef USE_DISK_CACHE
        NSString *imageKey = [[imgDict valueForKey:XML_TAG_FULL_URL] lastPathComponent];
        //check disk cache first
        if ([[DiskCacheManager defaultManager] existsInCache:imageKey]) {
            //we found it in the disk cache, lets save the pull from the
            //network and grab it from the disk cache

            imgData = [[DiskCacheManager defaultManager] retrieveFromCache:imageKey];
        } else {
#endif
            //pull it from the network, but then save to the cache
            imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[imgDict valueForKey:XML_TAG_FULL_URL]]];
#ifdef USE_DISK_CACHE
            if (imgData) {
                [[DiskCacheManager defaultManager] saveToCache:imgData withFilename:imageKey];
            }

        }
#endif
        UIImage *loadedImg = [UIImage imageWithData:imgData];
        
        if (loadedImg == nil) {
            NSLog(@"*****PhotDetailView:loadedImg == nil!");
            return;
        }
        
        
        dispatch_async(dispatch_get_main_queue(), ^ {
            
            [self.photoAlbumView didLoadPhoto: loadedImg
                                      atIndex: photoIndex
                                    photoSize: NIPhotoScrollViewPhotoSizeOriginal];
        });
        
        *isLoading = NO;
    });
    
    
    dispatch_release(largePhotoQueue);
        
    
    return image;
}

- (id<NIPagingScrollViewPage>)pagingScrollView:(NIPagingScrollView *)pagingScrollView pageViewForIndex:(NSInteger)pageIndex {
    return [self.photoAlbumView pagingScrollView:pagingScrollView pageViewForIndex:pageIndex];
}

#pragma mark - NSURL delegate methods
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    NSError *error;
    NSDictionary *voteResults;
    
    //NSString *content = [NSString stringWithUTF8String:[data bytes]];
    if (data) {
        voteResults = [NSJSONSerialization JSONObjectWithData:data options:nil error:&error];
    }
    NSLog(@"got vote status:%@ and results:%@",
          voteResults[VOTE_RESULT_STATUS_KEY], voteResults[VOTE_REULST_TOTALS_KEY]);

    NSInteger voteTotal = [voteResults[VOTE_REULST_TOTALS_KEY] integerValue];
    if ([voteResults[VOTE_RESULT_STATUS_KEY] integerValue]) {
        NSLog(@"Vote failed!");
        //TODO: We need to reset or send a message or something???
    } else {
        [self setVoteTitleWithTotal:voteTotal];
    }
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"finished voting");
    
    /*
    UIAlertView *alert =
    [[UIAlertView alloc] initWithTitle:@"Success"
                               message:@"The image has been submitted for approval!"
                              delegate:nil
                     cancelButtonTitle:@"Dismiss"
                     otherButtonTitles:nil];
    [alert show];
    */
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"failed to vote!");
        
    
    UIAlertView *failAlert =
    [[UIAlertView alloc] initWithTitle:@"Vote Failed!"
                               message:[NSString stringWithFormat:@"Your vote could not be recorded! %@", [error localizedDescription]]
                              delegate:nil
                     cancelButtonTitle:@"Close"
                     otherButtonTitles:nil];
    [failAlert show];
    
}


@end
