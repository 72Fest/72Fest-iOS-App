//
//  VoteManager.h
//  FrederickFilmFestPOC
//
//  Created by Carpe Lucem Media Group on 9/9/13.
//
//

#import <Foundation/Foundation.h>

#define VOTE_MANGER_IMG_KEY @"voteMangerImageKey"
#define VOTE_TOTALS_ID_KEY @"id"
#define VOTE_TOTALS_VOTES_KEY @"votes"

@interface VoteManager : NSObject

+ (VoteManager *)defaultManager;

- (BOOL)toggleVoteForImgKey:(NSString *)imgKey;
- (BOOL)hasVoteForImgKey:(NSString *)imgKey;
- (NSArray *)getVoteTotals;
- (NSInteger)getUpdatedTotalForId:(NSString *)photoId;
@end
