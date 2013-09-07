//
//  PhotoListParser.m
//  FrederickFilmFestPOC
//
//  Created by Lonny Gomes on 6/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PhotoListParser.h"

@interface PhotoListParser()

- (void)sortByOrder;

@property (nonatomic, retain) NSURL *url;
@property (nonatomic, retain) NSXMLParser *xmlParser;
@property (nonatomic, retain) NSMutableDictionary *curItem;
@property (nonatomic, retain) NSString *curTagName;

@end

@implementation PhotoListParser

@synthesize url = _url;
@synthesize xmlParser = _xmlParser;
@synthesize curItem = _curItem;
@synthesize curTagName = _curTagName;
@synthesize photoList = _photoList;
@synthesize delegate = _delegate;


- (void) dealloc {
    [_url release];
    [_xmlParser release];
    [_curItem release];
    [_curTagName release];
    [_photoList release];
    [super dealloc];
}

- (void)loadURL:(NSURL *)url {
    self.photoList = [[[NSMutableArray alloc] init] autorelease];
    
    //Use Grand Central Dispatcher to load off to a queue
    dispatch_queue_t photoLoaderQueue = dispatch_queue_create("Photo Loader Queue", NULL);
    
    dispatch_async(photoLoaderQueue, ^{
        self.xmlParser = [[[NSXMLParser alloc] initWithContentsOfURL:url] autorelease];
        self.xmlParser.delegate = self;
        [self.xmlParser parse];
    });

    dispatch_release(photoLoaderQueue);
}

- (void)sortByOrder {
    //TODO:
}

#pragma mark - protocols
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    //NSLog(@"tag:%@", elementName);
    
    if ([elementName isEqualToString:XML_TAG_IMAGE]) {
        //begin storing dictionary of files
        self.curItem = [NSMutableDictionary dictionary];
    } else if (![elementName isEqualToString:XML_TAG_ENTRIES]) {
        //read anything else beside the root tag as the start of more data
        self.curTagName = [NSString stringWithString:elementName];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    //finished reading the image tag so add it to array and release it
    if ([elementName isEqualToString:XML_TAG_IMAGE]) {
    
        //only add approved photos
//        NSString *approvedVal = [self.curItem valueForKey:XML_TAG_APPROVED];
//        if ([approvedVal isEqualToString:@"1"]) {
//            [self.photoList addObject:[NSDictionary dictionaryWithDictionary:self.curItem]];
//        }
        
        [self.photoList addObject:[NSDictionary dictionaryWithDictionary:self.curItem]];
        
        self.curItem = nil;
        self.curTagName = nil;
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    //NSLog(@"value:'%@'", string);
    if (self.curTagName && self.curItem) {
        if (![self.curItem valueForKey:self.curTagName]) {
            [self.curItem setObject:[NSString stringWithString:string] forKey:self.curTagName];
        }
    }
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    //make sure the data is sorted by order
    [self sortByOrder];
    
    if ([self.delegate respondsToSelector:@selector(photoListParser:loadCompletedWithData:)]) {
        [self.delegate photoListParser:self loadCompletedWithData:self.photoList];
    }
}
@end
