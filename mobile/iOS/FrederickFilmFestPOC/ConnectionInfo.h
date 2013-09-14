//
//  ConnectionInfo.h
//  FrederickFilmFestPOC
//
//  Created by Lonny Gomes on 7/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#ifndef FrederickFilmFestPOC_ConnectionInfo_h
#define FrederickFilmFestPOC_ConnectionInfo_h
//URL Macros
#define BASE_URL @"http://54.227.130.170/photoapp"
#define GEN_URL(URL) [NSString stringWithFormat:@"%@/%@", BASE_URL, URL]

//URL definitions
#define COUNTDOWN_METADATA_URL GEN_URL(@"countDown.php")
#define PHOTO_LIST_URL_STR GEN_URL(@"getImagesJs.php")
#define UPLOAD_URL_STR  GEN_URL(@"submit.php")
#define VOTE_URL_STR  GEN_URL(@"vote.php")
#define VOTE_TOTALS_URL_STR GEN_URL(@"getVotes.php")
//macro to generate a string to retrieve vote totals for a given id
#define VOTE_TOTALS_URL_FOR_ID(PHOTO_ID) [NSString stringWithFormat:@"%@?id=%@", VOTE_TOTALS_URL_STR, PHOTO_ID]

//Other links
#define EMAIL_URL_STR @"http://www.72fest.com/about/contact/"
#define DESIGN_URL_STR @"http://www.jbokim.com"
#define MAIN_URL_STR @"http://www.72fest.com"

#endif
