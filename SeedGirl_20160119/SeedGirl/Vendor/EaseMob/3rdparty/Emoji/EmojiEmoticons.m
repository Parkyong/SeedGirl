//
//  EmojiEmoticons.m
//  Emoji
//
//  Created by Aliksandr Andrashuk on 26.10.12.
//  Copyright (c) 2012 Aliksandr Andrashuk. All rights reserved.
//

#import "EmojiEmoticons.h"

@implementation EmojiEmoticons

+ (NSArray *)allCustomEmoticons{
    NSMutableArray *array = [NSMutableArray new];
    NSMutableArray * localAry = [[NSMutableArray alloc] initWithObjects:
                                 [NSString stringWithFormat:@"[):]"],
                                 [NSString stringWithFormat:@"[:D]"],
                                 [NSString stringWithFormat:@"[;)]"],
                                 [NSString stringWithFormat:@"[:-o]"],
                                 [NSString stringWithFormat:@"[:p]"],
                                 [NSString stringWithFormat:@"[(H)]"],
                                 [NSString stringWithFormat:@"[:@]"],
                                 [NSString stringWithFormat:@"[:s]"],
                                 [NSString stringWithFormat:@"[:$]"],
                                 [NSString stringWithFormat:@"[:(]"],
                                 
                                 [NSString stringWithFormat:@"[:'(]"],
                                 [NSString stringWithFormat:@"[:|]"],
                                 [NSString stringWithFormat:@"[(a)]"],
                                 [NSString stringWithFormat:@"[8o|]"],
                                 [NSString stringWithFormat:@"[8-|]"],
                                 [NSString stringWithFormat:@"[+o(]"],
                                 [NSString stringWithFormat:@"[<o)]"],
                                 [NSString stringWithFormat:@"[|-)]"],
                                 [NSString stringWithFormat:@"[*-)]"],
                                 [NSString stringWithFormat:@"[:-#]"],
                                 
                                 [NSString stringWithFormat:@"[:-*]"],
                                 [NSString stringWithFormat:@"[^o)]"],
                                 [NSString stringWithFormat:@"[8-)]"],
                                 [NSString stringWithFormat:@"[(|)]"],
                                 [NSString stringWithFormat:@"[(u)]"],
                                 [NSString stringWithFormat:@"[(S)]"],
                                 [NSString stringWithFormat:@"[(*)]"],
                                 [NSString stringWithFormat:@"[(#)]"],
                                 [NSString stringWithFormat:@"[(R)]"],
                                 [NSString stringWithFormat:@"[({)]"],
                                 
                                 [NSString stringWithFormat:@"[(})]"],
                                 [NSString stringWithFormat:@"[(k)]"],
                                 [NSString stringWithFormat:@"[(F)]"],
                                 [NSString stringWithFormat:@"[(W)]"],
                                 [NSString stringWithFormat:@"[(35)]"],
                                 [NSString stringWithFormat:@"[(36)]"],
                                 [NSString stringWithFormat:@"[(37)]"],
                                 [NSString stringWithFormat:@"[(38)]"],
                                 [NSString stringWithFormat:@"[(39)]"],
                                 
                                 [NSString stringWithFormat:@"[(40)]"],
                                 [NSString stringWithFormat:@"[(41)]"],
                                 [NSString stringWithFormat:@"[(42)]"],
                                 [NSString stringWithFormat:@"[(43)]"],
                                 [NSString stringWithFormat:@"[(44)]"],
                                 [NSString stringWithFormat:@"[(45)]"],
                                 [NSString stringWithFormat:@"[(46)]"],
                                 [NSString stringWithFormat:@"[(47)]"],
                                 [NSString stringWithFormat:@"[(48)]"],
                                 [NSString stringWithFormat:@"[(49)]"],
                                 
                                 [NSString stringWithFormat:@"[(50)]"],
                                 [NSString stringWithFormat:@"[(51)]"],
                                 [NSString stringWithFormat:@"[(52)]"],
                                 [NSString stringWithFormat:@"[(53)]"],
                                 [NSString stringWithFormat:@"[(54)]"],
                                 [NSString stringWithFormat:@"[(55)]"],
                                 [NSString stringWithFormat:@"[(56)]"],
                                 [NSString stringWithFormat:@"[(57)]"],
                                 [NSString stringWithFormat:@"[(58)]"],
                                 [NSString stringWithFormat:@"[(59)]"],
                                 
                                 [NSString stringWithFormat:@"[(60)]"],
                                 [NSString stringWithFormat:@"[(61)]"],
                                 [NSString stringWithFormat:@"[(62)]"],
                                 [NSString stringWithFormat:@"[(63)]"],
                                 [NSString stringWithFormat:@"[(64)]"],
                                 [NSString stringWithFormat:@"[(65)]"],
                                 [NSString stringWithFormat:@"[(66)]"],
                                 [NSString stringWithFormat:@"[(67)]"],
                                 [NSString stringWithFormat:@"[(68)]"],
                                 [NSString stringWithFormat:@"[(69)]"],
                                 
                                 [NSString stringWithFormat:@"[(70)]"],
                                 [NSString stringWithFormat:@"[(71)]"],
                                 [NSString stringWithFormat:@"[(72)]"],
                                 [NSString stringWithFormat:@"[(73)]"],
                                 [NSString stringWithFormat:@"[(74)]"],
                                 [NSString stringWithFormat:@"[(75)]"],
                                 [NSString stringWithFormat:@"[(76)]"],
                                 [NSString stringWithFormat:@"[(77)]"],
                                 [NSString stringWithFormat:@"[(78)]"],
                                 [NSString stringWithFormat:@"[(79)]"],

                                 [NSString stringWithFormat:@"[(80)]"],
                                 [NSString stringWithFormat:@"[(81)]"],
                                 [NSString stringWithFormat:@"[(82)]"],
                                 [NSString stringWithFormat:@"[(83)]"],
                                 [NSString stringWithFormat:@"[(84)]"],
                                 nil];
    [array addObjectsFromArray:localAry];
    return array;
}

