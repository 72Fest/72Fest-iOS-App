//
//  VoteManager.m
//  FrederickFilmFestPOC
//
//  Created by Carpe Lucem Media Group on 9/9/13.
//
//

#import "VoteManager.h"
#import "ConnectionInfo.h"

@interface VoteManager()
- (id)initVoteData;
@property (nonatomic, strong) NSUserDefaults *defaults;
@property (nonatomic, strong) NSMutableDictionary *votesDict;
@property (nonatomic, strong) NSMutableDictionary *voteTotalsDict;
@end
@implementation VoteManager

+ (VoteManager *)defaultManager {
    static VoteManager *_voteManager = nil;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        _voteManager = [[VoteManager alloc] initVoteData];
    });
    
    return _voteManager;
}

- (id)initVoteData {
    
    self = [super init];
    if (self) {
        self.defaults = [NSUserDefaults standardUserDefaults];
        self.votesDict = [[self.defaults dictionaryForKey:VOTE_MANGER_IMG_KEY] mutableCopy];
        
        if (!self.votesDict)
            self.votesDict = [[NSMutableDictionary alloc] init];

        self.voteTotalsDict = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

#pragma mark - internal vote methods
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

#pragma mark - vote
- (NSArray *)getVoteTotals {
    NSData *data=[NSData dataWithContentsOfURL:[NSURL URLWithString:VOTE_TOTALS_URL_STR]];
    
    NSError *err = nil;
    NSArray *totalsArray = [NSJSONSerialization JSONObjectWithData:data options: nil error: &err];
    
    //clear out the current dictionary
    [self.voteTotalsDict removeAllObjects];
    for (NSDictionary *curVoteData in totalsArray) {
        [self.voteTotalsDict setObject:curVoteData[VOTE_TOTALS_VOTES_KEY] forKey:curVoteData[VOTE_TOTALS_ID_KEY]];
    }

    return totalsArray;
}

- (NSInteger)getUpdatedTotalForId:(NSString *)photoId {
    NSString *url = VOTE_TOTALS_URL_FOR_ID(photoId);
    NSData *data=[NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    
    NSError *err = nil;
    NSArray *totalsArray = [NSJSONSerialization JSONObjectWithData:data options: nil error: &err];
    
    NSInteger voteTotal = 0;
    if (totalsArray.count) {
        NSNumber *voteNum = [totalsArray[0] valueForKey:VOTE_TOTALS_VOTES_KEY];
        voteTotal = [voteNum integerValue];
    }
    
    return voteTotal;
}

@end
