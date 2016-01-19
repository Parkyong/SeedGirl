/************************************************************
 *  * EaseMob CONFIDENTIAL
 * __________________
 * Copyright (C) 2013-2014 EaseMob Technologies. All rights reserved.
 *
 * NOTICE: All information contained herein is, and remains
 * the property of EaseMob Technologies.
 * Dissemination of this information or reproduction of this material
 * is strictly forbidden unless prior written permission is obtained
 * from EaseMob Technologies.
 */

#import "ConvertToCommonEmoticonsHelper.h"
#import "Emoji.h"

@implementation ConvertToCommonEmoticonsHelper

#pragma mark - emotics
+ (NSString *)convertToCommonEmoticons:(NSString *)text {
    int allEmoticsCount = (int)[Emoji allEmoji].count;
    NSMutableString *retText = [[NSMutableString alloc] initWithString:text];
    for(int i=0; i<allEmoticsCount; ++i) {
        NSRange range;
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue415"
                                 withString:@"[(1)]"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue056"
                                 withString:@"[(2)]"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue057"
                                 withString:@"[(3)]"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue414"
                                 withString:@"[(4)]"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue405"
                                 withString:@"[(5)]"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue106"
                                 withString:@"[(6)]"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue418"
                                 withString:@"[(7)]"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue417"
                                 withString:@"[(8)]"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue40d"
                                 withString:@"[(9)]"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue40a"
                                 withString:@"[(10)]"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue404"
                                 withString:@"[(11)]"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue105"
                                 withString:@"[(12)]"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue409"
                                 withString:@"[(13)]"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue40e"
                                 withString:@"[(14)]"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue402"
                                 withString:@"[(15)]"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue108"
                                 withString:@"[(16)]"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue403"
                                 withString:@"[(17)]"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue058"
                                 withString:@"[(18)]"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue407"
                                 withString:@"[(19)]"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue401"
                                 withString:@"[(20)]"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue40f"
                                 withString:@"[(21)]"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue40b"
                                 withString:@"[(22)]"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue406"
                                 withString:@"[(23)]"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue413"
                                 withString:@"[(24)]"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue411"
                                 withString:@"[(25)]"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue412"
                                 withString:@"[(26)]"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue410"
                                 withString:@"[(27)]"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue107"
                                 withString:@"[(28)]"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue059"
                                 withString:@"[(29)]"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        
        [retText replaceOccurrencesOfString:@"\ue416"
                                 withString:@"[(30)]"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        
        [retText replaceOccurrencesOfString:@"\ue408"
                                 withString:@"[(31)]"
                                    options:NSLiteralSearch
                                      range:range];

        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue40c"
                                 withString:@"[(32)]"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue11a"
                                 withString:@"[(33)]"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue10c"
                                 withString:@"[(34)]"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue32c"
                                 withString:@"[(35)]"
                                    options:NSLiteralSearch
                                      range:range];
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue32a"
                                 withString:@"[(36)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue32d"
                                 withString:@"[(37)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue328"
                                 withString:@"[(38)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue32b"
                                 withString:@"[(39)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue022"
                                 withString:@"[(40)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue023"
                                 withString:@"[(41)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue327"
                                 withString:@"[(42)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue329"
                                 withString:@"[(43)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue32e"
                                 withString:@"[(44)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue32f"
                                 withString:@"[(45)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue335"
                                 withString:@"[(46)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue334"
                                 withString:@"[(47)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue021"
                                 withString:@"[(48)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue337"
                                 withString:@"[(49)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue020"
                                 withString:@"[(50)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue336"
                                 withString:@"[(51)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue13c"
                                 withString:@"[(52)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue330"
                                 withString:@"[(53)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue331"
                                 withString:@"[(54)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue326"
                                 withString:@"[(55)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue03e"
                                 withString:@"[(56)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue11d"
                                 withString:@"[(57)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue05a"
                                 withString:@"[(58)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue00e"
                                 withString:@"[(59)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue421"
                                 withString:@"[(60)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue420"
                                 withString:@"[(61)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue00d"
                                 withString:@"[(62)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue010"
                                 withString:@"[(63)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue011"
                                 withString:@"[(64)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue41e"
                                 withString:@"[(65)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue012"
                                 withString:@"[(66)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue422"
                                 withString:@"[(67)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue22e"
                                 withString:@"[(68)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue22f"
                                 withString:@"[(69)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue231"
                                 withString:@"[(70)]"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue230"
                                 withString:@"[(71)]"
                                    options:NSLiteralSearch
                                      range:range];
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue427"
                                 withString:@"[(72)]"
                                    options:NSLiteralSearch
                                      range:range];
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue41d"
                                 withString:@"[(73)]"
                                    options:NSLiteralSearch
                                      range:range];
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue00f"
                                 withString:@"[(74)]"
                                    options:NSLiteralSearch
                                      range:range];
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue41f"
                                 withString:@"[(75)]"
                                    options:NSLiteralSearch
                                      range:range];
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue14c"
                                 withString:@"[(76)]"
                                    options:NSLiteralSearch
                                      range:range];
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue201"
                                 withString:@"[(77)]"
                                    options:NSLiteralSearch
                                      range:range];
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue115"
                                 withString:@"[(78)]"
                                    options:NSLiteralSearch
                                      range:range];
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue428"
                                 withString:@"[(79)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue51f"
                                 withString:@"[(80)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue429"
                                 withString:@"[(81)]"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue424"
                                 withString:@"[(82)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue423"
                                 withString:@"[(83)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue253"
                                 withString:@"[(84)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue426"
                                 withString:@"[(85)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue111"
                                 withString:@"[(86)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue425"
                                 withString:@"[(87)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue31e"
                                 withString:@"[(88)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue31f"
                                 withString:@"[(89)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue31d"
                                 withString:@"[(90)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue001"
                                 withString:@"[(91)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue002"
                                 withString:@"[(92)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue005"
                                 withString:@"[(93)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue004"
                                 withString:@"[(94)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue51a"
                                 withString:@"[(95)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue519"
                                 withString:@"[(96)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue518"
                                 withString:@"[(97)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue515"
                                 withString:@"[(98)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue516"
                                 withString:@"[(99)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue517"
                                 withString:@"[(100)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue51b"
                                 withString:@"[(101)]"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue152"
                                 withString:@"[(102)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue04e"
                                 withString:@"[(103)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue51c"
                                 withString:@"[(104)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue51e"
                                 withString:@"[(105)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue11c"
                                 withString:@"[(106)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue536"
                                 withString:@"[(107)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue003"
                                 withString:@"[(108)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue41c"
                                 withString:@"[(109)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue41b"
                                 withString:@"[(110)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue419"
                                 withString:@"[(111)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue41a"
                                 withString:@"[(112)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue04a"
                                 withString:@"[(113)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue04b"
                                 withString:@"[(114)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue049"
                                 withString:@"[(115)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue048"
                                 withString:@"[(116)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue04c"
                                 withString:@"[(117)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue13d"
                                 withString:@"[(118)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue443"
                                 withString:@"[(119)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue43e"
                                 withString:@"[(120)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString: @"\ue04f"
                                 withString:@"[(121)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue052"
                                 withString:@"[(122)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue053"
                                 withString:@"[(123)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue524"
                                 withString:@"[(124)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue52c"
                                 withString:@"[(125)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue52a"
                                 withString:@"[(126)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue531"
                                 withString:@"[(127)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue050"
                                 withString:@"[(128)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue527"
                                 withString:@"[(129)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue051"
                                 withString:@"[(130)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue10b"
                                 withString:@"[(131)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue52b"
                                 withString:@"[(132)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue52f"
                                 withString:@"[(133)]"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue528"
                                 withString:@"[(134)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue01a"
                                 withString:@"[(135)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue134"
                                 withString:@"[(136)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue530"
                                 withString:@"[(137)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue529"
                                 withString:@"[(138)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue526"
                                 withString:@"[(139)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue52d"
                                 withString:@"[(140)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue521"
                                 withString:@"[(141)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue523"
                                 withString:@"[(142)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue52e"
                                 withString:@"[(143)]"
                                    options:NSLiteralSearch
                                      range:range];
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue055"
                                 withString:@"[(144)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue525"
                                 withString:@"[(145)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue10a"
                                 withString:@"[(146)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue109"
                                 withString:@"[(147)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue522"
                                 withString:@"[(148)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue019"
                                 withString:@"[(149)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue054"
                                 withString:@"[(150)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue520"
                                 withString:@"[(151)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue306"
                                 withString:@"[(152)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue030"
                                 withString:@"[(153)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue304"
                                 withString:@"[(154)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue110"
                                 withString:@"[(155)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue032"
                                 withString:@"[(156)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue305"
                                 withString:@"[(157)]"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue303"
                                 withString:@"[(158)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue118"
                                 withString:@"[(159)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue447"
                                 withString:@"[(160)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue119"
                                 withString:@"[(161)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue307"
                                 withString:@"[(162)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue308"
                                 withString:@"[(163)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue444"
                                 withString:@"[(164)]"
                                    options:NSLiteralSearch
                                      range:range];

        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"\ue441"
                                 withString:@"[(165)]"
                                    options:NSLiteralSearch
                                      range:range];

    }
    
    return retText;
}