+ (NSArray *)allEmoticons {
    NSMutableArray *array = [NSMutableArray new];
    NSMutableArray * localAry = [NSMutableArray arrayWithObjects:
                                 @"\ue415",
                                 @"\ue056",
                                 @"\ue057",
                                 @"\ue414",
                                 @"\ue405",
                                 @"\ue106",
                                 @"\ue418",
                                 
                                 @"\ue417",
                                 @"\ue40d",
                                 @"\ue40a",
                                 @"\ue404",
                                 @"\ue105",
                                 @"\ue409",
                                 @"\ue40e",
                                 
                                 @"\ue402",
                                 @"\ue108",
                                 @"\ue403",
                                 @"\ue058",
                                 @"\ue407",
                                 @"\ue401",
                                 @"\ue40f",
                                 
                                 @"\ue40b",
                                 @"\ue406",
                                 @"\ue413",
                                 @"\ue411",
                                 @"\ue412",
                                 @"\ue410",
                                 @"\ue107",
                                 
                                 @"\ue059",
                                 @"\ue416",
                                 @"\ue408",
                                 @"\ue40c",
                                 @"\ue11a",
                                 @"\ue10c",
                                 @"\ue32c",
                                 
                                 @"\ue32a",
                                 @"\ue32d",
                                 @"\ue328",
                                 @"\ue32b",
                                 @"\ue022",
                                 @"\ue023",
                                 @"\ue327",
                                 
                                 @"\ue329",
                                 @"\ue32e",
                                 @"\ue32f",
                                 @"\ue335",
                                 @"\ue334",
                                 @"\ue021",
                                 @"\ue337",
                                 
                                 @"\ue020",
                                 @"\ue336",
                                 @"\ue13c",
                                 @"\ue330",
                                 @"\ue331",
                                 @"\ue326",
                                 @"\ue03e",
                                 
                                 @"\ue11d",
                                 @"\ue05a",
                                 @"\ue00e",
                                 @"\ue421",
                                 @"\ue420",
                                 @"\ue00d",
                                 @"\ue010",
                                 
                                 @"\ue011",
                                 @"\ue41e",
                                 @"\ue012",
                                 @"\ue422",
                                 @"\ue22e",
                                 @"\ue22f",
                                 @"\ue231",
                                 
                                 @"\ue230",
                                 @"\ue427",
                                 @"\ue41d",
                                 @"\ue00f",
                                 @"\ue41f",
                                 @"\ue14c",
                                 @"\ue201",
                                 @"\ue115",
                                 
                                 @"\ue428",
                                 @"\ue51f",
                                 @"\ue429",
                                 @"\ue424",
                                 @"\ue423",
                                 @"\ue253",
                                 @"\ue426",
                                 
                                 @"\ue111",
                                 @"\ue425",
                                 @"\ue31e",
                                 @"\ue31f",
                                 @"\ue31d",
                                 @"\ue001",
                                 @"\ue002",
                                 
                                 @"\ue005",
                                 @"\ue004",
                                 @"\ue51a",
                                 @"\ue519",
                                 @"\ue518",
                                 @"\ue515",
                                 @"\ue516",
                                 
                                 @"\ue517",
                                 @"\ue51b",
                                 @"\ue152",
                                 @"\ue04e",
                                 @"\ue51c",
                                 @"\ue51e",
                                 @"\ue11c",
                                 
                                 @"\ue536",
                                 @"\ue003",
                                 @"\ue41c",
                                 @"\ue41b",
                                 @"\ue419",
                                 @"\ue41a",
                                 @"\ue04a",
                                 
                                 @"\ue04b",
                                 @"\ue049",
                                 @"\ue048",
                                 @"\ue04c",
                                 @"\ue13d",
                                 @"\ue443",
                                 @"\ue43e",
                                 
                                 @"\ue04f",
                                 @"\ue052",
                                 @"\ue053",
                                 @"\ue524",
                                 @"\ue52c",
                                 @"\ue52a",
                                 @"\ue531",
                                 
                                 @"\ue050",
                                 @"\ue527",
                                 @"\ue051",
                                 @"\ue10b",
                                 @"\ue52b",
                                 @"\ue52f",
                                 @"\ue528",
                                 
                                 @"\ue01a",
                                 @"\ue134",
                                 @"\ue530",
                                 @"\ue529",
                                 @"\ue526",
                                 @"\ue52d",
                                 @"\ue521",
                                 
                                 @"\ue523",
                                 @"\ue52e",
                                 @"\ue055",
                                 @"\ue525",
                                 @"\ue10a",
                                 @"\ue109",
                                 @"\ue522",
                                 
                                 @"\ue019",
                                 @"\ue054",
                                 @"\ue520",
                                 @"\ue306",
                                 @"\ue030",
                                 @"\ue304",
                                 @"\ue110",
                                 
                                 @"\ue032",
                                 @"\ue305",
                                 @"\ue303",
                                 @"\ue118",
                                 @"\ue447",
                                 @"\ue119",
                                 @"\ue307",
                                 @"\ue308",
                                 @"\ue444",
                                 @"\ue441",
                                 nil];
    [array addObjectsFromArray:localAry];
    return array;

}


