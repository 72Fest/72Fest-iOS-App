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

@interface PhotoDetailViewController ()

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

- (void)dealloc {
    [_photosList release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
    self.photoAlbumView.dataSource = self;
    self.photoAlbumView.delegate = self;
    
    //load up all the data
    [self.photoAlbumView reloadData];
    
    //jump to the selected photo
    [self.photoAlbumView moveToPageAtIndex:self.selectedPhotIndex animated:NO];
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

#pragma mark -
#pragma mark NIPhotoAlbumScrollViewDataSource


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSInteger)numberOfPagesInPagingScrollView:(NIPhotoAlbumScrollView *)photoScrollView {
    return [self.photosList count];
}

- (UIImage *)photoAlbumScrollView: (NIPhotoAlbumScrollView *)photoAlbumScrollView
                     photoAtIndex: (NSInteger)photoIndex
                        photoSize: (NIPhotoScrollViewPhotoSize *)photoSize
                        isLoading: (BOOL *)isLoading
          originalPhotoDimensions: (CGSize *)originalPhotoDimensions {
        
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
    
    [imgDict retain]; //Is this stuff needed?
    
    //TODO: cache large photo as well
    dispatch_queue_t largePhotoQueue = dispatch_queue_create("Large Photo Queue", NULL);
    
    NIPhotoAlbumScrollView *albumViewRef = self.photoAlbumView;
    __block NSData *imgData = nil;
    dispatch_async(largePhotoQueue, ^{
        //NSString *fullUrlStr = [imgDict valueForKey:XML_TAG_FULL_URL];
        //NSString *fileName = [fullUrlStr lastPathComponent];
        
        
        //check disk cache first
        if ([[DiskCacheManager defaultManager] existsInCache:[[imgDict valueForKey:XML_TAG_FULL_URL] lastPathComponent]]) {
            //we found it in the disk cache, lets save the pull from the
            //network and grab it from the disk cache
            imgData = [[DiskCacheManager defaultManager] retrieveFromCache:[[imgDict valueForKey:XML_TAG_FULL_URL] lastPathComponent]];
            if (imgData) {
                [imgData retain];
            }
        } else {
            //pull it from the network, but then save to the cache
            imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[imgDict valueForKey:XML_TAG_FULL_URL]]];
            
            if (imgData) {
                [imgData retain];
                [[DiskCacheManager defaultManager] saveToCache:imgData withFilename:[[imgDict valueForKey:XML_TAG_FULL_URL] lastPathComponent]];
            }
        }

        UIImage *loadedImg = [UIImage imageWithData:imgData];
        
        if (loadedImg == nil) {
            NSLog(@"*****PhotDetailView:loadedImg == nil!");
            [imgData release];
            return;
        }
        
        [imgData release];
        [loadedImg retain];
        
        dispatch_async(dispatch_get_main_queue(), ^ {
            
            [albumViewRef didLoadPhoto: loadedImg
                                      atIndex: photoIndex
                                    photoSize: NIPhotoScrollViewPhotoSizeOriginal];
        });
        
        [loadedImg release];
        *isLoading = NO;
    });
    
    [imgDict release];
    
    dispatch_release(largePhotoQueue);
        
    
    return image;
}

- (id<NIPagingScrollViewPage>)pagingScrollView:(NIPagingScrollView *)pagingScrollView pageViewForIndex:(NSInteger)pageIndex {
    return [self.photoAlbumView pagingScrollView:pagingScrollView pageViewForIndex:pageIndex];
}

@end
