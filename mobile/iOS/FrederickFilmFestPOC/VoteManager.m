//
//  VoteManager.m
//  FrederickFilmFestPOC
//
//  Created by Carpe Lucem Media Group on 9/9/13.
//
//

#import "VoteManager.h"

static VoteManager *_voteManager;

@interface VoteManager()
- (id)initVoteData;
@property (nonatomic, strong) NSUserDefaults *defaults;
@property (nonatomic, strong) NSMutableDictionary *votesDict;
@end
@implementation VoteManager

+ (VoteManager *)defaultManager {
    if (!_voteManager) {
        _voteManager = [[VoteManager alloc] initVoteData];
    }
    
    return _voteManager;
}

- (id)initVoteData {
    
    self = [super init];
    if (self) {
        self.defaults = [NSUserDefaults standardUserDefaults];
        self.votesDict = [[self.defaults dictionaryForKey:VOTE_MANGER_IMG_KEY] mutableCopy];
        
        if (!self.votesDict)
            self.votesDict = [[NSMutableDictionary alloc] init];

    }
    
    return self;
}

- (BOOL)toggleVoteForImgKey:(NSString *)imgKey {
    BOOL hasVote;

    if ([self hasVoteForImgKey:imgKey]) {
        [self.votesDict removeObjectForKey:imgKey];
        hasVote = NO;
    } else {
        [self.votesDict setValue:@"YES" forKey:imgKey];
        hasVote = YES;
    }
    
    //sync the changes to the settings cache
    //TODO: should this be added into a queue?
    [self.defaults setObject:self.votesDict forKey:VOTE_MANGER_IMG_KEY];
    [self.defaults synchronize];
    
    return hasVote;
}

- (BOOL)hasVoteForImgKey:(NSString *)imgKey {
    return ([self.votesDict valueForKey:imgKey] != nil) ? YES : NO;
}

@end