//+ (NSArray *)allEmoticons {
//    NSMutableArray *array = [NSMutableArray new];
//    NSMutableArray * localAry = [[NSMutableArray alloc] initWithObjects:
//                                 [Emoji emojiWithCode:0x1F600],
//                                 [Emoji emojiWithCode:0x1F601],
//                                 [Emoji emojiWithCode:0x1F602],
//                                 [Emoji emojiWithCode:0x1F603],
//                                 [Emoji emojiWithCode:0x1F604],
//                                 [Emoji emojiWithCode:0x1F605],
//                                 [Emoji emojiWithCode:0x1F606],
//                                 [Emoji emojiWithCode:0x1F607],
//                                 [Emoji emojiWithCode:0x1F608],
//                                 [Emoji emojiWithCode:0x1F609],
//                                 [Emoji emojiWithCode:0x1F60a],
//                                 [Emoji emojiWithCode:0x1F60b],
//                                 [Emoji emojiWithCode:0x1F60c],
//                                 [Emoji emojiWithCode:0x1F60d],
//                                 [Emoji emojiWithCode:0x1F60e],
//                                 [Emoji emojiWithCode:0x1F60f],//16
//                                 
//                                 [Emoji emojiWithCode:0x1F610],
//                                 [Emoji emojiWithCode:0x1F611],
//                                 [Emoji emojiWithCode:0x1F612],
//                                 [Emoji emojiWithCode:0x1F613],
//                                 [Emoji emojiWithCode:0x1F614],
//                                 [Emoji emojiWithCode:0x1F615],
//                                 [Emoji emojiWithCode:0x1F616],
//                                 [Emoji emojiWithCode:0x1F617],
//                                 [Emoji emojiWithCode:0x1F618],
//                                 [Emoji emojiWithCode:0x1F619],
//                                 [Emoji emojiWithCode:0x1F61a],
//                                 [Emoji emojiWithCode:0x1F61b],
//                                 [Emoji emojiWithCode:0x1F61c],
//                                 [Emoji emojiWithCode:0x1F61d],
//                                 [Emoji emojiWithCode:0x1F61e],
//                                 [Emoji emojiWithCode:0x1F61f],//32
//                                 
//                                 [Emoji emojiWithCode:0x1F620],
//                                 [Emoji emojiWithCode:0x1F621],
//                                 [Emoji emojiWithCode:0x1F622],
//                                 [Emoji emojiWithCode:0x1F623],
//                                 [Emoji emojiWithCode:0x1F624],
//                                 [Emoji emojiWithCode:0x1F625],
//                                 [Emoji emojiWithCode:0x1F626],
//                                 [Emoji emojiWithCode:0x1F627],
//                                 [Emoji emojiWithCode:0x1F628],
//                                 [Emoji emojiWithCode:0x1F629],
//                                 [Emoji emojiWithCode:0x1F62a],
//                                 [Emoji emojiWithCode:0x1F62b],
//                                 [Emoji emojiWithCode:0x1F62c],
//                                 [Emoji emojiWithCode:0x1F62d],
//                                 [Emoji emojiWithCode:0x1F62e],
//                                 [Emoji emojiWithCode:0x1F62f],//48
//                                 
//                                 [Emoji emojiWithCode:0x1F630],
//                                 [Emoji emojiWithCode:0x1F632],
//                                 [Emoji emojiWithCode:0x1F633],
//                                 [Emoji emojiWithCode:0x1F634],
//                                 [Emoji emojiWithCode:0x1F635],
//                                 [Emoji emojiWithCode:0x1F636],
//                                 [Emoji emojiWithCode:0x1F637],
//                                 [Emoji emojiWithCode:0x1F638],
//                                 [Emoji emojiWithCode:0x1F639],
//                                 [Emoji emojiWithCode:0x1F63a],
//                                 [Emoji emojiWithCode:0x1F63b],
//                                 [Emoji emojiWithCode:0x1F63c],
//                                 [Emoji emojiWithCode:0x1F63d],
//                                 [Emoji emojiWithCode:0x1F63e],
//                                 [Emoji emojiWithCode:0x1F63f],//64
//                                 
////                                 [Emoji emojiWithCode:0x1F640],
////                                 [Emoji emojiWithCode:0x1F641],
////                                 [Emoji emojiWithCode:0x1F642],
////                                 [Emoji emojiWithCode:0x1F643],
////                                 [Emoji emojiWithCode:0x1F644],
//                                 [Emoji emojiWithCode:0x1F645],
//                                 [Emoji emojiWithCode:0x1F646],
//                                 [Emoji emojiWithCode:0x1F647],
//                                 [Emoji emojiWithCode:0x1F648],
//                                 [Emoji emojiWithCode:0x1F649],
//                                 [Emoji emojiWithCode:0x1F64a],
//                                 [Emoji emojiWithCode:0x1F64b],
//                                 [Emoji emojiWithCode:0x1F64c],
//                                 [Emoji emojiWithCode:0x1F64d],
//                                 [Emoji emojiWithCode:0x1F64e],
//                                 [Emoji emojiWithCode:0x1F64f],
//
//
//                                 [Emoji emojiWithCode:0x1F311],
//                                 [Emoji emojiWithCode:0x1F312],
//                                 [Emoji emojiWithCode:0x1F313],
//                                 [Emoji emojiWithCode:0x1F314],
//                                 [Emoji emojiWithCode:0x1F315],
//                                 [Emoji emojiWithCode:0x1F316],
//                                 [Emoji emojiWithCode:0x1F317],
//                                 [Emoji emojiWithCode:0x1F318],
//                                 [Emoji emojiWithCode:0x1F319],
//                                 [Emoji emojiWithCode:0x1F31a],
//                                 [Emoji emojiWithCode:0x1F31b],
//                                 [Emoji emojiWithCode:0x1F31c],
//                                 [Emoji emojiWithCode:0x1F31d],
//                                 [Emoji emojiWithCode:0x1F31e],
//                                 [Emoji emojiWithCode:0x1F31f],
//                                 
//                                 
//                                 
//                                 
////                                 [Emoji emojiWithCode:0x1F320],
////                                 [Emoji emojiWithCode:0x1F321],
////                                 [Emoji emojiWithCode:0x1F322],
////                                 [Emoji emojiWithCode:0x1F323],
////                                 [Emoji emojiWithCode:0x1F324],
////                                 [Emoji emojiWithCode:0x1F325],
////                                 [Emoji emojiWithCode:0x1F326],
////                                 [Emoji emojiWithCode:0x1F327],
////                                 [Emoji emojiWithCode:0x1F328],
////                                 [Emoji emojiWithCode:0x1F329],
////                                 [Emoji emojiWithCode:0x1F32a],
////                                 [Emoji emojiWithCode:0x1F32b],
////                                 [Emoji emojiWithCode:0x1F32c],
////                                 [Emoji emojiWithCode:0x1F32d],
////                                 [Emoji emojiWithCode:0x1F32e],
////                                 [Emoji emojiWithCode:0x1F32f],
//
////                                 [Emoji emojiWithCode:0x1F330],
////                                 [Emoji emojiWithCode:0x1F331],
////                                 [Emoji emojiWithCode:0x1F332],
////                                 [Emoji emojiWithCode:0x1F333],
////                                 [Emoji emojiWithCode:0x1F334],
////                                 [Emoji emojiWithCode:0x1F335],
////                                 [Emoji emojiWithCode:0x1F336],
////                                 [Emoji emojiWithCode:0x1F337],
////                                 [Emoji emojiWithCode:0x1F338],
////                                 [Emoji emojiWithCode:0x1F339],
////                                 [Emoji emojiWithCode:0x1F33a],
////                                 [Emoji emojiWithCode:0x1F33b],
////                                 [Emoji emojiWithCode:0x1F33c],
////                                 [Emoji emojiWithCode:0x1F33d],
////                                 [Emoji emojiWithCode:0x1F33e],
////                                 [Emoji emojiWithCode:0x1F33f],
//                                 
//                                 
//                                 
//                                 [Emoji emojiWithCode:0x1F385],
//                                 [Emoji emojiWithCode:0x1F496],
//                                 [Emoji emojiWithCode:0x1F494],
//                                 [Emoji emojiWithCode:0x1F308],
//                                 [Emoji emojiWithCode:0x1F48b],
//                                 [Emoji emojiWithCode:0x1F339],
//                                 [Emoji emojiWithCode:0x1F342],
//                                 [Emoji emojiWithCode:0x1F44d],
//                                 
////                                 [Emoji emojiWithCode:0x1F602],
////                                  [Emoji emojiWithCode:0x1F603],
////                                  [Emoji emojiWithCode:0x1F604],
////                                  [Emoji emojiWithCode:0x1F609],
////                                  [Emoji emojiWithCode:0x1F613],
////                                  [Emoji emojiWithCode:0x1F614],
////                                  [Emoji emojiWithCode:0x1F616],
////                                  [Emoji emojiWithCode:0x1F618],
////                                  [Emoji emojiWithCode:0x1F61a],
////                                  [Emoji emojiWithCode:0x1F61c],
////                                  [Emoji emojiWithCode:0x1F61d],
////                                  [Emoji emojiWithCode:0x1F61e],
////                                  [Emoji emojiWithCode:0x1F620],
////                                  [Emoji emojiWithCode:0x1F621],
////                                  [Emoji emojiWithCode:0x1F622],
////                                  [Emoji emojiWithCode:0x1F623],
////                                  [Emoji emojiWithCode:0x1F628],
////                                  [Emoji emojiWithCode:0x1F62a],
////                                  [Emoji emojiWithCode:0x1F62d],
////                                  [Emoji emojiWithCode:0x1F630],
////                                  [Emoji emojiWithCode:0x1F631],
////                                  [Emoji emojiWithCode:0x1F632],
////                                  [Emoji emojiWithCode:0x1F633],
////                                  [Emoji emojiWithCode:0x1F645],
////                                  [Emoji emojiWithCode:0x1F646],
////                                  [Emoji emojiWithCode:0x1F647],
////                                  [Emoji emojiWithCode:0x1F64c],
////                                  [Emoji emojiWithCode:0x1F6a5],
////                                  [Emoji emojiWithCode:0x1F6a7],
////                                  [Emoji emojiWithCode:0x1F6b2],
////                                  [Emoji emojiWithCode:0x1F6b6],
////                                  [Emoji emojiWithCode:0x1F302],
////                                  [Emoji emojiWithCode:0x1F319],
////                                  [Emoji emojiWithCode:0x1F31f],
//                                 nil];
//    [array addObjectsFromArray:localAry];
//    //    for (int i=0x1F600; i<=0x1F64F; i++) {
//    //        if (i < 0x1F641 || i > 0x1F644) {
//    //            [array addObject:[Emoji emojiWithCode:i]];
//    //        }
//    //    }
//    return array;
//}