+ (NSString *)convertToSystemEmoticons:(NSString *)text
{
    if (![text isKindOfClass:[NSString class]]) {
        return @"";
    }
    
    if ([text length] == 0) {
        return @"";
    }
    int allEmoticsCount = (int)[[Emoji allEmoji] count];
    NSMutableString *retText = [[NSMutableString alloc] initWithString:text];
    for(int i=0; i<allEmoticsCount; ++i) {
        NSRange range;
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(1)]"
                                 withString:@"\ue415"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(2)]"
                                 withString:@"\ue056"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(3)]"
                                 withString:@"\ue057"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(4)]"
                                 withString:@"\ue414"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(5)]"
                                 withString:@"\ue405"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(6)]"
                                 withString:@"\ue106"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(7)]"
                                 withString:@"\ue418"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(8)]"
                                 withString:@"\ue417"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(9)]"
                                 withString:@"\ue40d"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(10)]"
                                 withString:@"\ue40a"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(11)]"
                                 withString:@"\ue404"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(12)]"
                                 withString:@"\ue105"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(13)]"
                                 withString:@"\ue409"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(14)]"
                                 withString:@"\ue40e"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(15)]"
                                 withString:@"\ue402"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(16)]"
                                 withString:@"\ue108"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(17)]"
                                 withString:@"\ue403"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(18)]"
                                 withString:@"\ue058"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(19)]"
                                 withString:@"\ue407"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(20)]"
                                 withString:@"\ue401"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(21)]"
                                 withString:@"\ue40f"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(22)]"
                                 withString:@"\ue40b"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(23)]"
                                 withString:@"\ue406"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(24)]"
                                 withString:@"\ue413"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(25)]"
                                 withString:@"\ue411"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(26)]"
                                 withString:@"\ue412"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(27)]"
                                 withString:@"\ue410"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(28)]"
                                 withString:@"\ue107"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(29)]"
                                 withString:@"\ue059"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        
        [retText replaceOccurrencesOfString:@"[(30)]"
                                 withString:@"\ue416"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        
        [retText replaceOccurrencesOfString:@"[(31)]"
                                 withString:@"\ue408"
                                    options:NSLiteralSearch
                                      range:range];
        
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(32)]"
                                 withString:@"\ue40c"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(33)]"
                                 withString:@"\ue11a"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(34)]"
                                 withString:@"\ue10c"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(35)]"
                                 withString:@"\ue32c"
                                    options:NSLiteralSearch
                                      range:range];
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(36)]"
                                 withString:@"\ue32a"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(37)]"
                                 withString:@"\ue32d"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(38)]"
                                 withString:@"\ue328"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(39)]"
                                 withString:@"\ue32b"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(40)]"
                                 withString:@"\ue022"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(41)]"
                                 withString:@"\ue023"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(42)]"
                                 withString:@"\ue327"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(43)]"
                                 withString:@"\ue329"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(44)]"
                                 withString:@"\ue32e"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(45)]"
                                 withString:@"\ue32f"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(46)]"
                                 withString:@"\ue335"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(47)]"
                                 withString:@"\ue334"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(48)]"
                                 withString:@"\ue021"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(49)]"
                                 withString:@"\ue337"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(50)]"
                                 withString:@"\ue020"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(51)]"
                                 withString:@"\ue336"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(52)]"
                                 withString:@"\ue13c"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(53)]"
                                 withString:@"\ue330"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(54)]"
                                 withString:@"\ue331"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(55)]"
                                 withString:@"\ue326"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(56)]"
                                 withString:@"\ue03e"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(57)]"
                                 withString:@"\ue11d"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(58)]"
                                 withString:@"\ue05a"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(59)]"
                                 withString:@"\ue00e"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(60)]"
                                 withString:@"\ue421"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(61)]"
                                 withString:@"\ue420"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(62)]"
                                 withString:@"\ue00d"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(63)]"
                                 withString:@"\ue010"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(64)]"
                                 withString:@"\ue011"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(65)]"
                                 withString:@"\ue41e"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(66)]"
                                 withString:@"\ue012"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(67)]"
                                 withString:@"\ue422"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(68)]"
                                 withString:@"\ue22e"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(69)]"
                                 withString:@"\ue22f"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(70)]"
                                 withString:@"\ue231"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(71)]"
                                 withString:@"\ue230"
                                    options:NSLiteralSearch
                                      range:range];
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(72)]"
                                 withString:@"\ue427"
                                    options:NSLiteralSearch
                                      range:range];
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(73)]"
                                 withString:@"\ue41d"
                                    options:NSLiteralSearch
                                      range:range];
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(74)]"
                                 withString:@"\ue00f"
                                    options:NSLiteralSearch
                                      range:range];
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(75)]"
                                 withString:@"\ue41f"
                                    options:NSLiteralSearch
                                      range:range];
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(76)]"
                                 withString:@"\ue14c"
                                    options:NSLiteralSearch
                                      range:range];
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(77)]"
                                 withString:@"\ue201"
                                    options:NSLiteralSearch
                                      range:range];
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(78)]"
                                 withString:@"\ue115"
                                    options:NSLiteralSearch
                                      range:range];
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(79)]"
                                 withString:@"\ue428"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(80)]"
                                 withString:@"\ue51f"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(81)]"
                                 withString:@"\ue429"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(82)]"
                                 withString:@"\ue424"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(83)]"
                                 withString:@"\ue423"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(84)]"
                                 withString:@"\ue253"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(85)]"
                                 withString:@"\ue426"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(86)]"
                                 withString:@"\ue111"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(87)]"
                                 withString:@"\ue425"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(88)]"
                                 withString:@"\ue31e"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(89)]"
                                 withString:@"\ue31f"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(90)]"
                                 withString:@"\ue31d"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(91)]"
                                 withString:@"\ue001"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(92)]"
                                 withString:@"\ue002"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(93)]"
                                 withString:@"\ue005"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(94)]"
                                 withString:@"\ue004"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(95)]"
                                 withString:@"\ue51a"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(96)]"
                                 withString:@"\ue519"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(97)]"
                                 withString:@"\ue518"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(98)]"
                                 withString:@"\ue515"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(99)]"
                                 withString:@"\ue516"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(100)]"
                                 withString:@"\ue517"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(101)]"
                                 withString:@"\ue51b"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(102)]"
                                 withString:@"\ue152"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(103)]"
                                 withString:@"\ue04e"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(104)]"
                                 withString:@"\ue51c"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(105)]"
                                 withString:@"\ue51e"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(106)]"
                                 withString:@"\ue11c"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(107)]"
                                 withString:@"\ue536"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(108)]"
                                 withString:@"\ue003"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(109)]"
                                 withString:@"\ue41c"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(110)]"
                                 withString:@"\ue41b"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(111)]"
                                 withString:@"\ue419"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(112)]"
                                 withString:@"\ue41a"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(113)]"
                                 withString:@"\ue04a"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(114)]"
                                 withString:@"\ue04b"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(115)]"
                                 withString:@"\ue049"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(116)]"
                                 withString:@"\ue048"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(117)]"
                                 withString:@"\ue04c"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(118)]"
                                 withString:@"\ue13d"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(119)]"
                                 withString:@"\ue443"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(120)]"
                                 withString:@"\ue43e"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(121)]"
                                 withString:@"\ue04f"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(122)]"
                                 withString:@"\ue052"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(123)]"
                                 withString:@"\ue053"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(124)]"
                                 withString:@"\ue524"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(125)]"
                                 withString:@"\ue52c"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(126)]"
                                 withString:@"\ue52a"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(127)]"
                                 withString:@"\ue531"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(128)]"
                                 withString:@"\ue050"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(129)]"
                                 withString:@"\ue527"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(130)]"
                                 withString:@"\ue051"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(131)]"
                                 withString:@"\ue10b"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(132)]"
                                 withString:@"\ue52b"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(133)]"
                                 withString:@"\ue52f"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(134)]"
                                 withString:@"\ue528"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(135)]"
                                 withString:@"\ue01a"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(136)]"
                                 withString:@"\ue134"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(137)]"
                                 withString:@"\ue530"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(138)]"
                                 withString:@"\ue529"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(139)]"
                                 withString:@"\ue526"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(140)]"
                                 withString:@"\ue52d"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(141)]"
                                 withString:@"\ue521"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(142)]"
                                 withString:@"\ue523"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(143)]"
                                 withString:@"\ue52e"
                                    options:NSLiteralSearch
                                      range:range];
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(144)]"
                                 withString:@"\ue055"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(145)]"
                                 withString:@"\ue525"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(146)]"
                                 withString:@"\ue10a"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(147)]"
                                 withString:@"\ue109"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(148)]"
                                 withString:@"\ue522"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(149)]"
                                 withString:@"\ue019"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(150)]"
                                 withString:@"\ue054"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(151)]"
                                 withString:@"\ue520"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(152)]"
                                 withString:@"\ue306"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(153)]"
                                 withString:@"\ue030"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(154)]"
                                 withString:@"\ue304"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(155)]"
                                 withString:@"\ue110"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(156)]"
                                 withString:@"\ue032"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(157)]"
                                 withString:@"\ue305"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(158)]"
                                 withString:@"\ue303"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(159)]"
                                 withString:@"\ue118"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(160)]"
                                 withString:@"\ue447"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(161)]"
                                 withString:@"\ue119"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(162)]"
                                 withString:@"\ue307"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(163)]"
                                 withString:@"\ue308"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(164)]"
                                 withString:@"\ue444"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(165)]"
                                 withString:@"\ue441"
                                    options:NSLiteralSearch
                                      range:range];
        
    }
    
    return retText;
}
@end