EMOJI_METHOD(grinningFace,1F600);
EMOJI_METHOD(grinningFaceWithSmilingEyes,1F601);
EMOJI_METHOD(faceWithTearsOfJoy,1F602);
EMOJI_METHOD(smilingFaceWithOpenMouth,1F603);
EMOJI_METHOD(smilingFaceWithOpenMouthAndSmilingEyes,1F604);
EMOJI_METHOD(smilingFaceWithOpenMouthAndColdSweat,1F605);
EMOJI_METHOD(smilingFaceWithOpenMouthAndTightlyClosedEyes,1F606);
EMOJI_METHOD(smilingFaceWithHalo,1F607);
EMOJI_METHOD(smilingFaceWithHorns,1F608);
EMOJI_METHOD(winkingFace,1F609);
EMOJI_METHOD(smilingFaceWithSmilingEyes,1F60A);
EMOJI_METHOD(faceSavouringDeliciousFood,1F60B);
EMOJI_METHOD(relievedFace,1F60C);
EMOJI_METHOD(smilingFaceWithHeartShapedEyes,1F60D);
EMOJI_METHOD(smilingFaceWithSunglasses,1F60E);
EMOJI_METHOD(smirkingFace,1F60F);
EMOJI_METHOD(neutralFace,1F610);
EMOJI_METHOD(expressionlessFace,1F611);
EMOJI_METHOD(unamusedFace,1F612);
EMOJI_METHOD(faceWithColdSweat,1F613);
EMOJI_METHOD(pensiveFace,1F614);
EMOJI_METHOD(confusedFace,1F615);
EMOJI_METHOD(confoundedFace,1F616);
EMOJI_METHOD(kissingFace,1F617);
EMOJI_METHOD(faceThrowingAKiss,1F618);
EMOJI_METHOD(kissingFaceWithSmilingEyes,1F619);
EMOJI_METHOD(kissingFaceWithClosedEyes,1F61A);
EMOJI_METHOD(faceWithStuckOutTongue,1F61B);
EMOJI_METHOD(faceWithStuckOutTongueAndWinkingEye,1F61C);
EMOJI_METHOD(faceWithStuckOutTongueAndTightlyClosedEyes,1F61D);
EMOJI_METHOD(disappointedFace,1F61E);
EMOJI_METHOD(worriedFace,1F61F);
EMOJI_METHOD(angryFace,1F620);
EMOJI_METHOD(poutingFace,1F621);
EMOJI_METHOD(cryingFace,1F622);
EMOJI_METHOD(perseveringFace,1F623);
EMOJI_METHOD(faceWithLookOfTriumph,1F624);
EMOJI_METHOD(disappointedButRelievedFace,1F625);
EMOJI_METHOD(frowningFaceWithOpenMouth,1F626);
EMOJI_METHOD(anguishedFace,1F627);
EMOJI_METHOD(fearfulFace,1F628);
EMOJI_METHOD(wearyFace,1F629);
EMOJI_METHOD(sleepyFace,1F62A);
EMOJI_METHOD(tiredFace,1F62B);
EMOJI_METHOD(grimacingFace,1F62C);
EMOJI_METHOD(loudlyCryingFace,1F62D);
EMOJI_METHOD(faceWithOpenMouth,1F62E);
EMOJI_METHOD(hushedFace,1F62F);
EMOJI_METHOD(faceWithOpenMouthAndColdSweat,1F630);
EMOJI_METHOD(faceScreamingInFear,1F631);
EMOJI_METHOD(astonishedFace,1F632);
EMOJI_METHOD(flushedFace,1F633);
EMOJI_METHOD(sleepingFace,1F634);
EMOJI_METHOD(dizzyFace,1F635);
EMOJI_METHOD(faceWithoutMouth,1F636);
EMOJI_METHOD(faceWithMedicalMask,1F637);
EMOJI_METHOD(grinningCatFaceWithSmilingEyes,1F638);
EMOJI_METHOD(catFaceWithTearsOfJoy,1F639);
EMOJI_METHOD(smilingCatFaceWithOpenMouth,1F63A);
EMOJI_METHOD(smilingCatFaceWithHeartShapedEyes,1F63B);
EMOJI_METHOD(catFaceWithWrySmile,1F63C);
EMOJI_METHOD(kissingCatFaceWithClosedEyes,1F63D);
EMOJI_METHOD(poutingCatFace,1F63E);
EMOJI_METHOD(cryingCatFace,1F63F);
EMOJI_METHOD(wearyCatFace,1F640);
EMOJI_METHOD(faceWithNoGoodGesture,1F645);
EMOJI_METHOD(faceWithOkGesture,1F646);
EMOJI_METHOD(personBowingDeeply,1F647);
EMOJI_METHOD(seeNoEvilMonkey,1F648);
EMOJI_METHOD(hearNoEvilMonkey,1F649);
EMOJI_METHOD(speakNoEvilMonkey,1F64A);
EMOJI_METHOD(happyPersonRaisingOneHand,1F64B);
EMOJI_METHOD(personRaisingBothHandsInCelebration,1F64C);
EMOJI_METHOD(personFrowning,1F64D);
EMOJI_METHOD(personWithPoutingFace,1F64E);
EMOJI_METHOD(personWithFoldedHands,1F64F);
@end
